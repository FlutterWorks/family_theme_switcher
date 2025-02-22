import 'package:family_theme_switcher/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        boxShadow: [
          BoxShadow(
            color: colors.background,
            spreadRadius: 8,
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox.fromSize(
          size: preferredSize,
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 26),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _Icon(asset: 'assets/images/close-large.svg'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 26),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _Icon(asset: 'assets/images/help.svg'),
                ),
              ),
              Center(
                child: Text(
                  'Your Family',
                  style: context.textStyles.heading.copyWith(
                    color: colors.textDefault,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    required this.asset,
  });

  final String asset;

  @override
  Widget build(BuildContext context) {
    return VectorGraphic(
      loader: AssetBytesLoader(asset),
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        context.colors.iconDefault,
        BlendMode.srcATop,
      ),
    );
  }
}
