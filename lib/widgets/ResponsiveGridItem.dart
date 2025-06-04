import 'package:flutter/cupertino.dart';

enum ScreenSize { xs, sm, md, lg, xl }

ScreenSize getScreenSize(double width) {
  if (width < 600) return ScreenSize.xs;
  if (width < 900) return ScreenSize.sm;
  if (width < 1200) return ScreenSize.md;
  if (width < 1536) return ScreenSize.lg;
  return ScreenSize.xl;
}

class ResponsiveGridItem {
  final Widget child;
  final int? xs;
  final int? sm;
  final int? md;
  final int? lg;
  final int? xl;

  ResponsiveGridItem({
    required this.child,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });

  int columnsForSize(ScreenSize size) {
    switch (size) {
      case ScreenSize.xs:
        return xs ?? sm ?? md ?? lg ?? xl ?? 12;
      case ScreenSize.sm:
        return sm ?? md ?? lg ?? xl ?? xs ?? 12;
      case ScreenSize.md:
        return md ?? lg ?? xl ?? sm ?? xs ?? 12;
      case ScreenSize.lg:
        return lg ?? xl ?? md ?? sm ?? xs ?? 12;
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? 12;
    }
  }
}
