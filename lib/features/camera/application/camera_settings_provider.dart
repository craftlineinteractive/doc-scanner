import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'camera_settings.dart';

/// State notifier managing all camera viewfinder and capture settings.
class CameraSettingsNotifier extends Notifier<CameraSettings> {
  @override
  CameraSettings build() => const CameraSettings();

  void toggleCaptureSound() {
    state = state.copyWith(captureSound: !state.captureSound);
  }

  void toggleFocusSound() {
    state = state.copyWith(focusSound: !state.focusSound);
  }

  void toggleAutoCrop() {
    state = state.copyWith(autoCrop: !state.autoCrop);
  }

  void toggleSpiritLevel() {
    state = state.copyWith(spiritLevel: !state.spiritLevel);
  }

  void toggleGrid() {
    state = state.copyWith(gridEnabled: !state.gridEnabled);
  }

  void setScanQuality(ScanQuality quality) {
    state = state.copyWith(scanQuality: quality);
  }

  /// Cycle image rotation setting: Auto -> Portrait -> Landscape -> Auto.
  void cycleImageRotation() {
    const rotations = <String>['Auto', 'Portrait', 'Landscape'];
    final currentIndex = rotations.indexOf(state.imageRotation);
    final nextIndex = (currentIndex + 1) % rotations.length;
    state = state.copyWith(imageRotation: rotations[nextIndex]);
  }

  /// Cycle auto capture delay: Off (0) -> 1 sec -> 2 sec -> 3 sec -> 5 sec -> Off.
  void cycleAutoCaptureSeconds() {
    const delays = <int>[0, 1, 2, 3, 5];
    final currentIndex = delays.indexOf(state.autoCaptureSeconds);
    final nextIndex = (currentIndex + 1) % delays.length;
    state = state.copyWith(autoCaptureSeconds: delays[nextIndex]);
  }

  void setColorFilter(String filter) {
    state = state.copyWith(colorFilter: filter);
  }
}

/// Provider exposing current [CameraSettings].
final NotifierProvider<CameraSettingsNotifier, CameraSettings>
    cameraSettingsProvider =
    NotifierProvider<CameraSettingsNotifier, CameraSettings>(
  CameraSettingsNotifier.new,
);

