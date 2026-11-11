/// Model representing the currently signed-in Google Drive user for the drawer.
class DrawerUser {
  const DrawerUser({
    required this.name,
    required this.email,
    this.avatarUrl,
    this.backupSizeMb = 589,
    this.isSynced = true,
  });

  final String name;
  final String email;
  final String? avatarUrl;
  final int backupSizeMb;
  final bool isSynced;

  /// Default baseline authenticated user profile matching mockups.
  static const DrawerUser mockUser = DrawerUser(
    name: 'Prince Patel',
    email: 'patelprince2598@gmail.com',
    backupSizeMb: 589,
    isSynced: true,
  );
}
