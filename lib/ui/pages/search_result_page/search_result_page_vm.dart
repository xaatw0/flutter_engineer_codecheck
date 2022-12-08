import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_engineer_codecheck/infrastructures/github_repositories/github_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 剣客結果を表示するページのViewModel
class SearchResultPageVm {
  final _repositoryData = FutureProvider.autoDispose
      .family<List<GitRepositoryData>, String>((ref, keyword) async {
    final result = GithubRepository().search(keyword);
    return result;
  });

  AsyncValue<List<GitRepositoryData>> getRepositoryData(String keyword) =>
      _ref.watch(_repositoryData(keyword));

  late final WidgetRef _ref;
  void setRef(WidgetRef ref) {
    _ref = ref;
  }
}
