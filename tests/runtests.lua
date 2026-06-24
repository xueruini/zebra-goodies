#!/usr/bin/env texlua
-- tests/runtests.lua
--
-- Behavioural regression runner for the zebra package.  Run from the
-- repository root:
--
--     texlua tests/runtests.lua
--
-- Each tests/*.tex is compiled three times with pdflatex (the dedup
-- machinery needs the .aux round-trip to converge) and the FINAL pass'
-- log is scanned for failure signatures.  The article-class tests
-- assert their own expected note counts through tests/zebra-test.tex; a
-- failed assertion raises a LaTeX error that the "^!" check catches.
-- The template-* tests carry no assertions and act as smoke tests.
--
-- No golden log files are compared, so the suite is stable across TeX
-- distributions and kernel versions -- only behaviour (note counts) and
-- error signatures are checked, not exact output.

local windows = (os.type == "windows")
local sep = windows and ";" or ":"
local nul = windows and "NUL" or "/dev/null"

local testdir = "tests"
local outdir = "out"          -- zebra.sty lives here after a build
local scratch = outdir .. "/test"

-- Tests allowed to emit a "Package zebra Warning" (e.g. the deliberate
-- duplicate-label warning) without failing.
local allow_zebra_warning = {
  ["identity"] = true,
  ["template-acm-sigconf"] = true,
  ["template-llncs"] = true,
}
-- Tests allowed to report "multiply-defined labels".
local allow_multidef = { ["identity"] = true }

----------------------------------------------------------------------
-- helpers
----------------------------------------------------------------------

local function readfile(path)
  local f = io.open(path, "r")
  if not f then return nil end
  local s = f:read("*a")
  f:close()
  return s
end

-- Run a shell command and report success.  Handles both the Lua 5.1
-- (numeric) and 5.2+ (boolean, "exit", code) os.execute conventions.
local function run(cmd)
  local a, _, c = os.execute(cmd)
  if type(a) == "number" then return a == 0 end   -- 5.1: returns the code
  return a == true and (c == nil or c == 0)        -- 5.2+: true + exit 0
end

-- Per-test scratch files pdflatex may leave behind.  Removing them
-- before the run makes every invocation a cold start (matching a fresh
-- CI checkout) and prevents a stale log/aux from a previous green run
-- from being mistaken for this run's output.
local scratch_exts = { "aux", "toc", "lof", "lot", "out", "log" }
local function clean_scratch(name)
  for _, ext in ipairs(scratch_exts) do
    os.remove(scratch .. "/" .. name .. "." .. ext)
  end
end

-- case-insensitive plain substring search
local function ifind(haystack, needle)
  return haystack:lower():find(needle, 1, true) ~= nil
end

-- first line beginning with "!" (a TeX/LaTeX error)
local function first_error_line(text)
  for line in text:gmatch("[^\r\n]+") do
    if line:sub(1, 1) == "!" then return line end
  end
  return nil
end

-- a single line containing both words (Makefile's undefined.*zebranote)
local function line_has_both(text, a, b)
  for line in text:gmatch("[^\r\n]+") do
    local l = line:lower()
    local pa = l:find(a, 1, true)
    if pa and l:find(b, pa, true) then return true end
  end
  return false
end

-- Decide pass/fail for one test from its final-pass log (+ .out for
-- the pdfstring bookmark check).  Returns ok, reason.
local function evaluate(name, log, out)
  if not log then
    return false, "no log produced (compilation never started?)"
  end
  local bang = first_error_line(log)
  if bang then
    -- surface the assertion message specially when present
    if ifind(log, "behavioural regression") then
      return false, "assertion failed: " .. bang
    end
    return false, bang
  end
  if ifind(log, "latex error") then return false, "LaTeX Error" end
  if ifind(log, "emergency stop") then return false, "Emergency stop" end
  if ifind(log, "float(s) lost") then return false, "Float(s) lost" end
  if line_has_both(log, "undefined", "zebranote") then
    return false, "undefined zebranote command"
  end
  if ifind(log, "undefined references") then
    return false, "undefined references after 3 passes"
  end
  if ifind(log, "has been referenced but does not exist") then
    return false, "missing label destination"
  end
  if ifind(log, "missing destination") then
    return false, "missing destination"
  end
  if ifind(log, "token not allowed in a pdf string") then
    return false, "token not allowed in a PDF string"
  end
  if ifind(log, "multiply-defined labels") and not allow_multidef[name] then
    return false, "unexpected multiply-defined labels"
  end
  if ifind(log, "package zebra warning") and not allow_zebra_warning[name] then
    return false, "unexpected zebra warning"
  end
  if name == "pdfstring" and out and out:find("PDFSTRING-", 1, true) then
    return false, "note body leaked into PDF bookmark"
  end
  return true, nil
end

----------------------------------------------------------------------
-- setup
----------------------------------------------------------------------

-- Make zebra.sty (out/) and zebra-test.tex (tests/) findable.  out/ is
-- listed first, ahead of the implicit current directory, so the freshly
-- built package always wins over any stale copy a previous `make test`
-- may have left in the repository root.  The trailing separator keeps
-- the default search path (including ".").
local texinputs = outdir .. sep .. testdir .. sep
                  .. (os.getenv("TEXINPUTS") or "")
os.setenv("TEXINPUTS", texinputs)

if not readfile(outdir .. "/zebra.sty") then
  io.write("zebra.sty not found in " .. outdir .. "/; building via latexmk...\n")
  local ok = os.execute("latexmk zebra.dtx > " .. nul .. " 2>&1")
  if not (ok == true or ok == 0) or not readfile(outdir .. "/zebra.sty") then
    io.write("ERROR: could not build zebra.sty; run `make` first.\n")
    os.exit(1)
  end
end

lfs.mkdir(outdir)
lfs.mkdir(scratch)

----------------------------------------------------------------------
-- collect tests
----------------------------------------------------------------------

local tests = {}
for entry in lfs.dir(testdir) do
  local name = entry:match("^(.+)%.tex$")
  if name and name ~= "zebra-test" then
    tests[#tests + 1] = name
  end
end
table.sort(tests)

----------------------------------------------------------------------
-- run
----------------------------------------------------------------------

local failures = {}
for _, name in ipairs(tests) do
  local texfile = testdir .. "/" .. name .. ".tex"
  local cmd = string.format(
    "pdflatex -halt-on-error -interaction=nonstopmode -output-directory=%s %s > %s 2>&1",
    scratch, texfile, nul)
  clean_scratch(name)
  local passerr
  for i = 1, 3 do
    if not run(cmd) then passerr = i; break end
  end

  local ok, reason
  if passerr then
    ok, reason = false, "pdflatex exited nonzero on pass " .. passerr
  else
    local log = readfile(scratch .. "/" .. name .. ".log")
    local out = readfile(scratch .. "/" .. name .. ".out")
    ok, reason = evaluate(name, log, out)
  end
  if ok then
    io.write(string.format("PASS  %s\n", name))
  else
    io.write(string.format("FAIL  %s  -- %s\n", name, reason))
    failures[#failures + 1] = name
  end
end

io.write(string.rep("-", 60) .. "\n")
if #failures == 0 then
  io.write(string.format("All %d tests passed.\n", #tests))
  os.exit(0)
else
  io.write(string.format("%d of %d tests FAILED: %s\n",
    #failures, #tests, table.concat(failures, ", ")))
  os.exit(1)
end
