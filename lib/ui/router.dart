import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/pages/repository_detail_page/repository_detail_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_page/search_page.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_result_page/search_result_page.dart';

import 'package:go_router/go_router.dart';
import '../domain/entities/git_repository_data.dart';
import '../domain/value_objects/count_fork.dart';
import '../domain/value_objects/count_issue.dart';
import '../domain/value_objects/count_star.dart';
import '../domain/value_objects/count_watcher.dart';
import '../domain/value_objects/owner_icon_url.dart';
import '../domain/value_objects/project_language.dart';
import '../domain/value_objects/repository_description.dart';
import '../domain/value_objects/repository_name.dart';

/// アプリ全体の遷移用のルート設定
final router = GoRouter(
  initialLocation: RepositoryDetailPage.path,
  routes: [
    // 検索ページ
    GoRoute(
      path: '/aa', //SearchPage.path,
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
      },
    ),
    // レポジトリ詳細ページ
    GoRoute(
        path: '/', //RepositoryDetailPage.path,
        pageBuilder: (BuildContext context, GoRouterState? state) {
          final data = GitRepositoryData(
            repositoryName: RepositoryName('flutter'),
            ownerIconUrl: OwnerIconUrl(
                'https://avatars.githubusercontent.com/u/14101776?v=4'),
            projectLanguage: ProjectLanguage('Dart'),
            repositoryDescription: RepositoryDescription(
                'Flutter makes it easy and fast to build beautiful apps for mobile and beyond'),
            countStar: CountStar(146985),
            countWatcher: CountWatcher(146985),
            countFork: CountFork(23912),
            countIssue: CountIssue(11313),
          );
          return MaterialPage(child: RepositoryDetailPage(data));
        })
  ],
);
