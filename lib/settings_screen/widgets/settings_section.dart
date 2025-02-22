import 'package:family_theme_switcher/theme/theme.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Builder(
          builder: (context) {
            return Text(
              title,
              style: context.textStyles.labelSmall.copyWith(
                color: context.colors.textWeak,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }
}
