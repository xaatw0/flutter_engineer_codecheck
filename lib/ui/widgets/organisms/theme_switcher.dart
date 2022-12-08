import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ライトテーマとダークテーマの切り替えボタン
class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) => DayNightSwitcher(
        isDarkModeEnabled: ref.watch(AppTheme.themeMode) == ThemeMode.dark,
        onStateChanged: (bool isDarkModeEnabled) => ref
            .read(AppTheme.themeMode.notifier)
            .state = isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
