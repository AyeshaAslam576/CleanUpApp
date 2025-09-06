import 'package:flutter/material.dart';

class StorageProgressBar extends StatelessWidget {
  final int usedGB;
  final int totalGB;
  final double height;
  final bool showLabel;
  final String? label;

  const StorageProgressBar({
    super.key,
    required this.usedGB,
    required this.totalGB,
    this.height = 8.0,
    this.showLabel = true,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usedPercentage = usedGB / totalGB;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       child: Image.asset(""),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //
          //       ),
          //     ),
          //
          //   ],
          //
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label ?? 'iPhone',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$usedGB of ${totalGB}GB Used',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: height,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: usedPercentage.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryStorageProgressBar extends StatelessWidget {
  final Map<String, int> categoryUsage;
  final int totalGB;
  final double height;

  const CategoryStorageProgressBar({
    super.key,
    required this.categoryUsage,
    required this.totalGB,
    this.height = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.grey,
    ];

    return Column(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Row(children: _buildCategorySegments(colors)),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: _buildCategoryLegend(colors, theme),
        ),
      ],
    );
  }

  List<Widget> _buildCategorySegments(List<Color> colors) {
    final segments = <Widget>[];
    int colorIndex = 0;

    categoryUsage.forEach((category, usage) {
      if (usage > 0) {
        final percentage = usage / totalGB;
        segments.add(
          FractionallySizedBox(
            widthFactor: percentage.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: colors[colorIndex % colors.length],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
        colorIndex++;
      }
    });

    return segments;
  }

  List<Widget> _buildCategoryLegend(List<Color> colors, ThemeData theme) {
    final legends = <Widget>[];
    int colorIndex = 0;

    categoryUsage.forEach((category, usage) {
      if (usage > 0) {
        legends.add(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: colors[colorIndex % colors.length],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              Text(category, style: theme.textTheme.bodySmall),
            ],
          ),
        );
        colorIndex++;
      }
    });

    return legends;
  }
}
