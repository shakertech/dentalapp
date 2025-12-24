import 'package:flutter/material.dart';

/// 🌐 AppProvider
/// Controls global app navigation, sidebar selection, and active screen.
class AppProvider extends ChangeNotifier {
  /// Currently selected page index
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  /// Page titles (optional, for top bar)
  final List<String> _pageTitles = [
    'Dashboard',
    'Menu',
    'Orders',
    'Staff',
    'Settings',
  ];

  String get currentTitle => _pageTitles[_currentIndex];

  /// Set current page index
  void setPage(int index) {
    if (index != _currentIndex) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  /// Helper: reset to dashboard
  void goHome() {
    _currentIndex = 0;
    notifyListeners();
  }

  /// For future use — you can store navigation keys or routes here
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigate programmatically inside nested Navigator (if you add one later)
  void navigateTo(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  /// Example: log out or go back
  void pop() {
    navigatorKey.currentState?.pop();
  }
}
