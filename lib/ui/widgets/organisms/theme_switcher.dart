import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart' as AppTheme;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../gen/assets.gen.dart';

/// ライトテーマとダークテーマの切り替えボタン
class ThemeSwitcher extends ConsumerStatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  ConsumerState<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends ConsumerState<ThemeSwitcher> {
  /// 太陽と月のアイコンのサイズ
  static const iconSize = 48.0;

  @override
  Widget build(BuildContext context) {
    final assetPath = ref.watch(AppTheme.themeMode) == ThemeMode.light
        ? Assets.images.dayIcon
        : Assets.images.nightIcon;
    return IconButton(
      onPressed: () {
        ref.read(AppTheme.themeMode.notifier).update(
              (state) =>
                  state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
            );
      },
      icon: SvgPicture.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
