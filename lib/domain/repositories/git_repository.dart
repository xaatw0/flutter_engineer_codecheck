import '../entities/git_repository_data.dart';

/// Gitからデータを取得するためのレポジトリクラス (Gitのソース解離のレポジトリと間違えやすい)。
/// Githubだけではなく、他のGitでデータ取得をするケースも想定して、抽象クラスを作成する。
abstract class GitRepository {
  /// キーワードに対する検索結果を取得する
  /// [page]で何ページ目かを指定する。Githubでは、最初のページは1ページ目。
  Future<List<GitRepositoryData>> search(
    String keyword, {
    int page = 1,
  });

  /// 最初の1ページ目のインデックス
  int getFirstPageIndex();
}
