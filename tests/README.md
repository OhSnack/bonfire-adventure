# Test Infrastructure

**Engine**: Godot 4.7.2
**Test Framework**: GdUnit4 6.2.2 (committed in `addons/gdUnit4/`, MIT license)
**CI**: `.github/workflows/tests.yml`
**Setup date**: 2026-10-31

## Directory Layout

```
tests/
  unit/           # Isolated unit tests (formulas, state machines, logic)
  integration/    # Cross-system and save/load tests
  smoke/          # Critical path test list for /smoke-check gate
```

```
production/qa/
  evidence/       # Screenshot logs and manual test sign-off records
```

> **Manual evidence lives under `production/qa/evidence/`, not `tests/`** — that
> is where every consumer reads it.

## Running Tests

From the repo root:

```bash
godot --headless --path . --import
godot --headless -s -d --remote-debug tcp://127.0.0.1:0 res://addons/gdUnit4/bin/GdUnitCmdTool.gd -a res://tests --ignoreHeadlessMode
```

- Run the import first: without a `.godot/` class cache the runner fails to load (exit 1, no test ran).
- Exit codes: **0** all passed · **100** a test failed · **101** passed but leaked nodes (warning) ·
  103/104 gdUnit4 could not run · **105** a test script does not parse.
- `No test cases found` with exit 0 is **not** a pass — nothing ran.
- The two `ERROR:` lines about the remote port `127.0.0.1:0` are expected.
- The folder is `addons/gdUnit4/` with a **capital U**.

### Installing / updating GdUnit4

GdUnit4 6.2.2 is already committed. To update it, or to enable its editor panel:

1. Open Godot → Asset Store → search "GdUnit4" → install it (or copy `addons/gdUnit4/` from a
   tagged release of https://github.com/godot-gdunit-labs/gdUnit4)
2. Enable the plugin: Project → Project Settings → Plugins → GdUnit4 ✓
3. Restart the editor
4. Verify: `res://addons/gdUnit4/bin/GdUnitCmdTool.gd` exists (capital U)

The command-line runner above works without enabling the plugin.

## Test Naming

Names follow the engine's language (`.claude/rules/test-standards.md`):
- **Godot**: file `[system]_[feature]_test.gd`, function `test_[scenario]_[expected]`
  — `combat_damage_test.gd` → `test_base_attack_returns_expected_damage()`

## Story Type → Test Evidence

| Story Type | Required Evidence | Location |
|---|---|---|
| Logic | Automated unit test — must pass | `tests/unit/[system]/` |
| Integration | Integration test OR playtest doc | `tests/integration/[system]/` |
| Visual/Feel | Screenshot + lead sign-off | `production/qa/evidence/` |
| UI | Retained screenshot of each screen touched | `production/qa/evidence/` |
| Config/Data | Smoke check pass | `production/qa/smoke-*.md` |

## CI

Tests run automatically on every push to `main` and on every pull request.
A failed test suite blocks merging. If you protect `main`, require the
`Run GdUnit4 Tests` job check, not `test-results` (that check run concludes
success even when a test fails).
