import 'package:family_theme_switcher/routing/bottom_sheet_route.dart';
import 'package:family_theme_switcher/settings_controller.dart';
import 'package:family_theme_switcher/settings_screen/settings_screen.dart';
import 'package:family_theme_switcher/theme_switcher/theme_switcher.dart';
import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 48,
        ),
        children: [
          const LargeMenuItemSkeleton(
            titleWidthFactor: 0.3,
            subtitleWidthFactor: 0.5,
          ),
          const LargeDivider(),
          const LargeMenuItemSkeleton(
            titleWidthFactor: 0.3,
            subtitleWidthFactor: 0.5,
          ),
          const SizedBox(height: 24),
          SettingsSection(
            title: 'SETTINGS',
            children: [
              const SmallMenuItemSkeleton(
                titleWidthFactor: 0.3,
                trailingIcon: MenuItemTrailingIcon.options(),
              ),
              const SmallDivider(),
              ValueListenableBuilder(
                valueListenable: context.read<SettingsController>().themeMode,
                builder: (context, mode, _) {
                  return SmallMenuItem(
                    title: 'Appearance',
                    value: switch (mode) {
                      ThemeMode.system => 'System',
                      ThemeMode.light => 'Light',
                      ThemeMode.dark => 'Dark',
                    },
                    leadingIcon: const MenuItemLeadingIcon.appearance(),
                    trailingIcon: const MenuItemTrailingIcon.options(),
                    onTap: () => _showThemeSwitcher(context),
                  );
                },
              ),
              const SmallDivider(),
              const SmallMenuItemSkeleton(
                titleWidthFactor: 0.4,
                trailingIcon: MenuItemTrailingIcon.chevronRight(),
              ),
              const SmallDivider(),
              const SmallMenuItemSkeleton(
                titleWidthFactor: 0.5,
                trailingIcon: MenuItemTrailingIcon.chevronRight(),
              ),
              const SmallDivider(),
              const SmallMenuItemSkeleton(
                titleWidthFactor: 0.35,
                trailingIcon: MenuItemTrailingIcon.chevronRight(),
              ),
              const SmallDivider(),
              const SmallMenuItemSkeleton(
                titleWidthFactor: 0.45,
                trailingIcon: MenuItemTrailingIcon.options(),
              ),
              const SmallDivider(),
              const SmallMenuItemSkeleton(
                titleWidthFactor: 0.45,
                trailingIcon: MenuItemTrailingIcon.options(),
              ),
              const SmallDivider(),
              const SmallMenuItemSkeleton(
                titleWidthFactor: 0.3,
                trailingIcon: MenuItemTrailingIcon.options(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SettingsSection(
            title: 'MORE OPTIONS',
            children: [
              SmallMenuItemSkeleton(
                titleWidthFactor: 0.5,
                trailingIcon: MenuItemTrailingIcon.options(),
              ),
              SmallDivider(),
              SmallMenuItemSkeleton(
                titleWidthFactor: 0.4,
                trailingIcon: MenuItemTrailingIcon.chevronRight(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showThemeSwitcher(BuildContext context) async {
    await showBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          minimum: const EdgeInsets.only(bottom: 34),
          child: ValueListenableBuilder(
            valueListenable: context.read<SettingsController>().themeMode,
            builder: (context, mode, _) {
              return ThemeSwitcher(
                selectedMode: mode,
                onChanged: (mode) {
                  context
                      .read<SettingsController>()
                      .setThemeMode(themeMode: mode);
                },
                onClose: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}
