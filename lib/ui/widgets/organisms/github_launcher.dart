import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart' as app_theme;
import 'package:flutter_engineer_codecheck/ui/widgets/atoms/github_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Githubをブラウザで開くためのボタン
class GithubLauncher extends StatelessWidget {
  const GithubLauncher(this.url, {super.key});

  /// ブラウザで開くURL
  final String url;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        return Semantics(
          container: true,
          label: 'アイコンボタンDayo',
          child: IconButton(
            icon: Semantics(
              label: 'アイコンDayo',
              child: GithubIcon(
                size: 32,
                isDarkMode: ref.watch(app_theme.themeMode) == ThemeMode.dark,
              ),
            ),
            onPressed: _launchUrl,
          ),
        );
      },
    );
  }

  /// ブラウザでGithubを開く
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('以下を開くことができませんでした $url');
    }
  }
}
