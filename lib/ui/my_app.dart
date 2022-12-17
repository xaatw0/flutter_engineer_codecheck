import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_theme.dart' as app_theme;
import 'package:flutter_engineer_codecheck/ui/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

/// テーマの設定と切り替え。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => MaterialApp.router(
        // テーマ
        themeMode: ref.watch(app_theme.themeMode),
        theme: app_theme.lightTheme,
        darkTheme: app_theme.darkTheme,

        // GoRouter
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,

        // 多言語対応
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: GetIt.I.isRegistered<Locale>() ? GetIt.I<Locale>() : null,
      ),
    );
  }
}
