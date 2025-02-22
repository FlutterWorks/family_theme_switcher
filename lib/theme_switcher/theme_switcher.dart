import 'dart:math' as math;

import 'package:family_theme_switcher/theme/theme.dart';
import 'package:family_theme_switcher/widgets/on_tap_scaler.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({
    required this.selectedMode,
    required this.onChanged,
    required this.onClose,
    super.key,
  });

  final ThemeMode selectedMode;

  final ValueChanged<ThemeMode> onChanged;

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 386),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        child: Text(
                          'Appearance',
                          style: context.textStyles.heading.copyWith(
                            color: colors.textDefault,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    _CloseButton(onTap: onClose),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    for (final mode in ThemeMode.values)
                      Flexible(
                        child: _Item(
                          icon: switch (mode) {
                            ThemeMode.system => 'assets/images/phone.svg',
                            ThemeMode.light => 'assets/images/sun.svg',
                            ThemeMode.dark => 'assets/images/moon.svg',
                          },
                          title: switch (mode) {
                            ThemeMode.system => 'System',
                            ThemeMode.light => 'Light',
                            ThemeMode.dark => 'Dark',
                          },
                          borderGradientColors: switch (mode) {
                            ThemeMode.system ||
                            ThemeMode.light =>
                              colors.lightBorderGradient,
                            ThemeMode.dark => colors.darkBorderGradient,
                          },
                          isSelected: mode == selectedMode,
                          onTap: () {
                            if (selectedMode != mode) {
                              onChanged(mode);
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    required this.icon,
    required this.title,
    required this.borderGradientColors,
    required this.isSelected,
    required this.onTap,
  });

  final String icon;

  final String title;

  final List<Color> borderGradientColors;

  final bool isSelected;

  final VoidCallback onTap;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> with TickerProviderStateMixin {
  late final AnimationController _rotationController;

  late final AnimationController _opacityController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    );

    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 125),
    );

    if (widget.isSelected) {
      _rotationController.repeat();
      _opacityController.value = 1;
    }
  }

  @override
  void didUpdateWidget(_Item oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        _rotationController.repeat();
        _opacityController.forward();
      } else {
        _rotationController.stop();
        _opacityController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _opacityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return OnTapScaler(
      onTap: widget.onTap,
      child: CustomPaint(
        foregroundPainter: _BorderPainter(
          colors: widget.borderGradientColors,
          rotation: _rotationController,
          opacity: _opacityController,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceSecondary,
            borderRadius: const BorderRadius.all(Radius.circular(18)),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: _opacityController,
                  builder: (context, borderOpacity, _) {
                    final iconColor = Color.lerp(
                      colors.iconDefault,
                      colors.iconHighlighted,
                      borderOpacity,
                    )!;

                    return VectorGraphic(
                      loader: AssetBytesLoader(widget.icon),
                      height: 50,
                      width: 50,
                      colorFilter: ColorFilter.mode(
                        iconColor,
                        BlendMode.srcATop,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  widget.title,
                  style: context.textStyles.labelLarge.copyWith(
                    color: colors.textDefault,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BorderPainter extends CustomPainter {
  _BorderPainter({
    required this.colors,
    required this.rotation,
    required this.opacity,
  }) : super(repaint: Listenable.merge([rotation, opacity]));

  final List<Color> colors;

  final Animation<double> rotation;

  final Animation<double> opacity;

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity.value == 0) {
      return;
    }

    final childRect = Offset.zero & size;
    final borderRect = Rect.fromLTRB(
      childRect.left - 4.5,
      childRect.top - 4.5,
      childRect.right + 4.5,
      childRect.bottom + 4.5,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(borderRect, const Radius.circular(22)),
      Paint()
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..shader = SweepGradient(
          colors: colors,
          transform: GradientRotation(math.pi * 2 * rotation.value),
        ).withOpacity(opacity.value).createShader(borderRect),
    );
  }

  @override
  bool shouldRepaint(_BorderPainter oldDelegate) {
    return oldDelegate.colors != colors ||
        oldDelegate.rotation != rotation ||
        oldDelegate.opacity != opacity;
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ClipOval(
      child: OnTapScaler(
        onTap: onTap,
        child: SizedBox.square(
          dimension: 32,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.surfaceSecondary,
            ),
            child: Center(
              child: VectorGraphic(
                loader: const AssetBytesLoader('assets/images/close-small.svg'),
                height: 16,
                width: 16,
                colorFilter: ColorFilter.mode(
                  colors.iconDefault,
                  BlendMode.srcATop,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
