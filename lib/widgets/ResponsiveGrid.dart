import 'package:flutter/material.dart';
import 'package:tablero_tareas/widgets/ResponsiveGridItem.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<ResponsiveGridItem> children;
  final double spacing;

  const ResponsiveGrid({super.key, required this.children, this.spacing = 8});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = getScreenSize(constraints.maxWidth);
        final columnWidth = (constraints.maxWidth - spacing * 11) / 12;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children:
              children.map((item) {
                final cols = item.columnsForSize(size);
                return SizedBox(
                  width: cols * columnWidth + (cols - 1) * spacing,
                  child: item.child,
                );
              }).toList(),
        );
      },
    );
  }
}
