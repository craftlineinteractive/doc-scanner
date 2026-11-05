import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'flash_mode.dart';

/// State notifier managing the active [FlashMode].
class FlashModeNotifier extends Notifier<FlashMode> {
  @override
  FlashMode build() => FlashMode.off;

  /// Cycle flash state directly through: Off -> On -> Auto -> Off.
  void cycle() {
    switch (state) {
      case FlashMode.off:
        state = FlashMode.on;
        break;
      case FlashMode.on:
        state = FlashMode.auto;
        break;
      case FlashMode.auto:
        state = FlashMode.off;
        break;
    }
  }

  /// Directly set a specific [FlashMode].
  void setMode(FlashMode mode) {
    state = mode;
  }
}

/// Provider exposing the current [FlashMode].
final NotifierProvider<FlashModeNotifier, FlashMode> flashModeProvider =
    NotifierProvider<FlashModeNotifier, FlashMode>(FlashModeNotifier.new);

