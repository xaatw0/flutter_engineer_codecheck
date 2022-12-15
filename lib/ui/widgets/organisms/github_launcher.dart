import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/atoms/github_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart' as app_theme;

/// Githubをブラウザで開くためのボタン
class GithubLauncher extends StatelessWidget {
  GithubLauncher(this.url, {super.key});

  /// ブラウザで開くURL
  final String url;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      return GithubIcon(
        size: 32,
        isDarkMode: ref.watch(app_theme.themeMode) == ThemeMode.dark,
      );
    });
  }
}
