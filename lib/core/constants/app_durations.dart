/// Animation and transition durations.
class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);

  static const Duration toastDuration = Duration(seconds: 3);
  static const Duration snackbarDuration = Duration(seconds: 4);
}
