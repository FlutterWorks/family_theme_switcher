import 'package:family_theme_switcher/settings_controller.dart';
import 'package:family_theme_switcher/settings_screen/settings_screen.dart';
import 'package:family_theme_switcher/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SettingsController(),
      dispose: (_, controller) => controller.dispose(),
      builder: (context, _) {
        return ValueListenableBuilder(
          valueListenable: context.read<SettingsController>().themeMode,
          builder: (context, themeMode, _) {
            return MaterialApp(
              themeMode: themeMode,
              theme: AppTheme.lightTheme,
              highContrastTheme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              highContrastDarkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              home: const SettingsScreen(),
            );
          },
        );
      },
    );
  }
}
