import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/drawer_user.dart';

/// Notifier managing user authentication state within the navigation drawer.
class DrawerUserNotifier extends Notifier<DrawerUser?> {
  @override
  DrawerUser? build() => DrawerUser.mockUser;

  void signIn() {
    state = DrawerUser.mockUser;
  }

  void signOut() {
    state = null;
  }

  void toggle() {
    state = state == null ? DrawerUser.mockUser : null;
  }
}

/// Notifier providing a signed-out state by default.
class SignedOutDrawerUserNotifier extends DrawerUserNotifier {
  @override
  DrawerUser? build() => null;
}

/// Provider exposing the current [DrawerUser] or null if signed out.
final NotifierProvider<DrawerUserNotifier, DrawerUser?> drawerUserProvider =
    NotifierProvider<DrawerUserNotifier, DrawerUser?>(DrawerUserNotifier.new);
