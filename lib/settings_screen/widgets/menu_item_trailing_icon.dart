import 'package:family_theme_switcher/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class MenuItemTrailingIcon extends StatelessWidget {
  const MenuItemTrailingIcon._({
    required this.asset,
    super.key,
  });

  const MenuItemTrailingIcon.chevronRight({Key? key})
      : this._(
          asset: 'assets/images/chevron-right.svg',
          key: key,
        );

  const MenuItemTrailingIcon.options({Key? key})
      : this._(
          asset: 'assets/images/options.svg',
          key: key,
        );

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
