import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_theme.dart';

/// テーマの設定と切り替え。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => MaterialApp(
        title: 'Flutter Demo',
        themeMode: ref.watch(AppTheme.themeMode),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.dartTheme,
        home: SearchResultPage(
          keyword: 'test',
        ),
      ),
    );
  }
}
