import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../configs/breakpoints.dart';

class ResponsiveProvider extends ChangeNotifier {
  bool _isDesktop = false;
  bool _isMobile = true;
  bool _isTablet = false;

  bool get isDesktop => _isDesktop;
  bool get isMobile => _isMobile;
  bool get isTablet => _isTablet;

  ResponsiveProvider() {
    _init();
  }

  void _init() {
    // Initial guess without size
    if (kIsWeb) {
      _setMobile();
    } else {
      try {
        if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          _setMobile();
        } else {
          // Default to mobile for Android/iOS until update(size) is called
          _setMobile();
        }
      } catch (e) {
        _setMobile();
      }
    }
  }

  void update(Size size) {
    if (kIsWeb) {
      if (!_isDesktop) {
        _setMobile();
        notifyListeners();
      }
      return;
    }

    try {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        if (!_isDesktop) {
          _setMobile();
          notifyListeners();
        }
      } else {
        // Mobile Platforms (Android, iOS, Fuchsia)
        // Check width for Tablet vs Phone
        if (size.width >= Breakpoints.tablet) {
          if (!_isTablet) {
            _setTablet();
            notifyListeners();
          }
        } else {
          if (!_isMobile) {
            _setMobile();
            notifyListeners();
          }
        }
      }
    } catch (_) {
      // Fallback for safety (e.g. if Platform check fails unexpectedly)
      if (!_isMobile) {
        _setMobile();
        notifyListeners();
      }
    }
  }

  void _setDesktop() {
    _isDesktop = true;
    _isTablet = false;
    _isMobile = false;
  }

  void _setTablet() {
    _isDesktop = false;
    _isTablet = true;
    _isMobile = false;
  }

  void _setMobile() {
    _isDesktop = false;
    _isTablet = false;
    _isMobile = true;
  }
}
