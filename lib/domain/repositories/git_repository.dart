import '../entities/git_repository_data.dart';

/// Gitからデータを取得するためのレポジトリクラス (Gitのソース解離のレポジトリと間違えやすい)。
/// Githubだけではなく、他のGitでデータ取得をするケースも想定して、抽象クラスを作成する。
abstract class GitRepository {
  /// キーワードに対する検索結果を取得する
  Future<List<GitRepositoryData>> search(String keyword);
}
