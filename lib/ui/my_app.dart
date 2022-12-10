import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app_theme.dart';

/// テーマの設定と切り替え。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => MaterialApp.router(
        // テーマ
        themeMode: ref.watch(AppTheme.themeMode),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.dartTheme,

        // GoRouter
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,

        // 多言語対応
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
