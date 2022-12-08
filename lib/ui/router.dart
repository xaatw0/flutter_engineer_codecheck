import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_page/search_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page.dart';
import 'package:go_router/go_router.dart';

/// アプリ全体の遷移用のルート設定
final router = GoRouter(
  initialLocation: SearchPage.path,
  routes: [
    // 検索ページ
    GoRoute(
      path: SearchPage.path,
      pageBuilder: (BuildContext context, GoRouterState? state) {
        return const MaterialPage(
          child: SearchPage(),
        );
      },
    ),
    // 検索結果ページ
    GoRoute(
        path: SearchResultPage.path,
        pageBuilder: (BuildContext context, GoRouterState? state) {
          final keyword = state?.params[SearchResultPage.kKeyword]?.toString();

          return keyword != null && keyword.isNotEmpty
              ? MaterialPage(
                  child: SearchResultPage(
                    keyword: keyword,
                  ),
                )
              : const MaterialPage(
                  child: SearchPage(),
                );
        })
  ],
);
