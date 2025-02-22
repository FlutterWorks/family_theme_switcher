import 'package:family_theme_switcher/theme/theme.dart';
import 'package:family_theme_switcher/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SmallMenuItem extends StatelessWidget {
  const SmallMenuItem({
    required this.title,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.onTap,
    this.value,
    super.key,
  });

  final String title;

  final Widget leadingIcon;

  final Widget trailingIcon;

  final VoidCallback onTap;

  final String? value;

  @override
  Widget build(BuildContext context) {
    return OnTapScaler(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const SizedBox(width: 2),
            leadingIcon,
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyles.bodyLarge.copyWith(
                        color: context.colors.textDefault,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (value != null)
                    Text(
                      value!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyles.bodyLarge.copyWith(
                        color: context.colors.textDefault,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 2),
            trailingIcon,
          ],
        ),
      ),
    );
  }
}
