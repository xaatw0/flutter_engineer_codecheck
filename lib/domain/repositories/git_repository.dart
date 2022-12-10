import '../entities/git_repository_data.dart';

/// Gitの検索結果の表示順
enum SortMethod {
  /// ベストマッチ順
  bestMatch,

  /// スターが多い順
  starDesc,

  /// スターが少ない順
  starAsc,

  /// フォークが多い順
  forkDesc,

  /// フォークが少ない順
  forkAsc,

  /// 更新日時が新しい順
  recentlyUpdated,

  /// 更新日時が古い順
  leastRecentlyUpdate;

  String toJson() => toString();
}

/// Gitからデータを取得するためのレポジトリクラス (Gitのソース解離のレポジトリと間違えやすい)。
/// Githubだけではなく、他のGitでデータ取得をするケースも想定して、抽象クラスを作成する。
abstract class GitRepository {
  /// キーワードに対する検索結果を取得する
  /// [page]で何ページ目かを指定する。Githubでは、最初のページは1ページ目。
  Future<List<GitRepositoryData>> search(
    String keyword, {
    int page = 1,
    SortMethod sortMethod,
  });

  /// 最初の1ページ目のインデックス
  int getFirstPageIndex();
}
