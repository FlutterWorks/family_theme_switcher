import 'package:family_theme_switcher/theme/theme.dart';
import 'package:family_theme_switcher/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SmallMenuItemSkeleton extends StatelessWidget {
  const SmallMenuItemSkeleton({
    required this.titleWidthFactor,
    required this.trailingIcon,
    super.key,
  });

  final double titleWidthFactor;

  final Widget trailingIcon;

  @override
  Widget build(BuildContext context) {
    return OnTapScaler(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const SizedBox(width: 2),
            const Padding(
              padding: EdgeInsets.all(3),
              child: IconSkeleton(
                dimension: 22,
                radius: 3,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextSkeleton(
                textStyle: context.textStyles.bodyLarge,
                radius: 3,
                widthFactor: titleWidthFactor,
              ),
            ),
            const SizedBox(width: 16),
            trailingIcon,
          ],
        ),
      ),
    );
  }
}
