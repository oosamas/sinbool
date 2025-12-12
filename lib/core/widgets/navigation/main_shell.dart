import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/app_routes.dart';
import 'bottom_nav_bar.dart';

/// Main shell widget with bottom navigation
/// From Issue #3 - Navigation & Routing
class MainShell extends StatelessWidget {
  const MainShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (location.startsWith('/chapters')) {
      return 1;
    }
    if (location.startsWith('/bookmarks')) {
      return 2;
    }
    if (location.startsWith('/profile')) {
      return 3;
    }
    return 0; // Home
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.chapters);
      case 2:
        context.go(AppRoutes.bookmarks);
      case 3:
        context.go(AppRoutes.profile);
    }
  }
}

/// Responsive shell that adapts to screen size
/// Uses bottom nav on mobile, navigation rail on tablet/desktop
class ResponsiveMainShell extends StatelessWidget {
  const ResponsiveMainShell({required this.child, super.key});

  final Widget child;

  static const double _tabletBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= _tabletBreakpoint;

    if (isTablet) {
      return Scaffold(
        body: Row(
          children: [
            AppNavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) => _onItemTapped(index, context),
              extended: width >= 900,
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (location.startsWith('/chapters')) {
      return 1;
    }
    if (location.startsWith('/bookmarks')) {
      return 2;
    }
    if (location.startsWith('/profile')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.chapters);
      case 2:
        context.go(AppRoutes.bookmarks);
      case 3:
        context.go(AppRoutes.profile);
    }
  }
}
