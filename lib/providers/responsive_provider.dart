// lib/src/providers/responsive_provider.dart
import 'package:flutter/material.dart';
import '../configs/breakpoints.dart';

class ResponsiveProvider extends ChangeNotifier {
  double width = 0;
  double height = 0;
  bool isMobile = true;
  bool isTablet = false;
  bool isDesktop = false;

  void update(Size size) {
    width = size.width;
    height = size.height;

    isDesktop = width >= Breakpoints.desktop;
    isTablet = width >= Breakpoints.tablet && width < Breakpoints.desktop;
    isMobile = width < Breakpoints.tablet;

    // notifyListeners(); // Causing build error when called during build
  }
}
