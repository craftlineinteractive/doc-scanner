# Task Plan: Doc Scanner UI Implementation

Goal: Build the complete UI of the Flutter "Doc Scanner" app with realistic dummy data and zero business logic, matching mockups and design system specifications.

## Milestones & File Roadmap

### [x] M0: Project Setup, Theme, Router & UI Gallery (`4adb380`)
- `docs/AI_RULES.md`
- `lib/core/constants/app_strings.dart`
- `lib/core/constants/app_assets.dart`
- `lib/core/constants/app_durations.dart`
- `lib/core/constants/app_limits.dart`
- `lib/core/theme/app_colors.dart`
- `lib/core/theme/app_typography.dart`
- `lib/core/theme/app_spacing.dart`
- `lib/core/theme/app_radii.dart`
- `lib/core/theme/app_shadows.dart`
- `lib/core/theme/doc_colors.dart`
- `lib/core/theme/app_theme.dart`
- `lib/app/routes.dart`
- `lib/app/app_router.dart`
- `lib/app/app.dart`
- `lib/main.dart`
- `lib/dev/ui_gallery/ui_gallery_screen.dart`
- `test/theme_test.dart`
- `test/app_smoke_test.dart`

### [x] M1: Common Widgets UI Kit (`9b28d5a`)
- `lib/core/widgets/buttons/primary_button.dart`
- `lib/core/widgets/buttons/secondary_button.dart`
- `lib/core/widgets/buttons/text_action_button.dart`
- `lib/core/widgets/buttons/dual_pill_fab.dart`
- `lib/core/widgets/buttons/shutter_button.dart`
- `lib/core/widgets/buttons/icon_circle_button.dart`
- `lib/core/widgets/buttons/tool_button.dart`
- `lib/core/widgets/navigation/app_top_bar.dart`
- `lib/core/widgets/navigation/pro_pill.dart`
- `lib/core/widgets/inputs/app_search_field.dart`
- `lib/core/widgets/inputs/app_text_field.dart`
- `lib/core/widgets/inputs/app_switch.dart`
- `lib/core/widgets/inputs/radio_tile.dart`
- `lib/core/widgets/inputs/segmented_pill.dart`
- `lib/core/widgets/cards/info_banner.dart`
- `lib/core/widgets/chips/status_chip.dart`
- `lib/core/widgets/chips/count_badge.dart`
- `lib/core/widgets/sheets/app_bottom_sheet.dart`
- `lib/core/widgets/dialogs/app_dialog.dart`
- `lib/core/widgets/feedback/app_snackbar.dart`
- `lib/core/widgets/feedback/empty_state.dart`
- `lib/dev/ui_gallery/components_gallery_screen.dart`

### [x] M2: Home & Drawer (`m2-home-drawer`)
- `lib/features/home/domain/home_repository.dart`
- `lib/features/home/data/mock_home_repository.dart`
- `lib/features/home/presentation/screens/home_screen.dart`
- `lib/features/home/presentation/screens/home_empty_screen.dart`
- `lib/features/home/presentation/sheets/home_overflow_menu.dart`
- `lib/features/home/presentation/sheets/add_document_sheet.dart`
- `lib/features/home/presentation/widgets/folder_tile.dart`
- `lib/features/home/presentation/widgets/document_list_card.dart`
- `lib/features/drawer/presentation/widgets/app_drawer.dart`
- `lib/features/drawer/presentation/widgets/drawer_header_signed_in.dart`
- `lib/features/drawer/presentation/widgets/drawer_header_signed_out.dart`
- `lib/features/drawer/presentation/widgets/drawer_item.dart`
- `lib/features/drawer/presentation/widgets/expandable_section.dart`
- `lib/features/drawer/presentation/widgets/premium_upsell_card.dart`

### [x] M3: Camera & Modes (`m3-camera`)
- `lib/features/camera/domain/photo_size.dart`
- `lib/features/camera/data/mock_photo_sizes.dart`
- `lib/features/camera/application/camera_mode.dart`
- `lib/features/camera/application/flash_mode.dart`
- `lib/features/camera/application/camera_settings.dart`
- `lib/features/camera/application/id_scan_sides.dart`
- `lib/features/camera/application/book_scan_type.dart`
- `lib/features/camera/application/photo_size_provider.dart`
- `lib/features/camera/presentation/screens/camera_screen.dart`
- `lib/features/camera/presentation/widgets/camera_viewfinder.dart`
- `lib/features/camera/presentation/widgets/camera_bottom_controls.dart`
- `lib/features/camera/presentation/widgets/camera_settings_panel.dart`
- `lib/features/camera/presentation/widgets/spirit_level_widget.dart`
- `lib/features/camera/presentation/widgets/camera_grid_overlay.dart`
- `lib/features/camera/presentation/sheets/scan_quality_sheet.dart`
- `lib/features/camera/presentation/dialogs/id_card_mode_dialog.dart`
- `lib/features/camera/presentation/dialogs/book_mode_dialog.dart`
- `lib/features/camera/presentation/dialogs/photo_size_dialog.dart`
- `lib/features/camera/presentation/dialogs/ocr_mode_dialog.dart`

### [x] M4: Scan Review & Adjust (`m4-scan-review`)
- `lib/features/scan_review/domain/crop_quad.dart`
- `lib/features/scan_review/domain/crop_shape.dart`
- `lib/features/scan_review/domain/scan_filter.dart`
- `lib/features/scan_review/domain/scan_page.dart`
- `lib/features/scan_review/application/scan_session_provider.dart`
- `lib/features/scan_review/application/review_ui_provider.dart`
- `lib/features/scan_review/presentation/screens/adjust_screen.dart`
- `lib/features/scan_review/presentation/screens/review_scan_screen.dart`
- `lib/features/scan_review/presentation/screens/arrange_pages_screen.dart`
- `lib/features/scan_review/presentation/widgets/adjust_canvas.dart`
- `lib/features/scan_review/presentation/widgets/adjust_controls.dart`
- `lib/features/scan_review/presentation/widgets/review_top_bar.dart`
- `lib/features/scan_review/presentation/widgets/review_bottom_bar.dart`
- `lib/features/scan_review/presentation/widgets/review_crop_bar.dart`
- `lib/features/scan_review/presentation/widgets/review_color_bar.dart`
- `lib/features/scan_review/presentation/sheets/filter_bottom_sheet.dart`
- `lib/features/scan_review/presentation/sheets/crop_shape_sheet.dart`
- `lib/features/scan_review/presentation/dialogs/doc_name_dialog.dart`
- `lib/features/scan_review/presentation/dialogs/delete_page_dialog.dart`
- `lib/features/scan_review/presentation/dialogs/discard_scan_dialog.dart`
- `test/scan_review_test.dart`

### M5: Document Viewers & Multi-Page Manager (`lib/features/document_viewer/`)
- `lib/features/document_viewer/domain/document_viewer_repository.dart`
- `lib/features/document_viewer/data/mock_document_viewer_repository.dart`
- `lib/features/document_viewer/presentation/screens/post_scan_viewer_screen.dart`
- `lib/features/document_viewer/presentation/screens/saved_document_viewer_screen.dart`
- `lib/features/document_viewer/presentation/screens/multi_page_manager_screen.dart`
- `lib/features/document_viewer/presentation/sheets/more_options_sheet.dart`
- `lib/features/document_viewer/presentation/sheets/action_drawer_sheet.dart`
- `lib/features/document_viewer/presentation/dialogs/edit_version_dialog.dart`

### M6: PDF Tools & Viewer (`lib/features/pdf_tools/`)
- `lib/features/pdf_tools/domain/pdf_tools_repository.dart`
- `lib/features/pdf_tools/data/mock_pdf_tools_repository.dart`
- `lib/features/pdf_tools/presentation/screens/pdf_viewer_screen.dart`
- `lib/features/pdf_tools/presentation/sheets/toolkit_drawer_sheet.dart`
- `lib/features/pdf_tools/presentation/dialogs/pdf_help_dialog.dart`

### M7: OCR Result (`lib/features/ocr/`)
- `lib/features/ocr/domain/ocr_repository.dart`
- `lib/features/ocr/data/mock_ocr_repository.dart`
- `lib/features/ocr/presentation/screens/ocr_result_screen.dart`

### M8: Trash (`lib/features/trash/`)
- `lib/features/trash/domain/trash_repository.dart`
- `lib/features/trash/data/mock_trash_repository.dart`
- `lib/features/trash/presentation/screens/trash_screen.dart`
- `lib/features/trash/presentation/dialogs/trash_confirm_dialog.dart`

### M9: Settings (`lib/features/settings/`)
- `lib/features/settings/domain/settings_repository.dart`
- `lib/features/settings/data/mock_settings_repository.dart`
- `lib/features/settings/presentation/screens/settings_screen.dart`
- `lib/features/settings/presentation/dialogs/theme_select_dialog.dart`
- `lib/features/settings/presentation/dialogs/scan_quality_dialog.dart`
- `lib/features/settings/presentation/dialogs/recent_count_dialog.dart`
- `lib/features/settings/presentation/dialogs/date_format_dialog.dart`
- `lib/features/settings/presentation/dialogs/reset_confirm_dialog.dart`

### M10: Premium Paywall (`lib/features/premium/`)
- `lib/features/premium/domain/premium_repository.dart`
- `lib/features/premium/data/mock_premium_repository.dart`
- `lib/features/premium/presentation/screens/premium_paywall_screen.dart`
- `lib/features/premium/presentation/widgets/plan_card.dart`

### M11: Late-Designed Screens (Pending Design Specs)
- Onboarding, Sign-in, Global search results, New folder sheet, Export sheet, Backup sync, OCR language manager.

