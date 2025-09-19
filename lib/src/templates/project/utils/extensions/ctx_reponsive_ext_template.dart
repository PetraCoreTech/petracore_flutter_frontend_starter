String ctxResponsiveExtTemplate() => '''
import 'package:flutter/material.dart';

enum ScreenSize {mobile, tablet, desktop}

extension CtxResponsiveExtension on BuildContext {
  bool get isMobile {
    final size = MediaQuery.sizeOf(this);
    return size.width < 600 || size.height <= 430;
  }

  bool get isTablet {
    final width = MediaQuery.sizeOf(this).width;
    return width >= 600 && width <= 1024;
  }

  bool get isDesktop => MediaQuery.sizeOf(this).width >= 1024;

  ScreenSize get screenSize {
    if (isMobile) {
      return ScreenSize.mobile;
    } else if (isTablet) {
      return ScreenSize.tablet;
    } else {
      return ScreenSize.desktop;
    }
  }

  EdgeInsets buttonPadding() {
    return switch (screenSize) {
      ScreenSize.mobile =>
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ScreenSize.tablet =>
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ScreenSize.desktop =>
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    };
  }

  EdgeInsets insetsPadding() {
    return switch (screenSize) {
      ScreenSize.mobile => const EdgeInsets.symmetric(horizontal: 16) +
          const EdgeInsets.only(bottom: 40, top: 32),
      ScreenSize.tablet =>
        const EdgeInsets.symmetric(vertical: 32, horizontal: 48),
      ScreenSize.desktop => EdgeInsets.zero,
    };
  }

  Alignment dialogAlignment() {
    return switch (screenSize) {
      ScreenSize.mobile => Alignment.bottomCenter,
      ScreenSize.tablet => Alignment.center,
      ScreenSize.desktop => Alignment.center,
    };
  }

  double dialogWidth() {
    return switch (screenSize) {
      ScreenSize.mobile => double.infinity,
      ScreenSize.tablet => double.infinity,
      ScreenSize.desktop => 480,
    };
  }
}
''';
