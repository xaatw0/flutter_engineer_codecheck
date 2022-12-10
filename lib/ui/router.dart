import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/pages/repository_detail_page/repository_detail_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_page/search_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page.dart';

import 'package:go_router/go_router.dart';
import '../domain/entities/git_repository_data.dart';
import '../domain/repositories/git_repository.dart';

/// アプリ全体の遷移用のルート設定
final router = GoRouter(
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
        final sortMethod = state?.extra;

        return keyword != null &&
                keyword.isNotEmpty &&
                sortMethod != null &&
                sortMethod is SortMethod
            ? MaterialPage(
                child: SearchResultPage(
                  keyword: keyword,
                  sortMethod: sortMethod,
                ),
              )
            : const MaterialPage(
                child: SearchPage(),
              );
      },
    ),
    // レポジトリ詳細ページ
    GoRoute(
      path: RepositoryDetailPage.path,
      pageBuilder: (BuildContext context, GoRouterState? state) {
        final data = state?.extra;
        if (data != null && data is GitRepositoryData) {
          return MaterialPage(child: RepositoryDetailPage(data));
        } else {
          return const MaterialPage(child: SearchPage());
        }
      },
    )
  ],
);
