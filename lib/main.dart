import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/infrastructures/github_repositories/github_repository.dart';
import 'package:flutter_engineer_codecheck/ui/my_app.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_page/search_page_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

/// 起点クラス
void main() {
  initDI();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// DIの設定
void initDI() {
  GetIt.I.registerSingleton<GitRepository>(GithubRepository());
  GetIt.I.registerSingleton<SearchPageVm>(SearchPageVm());
}
