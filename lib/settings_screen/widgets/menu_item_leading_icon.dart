import 'package:family_theme_switcher/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class MenuItemLeadingIcon extends StatelessWidget {
  const MenuItemLeadingIcon._({
    required this.asset,
    super.key,
  });

  const MenuItemLeadingIcon.appearance({Key? key})
      : this._(
          asset: 'assets/images/appearance.svg',
          key: key,
        );

  final String asset;

  @override
  Widget build(BuildContext context) {
    return VectorGraphic(
      loader: AssetBytesLoader(asset),
      height: 28,
      width: 28,
      colorFilter: ColorFilter.mode(
        context.colors.iconDefault,
        BlendMode.srcATop,
      ),
    );
  }
}
