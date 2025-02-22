import 'package:family_theme_switcher/theme/theme.dart';
import 'package:family_theme_switcher/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class LargeMenuItemSkeleton extends StatelessWidget {
  const LargeMenuItemSkeleton({
    required this.titleWidthFactor,
    required this.subtitleWidthFactor,
    super.key,
  });

  final double titleWidthFactor;

  final double subtitleWidthFactor;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;

    return OnTapScaler(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(4),
              child: IconSkeleton(
                dimension: 40,
                radius: 6,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextSkeleton(
                    textStyle: textStyles.bodyLarge,
                    radius: 3,
                    widthFactor: titleWidthFactor,
                  ),
                  const SizedBox(height: 2),
                  TextSkeleton(
                    textStyle: textStyles.bodySmall,
                    radius: 3,
                    widthFactor: subtitleWidthFactor,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Builder(
              builder: (context) {
                return VectorGraphic(
                  loader: const AssetBytesLoader(
                    'assets/images/chevron-right.svg',
                  ),
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    context.colors.iconDefault,
                    BlendMode.srcATop,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
