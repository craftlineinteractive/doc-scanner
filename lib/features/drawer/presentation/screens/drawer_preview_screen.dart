import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/drawer_providers.dart';
import '../widgets/app_drawer.dart';

/// Preview screen for the navigation drawer, auto-opening it for UI Gallery verification.
class DrawerPreviewScreen extends ConsumerStatefulWidget {
  const DrawerPreviewScreen({
    super.key,
    this.initialSignedOut = false,
    this.initialToolsExpanded = false,
    this.initialOtherExpanded = false,
  });

  final bool initialSignedOut;
  final bool initialToolsExpanded;
  final bool initialOtherExpanded;

  @override
  ConsumerState<DrawerPreviewScreen> createState() =>
      _DrawerPreviewScreenState();
}

class _DrawerPreviewScreenState extends ConsumerState<DrawerPreviewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.initialSignedOut) {
        ref.read(drawerUserProvider.notifier).signOut();
      } else {
        ref.read(drawerUserProvider.notifier).signIn();
      }
      _scaffoldKey.currentState?.openDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        initialGeneralExpanded: !widget.initialToolsExpanded,
        initialToolsExpanded: widget.initialToolsExpanded,
        initialOtherExpanded: widget.initialOtherExpanded,
      ),
      appBar: AppBar(
        title: const Text('Navigation Drawer Preview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          child: const Text('Open Navigation Drawer'),
        ),
      ),
    );
  }
}

