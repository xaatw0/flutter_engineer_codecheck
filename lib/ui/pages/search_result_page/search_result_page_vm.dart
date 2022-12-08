import 'package:flutter_engineer_codecheck/domain/entities/git_repository_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/repositories/git_repository.dart';

/// 剣客結果を表示するページのViewModel
class SearchResultPageVm {
  final _repositoryData = FutureProvider.autoDispose
      .family<List<GitRepositoryData>, String>((ref, keyword) async {
    final result = GetIt.I.get<GitRepository>().search(keyword);
    return result;
  });

  AsyncValue<List<GitRepositoryData>> getRepositoryData(String keyword) =>
      _ref.watch(_repositoryData(keyword));

  late final WidgetRef _ref;
  void setRef(WidgetRef ref) {
    _ref = ref;
  }
}
