import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'camera_mode.dart';

/// State notifier managing the active [CameraMode].
class CameraModeNotifier extends Notifier<CameraMode> {
  @override
  CameraMode build() => CameraMode.document;

  /// Update the active camera mode.
  void setMode(CameraMode mode) {
    state = mode;
  }
}

/// Provider exposing the current [CameraMode].
final NotifierProvider<CameraModeNotifier, CameraMode> cameraModeProvider =
    NotifierProvider<CameraModeNotifier, CameraMode>(CameraModeNotifier.new);
