/// 文字列の定義
/// 国際化対応に入れようかと思いましたが、訳しても変な単語にしかならない気がしたので、共通にしました。
class StringResources {
  /// 空文字
  static const kEmpty = '';

  /// GithubのStarの文字列
  static const kStar = 'Stars';

  /// GithubのForksの文字列
  static const kForks = 'Forks';

  /// GithubのWatchersの文字列
  static const kWatchers = 'Watchers';

  /// GithubのIssuesの文字列
  static const kIssues = 'Issues';

  /// GithubのDescriptionの文字列
  static const kDescription = 'Description';

  /// Githubの更新日時の文字列
  static const kUpdate = 'Update';

  /****** 以下、本来は言語ファイルに入れるもの **/
  static const kLblFindInGithub = 'Githubで検索できます。キーワードを入力して、検索ボタンを押してください';
  static const kLblTheme = '画面のライトモードとダークテーマを入れ替えます';
  static const kLblSortMethod = '検索結果のソート方法を設定します';
  static const kLblGoGithub = '押すとGithubのレポジトリに移動します';
  static const kLblNotFound = '何も見つかりませんでした';
}
