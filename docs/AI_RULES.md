# AI Development Rules for Doc Scanner

These 10 rules are mandatory for every task and feature built in this codebase:

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

