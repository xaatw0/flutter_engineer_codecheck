import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_engineer_codecheck/domain/repositories/git_repository.dart';
import 'package:flutter_engineer_codecheck/infrastructures/github_repositories/github_repository.dart';
import 'package:flutter_engineer_codecheck/ui/my_app.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_page/search_page_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

/// 起点クラス
void main() {
  initDI();
  WidgetsFlutterBinding.ensureInitialized();

  final orientations = GetIt.I.get<List<DeviceOrientation>>();
  SystemChrome.setPreferredOrientations(
    orientations,
  );
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

  // インテグレーションテストを実施するときは、すでに登録済のため、再登録はしない
  if (!GetIt.I.isRegistered<List<DeviceOrientation>>()) {
    GetIt.I.registerSingleton<http.Client>(http.Client());
    GetIt.I.registerSingleton<List<DeviceOrientation>>([]);
  }
}
