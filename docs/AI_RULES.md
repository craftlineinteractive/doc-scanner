# AI Development Rules for Doc Scanner

These rules are mandatory for every task and feature built in this codebase:

1. **Never hard-code style values**: Never hard-code a colour, font size, radius, spacing or shadow in a screen. Use `AppColors`, `AppTypography`, `AppSpacing`, `AppRadii`, `AppShadows`, or `Theme.of(context)`.
2. **UI-only widgets without business logic**: Never put logic in widgets. Buttons only navigate, open a sheet/dialog, toggle local UI state, or show a snackbar.
3. **Strict separation of mock data**: Dummy data lives only in `features/<feature>/data/mock_*.dart`. Screens read it through an abstract repository in `domain/`.
4. **Widget reusability**: Reuse widgets from `lib/core/widgets`. Before creating a widget, search for an existing one. A widget used in 2+ features belongs in `core/widgets`.
5. **File & class conventions**: One class per file, `snake_case` file names. Screens end in `Screen`, sheets in `Sheet`, dialogs in `Dialog`. Prefer `const` constructors. Split a file when it passes about 200 lines.
6. **Responsive mobile & accessibility**: Touch targets at least 48x48. Support screen widths 360 to 430, text scaling up to 1.3, and safe areas. Long lists use builders (`ListView.builder`, `SliverGrid`).
7. **Consistent icons**: Icons: `Symbols` from `material_symbols_icons` only, rounded outline style, 24 px unless the design differs.
8. **High visual fidelity**: Use the icon/text/colours exactly as in the mockup `screen.png` + `code.html`. Do not invent features, texts or layouts that are not in the design.
9. **Route & Gallery registration**: Every new screen/sheet/dialog is registered in `routes.dart` and in the UI Gallery.
10. **Verification gate**: Finish every task with `flutter analyze` (zero issues) and `flutter test`. Update `progress.md`.

11. **Git commits**
- Commit only when ALL are true: the task's code is complete, `flutter analyze` shows 0 issues, `flutter test` passes, and the emulator check in rule 12 passed.
- Never commit broken, failing, or half-finished work. If something fails, fix it first. If you cannot fix it after 3 focused attempts, stop, do not commit, and report the exact problem to me.
- Make small logical commits during a long task, not one giant commit at the end. Typical split: shared widgets, then each screen or feature, then tests, then docs. Each commit must itself pass flutter analyze.
- Commit message format (Conventional Commits): `type(scope): short summary in present tense`.
  Types: feat, fix, refactor, style, test, docs, chore.
  Scopes: theme, core-widgets, home, drawer, camera, scan-review, viewer, pdf-tools, ocr, trash, settings, premium, router, gallery, workflow, etc.
  Examples:
  `feat(home): add home screen with folders and document list`
  `feat(core-widgets): add DualPillFab and DocumentListCard`
  `fix(camera): prevent crop handle overflow at 360 width`
  `docs(progress): mark milestone M3 complete`
- Add a short body for larger commits (2 to 4 bullet lines of what changed).
- Stage files explicitly with `git add <paths>`, not blindly. Check `git status` before and after each commit so no unwanted files (build output, screenshots, zips) are included.
- After finishing a whole milestone (M0 to M11), also create a lightweight tag: `git tag m<number>-<name>` (example: `m1-common-widgets`).
- Update progress.md as part of the same commit, with the commit hash next to the completed item.
- Do not push to any remote unless I ask.

12. **Emulator verification (after every completed task, before committing)**
- Detect the device: run `flutter devices`. If no Android emulator is running, run `flutter emulators`, then `flutter emulators --launch <emulator_id>` and wait until it appears in `flutter devices`. If you cannot start one, stop and tell me.
- Install and run the app: `flutter run -d <emulator_id>` (debug). Use hot restart when the app is already running. If the build fails, treat it as a failed task and fix it.
- Open the screens or states built in this task (use the UI Gallery in debug) and check:
  1. The app launches without crashes or red error screens.
  2. There are no RenderFlex overflow errors or exceptions in the console. Read the `flutter run` output and fix every one.
  3. Visual match against the mockup screen.png for each screen built.
  4. Taps do what the task described (navigation, sheets, dialogs, toggles).
  5. Scrolling is smooth and nothing is clipped by the status bar, navigation bar, or notch.
- Capture evidence when possible: `adb exec-out screencap -p > /tmp/<screen_name>.png` and compare it against the mockup. Do NOT save these screenshots inside the repository.
- If you cannot visually inspect the emulator, say so honestly. Never claim you saw something you did not verify. Instead run what you can (analyze, tests, build, console logs), list exactly what remains for me to check by eye, and still do not mark visual QA as done.
- Once per milestone, also test at text scale 1.3 (`adb shell settings put system font_scale 1.3`, then restore it to `1.0`), and at another screen size if I have another emulator available.
- Stop the running app when finished.
