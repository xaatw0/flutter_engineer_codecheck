# flutter_engineer_codecheck

本プロジェクトは「[株式会社ゆめみ Flutter エンジニアコードチェック課題](https://github.com/yumemi-inc/flutter-engineer-codecheck)」の課題に対する回答です。
ちなみに作成時時点では、カジュアル面談に申し込んだだけなので、「本課題が与えられ」てません。
自分の勉強しているFlutterの知識を詰め込んで、自分自身のポートフォリオになるようにしました。また(止められなければ、) 今後Flutterを勉強する方のための資料になるために公開したいと思います。

## アプリの概要
3つの画面から構成されている。
* 検索ページ
* 検索結果ページ
* レポジトリ詳細ページ

| 検索ページ|  検索結果ページ |  レポジトリ詳細ページ  |
| ---- | ---- |  ----  |
|  ![検索ページ](https://user-images.githubusercontent.com/7291860/208345156-f04e03c1-4390-4fd8-b3d6-757ce8ba0ba7.png) |  ![検索結果ページ](https://user-images.githubusercontent.com/7291860/208345186-893ff611-4f2d-4fa8-a575-274c787f1574.png) |  ![レポジトリ詳細ページ](https://user-images.githubusercontent.com/7291860/208345205-37539231-a1f7-46e2-b39e-61bf426335cf.png)  |


以下は、30秒目までインテグレーションテスト(実機でのモックデータを取得して自動テスト)を撮影し、大まかなアプリの流れを実施しています。31秒目からその他の各機能の解説になってます。

<div><video width="60%" controls src="https://user-images.githubusercontent.com/7291860/212442592-2b891e97-2c82-4eea-b1a7-152b4e4d2249.mp4" muted="false"></video></div>

## 言葉の定義
### 本システム
このレポジトリから作成されるシステム。
Github APIからデータを取得し表示する。Android, iOSのアプリとホスティングできるWebページを生成できる。
最終的には、WindowsとMacでも動かしたい。

### ドメイン知識
扱う業務に関する知識。
本システムでは、Gitからデータを取得するところと各ソート方法。

### ゴールデン
ゴールデンテストで最初に生成する正解用の画像。最初の作成時に目視確認をする。何で、ゴールデンというかは知らない。
「黄金」という意味だが、「黄金が価値の基準になる」みたいな意味合いで、「ゴールデン」とつけられているのではないかという推測を言っている人はいた。

###  ゴールデンテスト
Flutterの自動テストの一種。テスト実施時にWidgetから画像を作成する。
最初にゴールデンの画像を作成し、その画像を目視確認する。その後はテストする毎に画像を生成し、画像を異なる場合に失敗するテスト。目視確認の手間が減るが、OSやOSのバージョンによって生成する画像が微妙に異なるので、CI実施時は注意が必要(となることが今回分かった)
以下が詳しい。[Udemy: 60分で分かるFlutter Golden Tests ](https://flutter.salon/gt)

#### インテグレーションテストとの違い
* Widgetテストの一種のため、インテグレーションテストより断然早い
* インテグレーションテストは画像をキャプチャするだけだが、ゴールデンテストは生成した画像を比較して誤差を(超シビアに)判定してくれる

###  インテグレーションテスト
Flutterで実機やエミュレータを使って、実際にアプリを自動で起動・動作させるテスト。
古いテスト方法があるが、今回は新しいテスト方法を採用している[(参考: Flutterの新しいIntegration Testの導入)](https://zenn.dev/sakusin/articles/4a3a5f0510438e)。

###  CI
続的インテグレーション。
本システムでは、ユニットテスト(ドメインは真面目にしている)、Widgetテスト(していない)、ゴールデンテスト(ページは本気)、インテグレーションテスト(本気)で取り組んでいる。
本システムではCode Magicベースのため、Githubにプッシュしてから実施されるようになっている。たぶんGithubにPushした瞬間実施されるのが正解だろう。

###  CD
継続的デリバリ
本システムでは、CodeMagicベースで実施している。
最終的には、Google Play Concole と AppStoreConnectに生成したバイナリが登録され、Firebase Hostingに設定されるところまでいきたい。

###  アプリストア
AndroidだとGoogle Play、iOSだとApp Store、WebだとFirestore Hostingを指す

## 準備
### ダウンロード
git clone https://github.com/xaatw0/flutter_engineer_codecheck.git

### 実行前
flutter pub get
flutter gen-l10n
flutter pub run build_runner build

### テストの実施
#### テスト全て(インテグレーションテストを除く)を実施
flutter test

#### ゴールデンテストの正解画像を更新
flutter test --update-goldens
flutter test --update-goldens .\test\ui\pages\search_page/search_page_test.dart

#### インテグレーションテストを実施
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart

## Github APIの調査
### APIの送信仕様
WEB APIは以下を使用する
https://api.github.com/search/repositories?q=検索キーワード&page=ページ
* 検索キーワード:
  検索するキーワード

* ページ
  何番目のページを取得するかを設定する。Githubでは1ページ目のインデックスが1。
  本アプリではデフォルト設定と同じく1ページで30個のレポジトリを取得する。1ページ目は1-30番目のレポジトリ、2ページ目は31-60番目のレポジトリが取得できる。

### APIで取得した結果の以下の項目を使用します
* 該当リポジトリのリポジトリ名: name
* 該当リポジトリのオーナーアイコン: owner.avatar_url
* 該当リポジトリのプロジェクト言語: language
* 該当リポジトリのStar 数: stargazers_count
* 該当リポジトリのWatcher 数: watchers_count
* 該当リポジトリのFork 数: forks_count
* 該当リポジトリのIssue 数: open_issues_count
* 該当リポジトリの概略: description
* 該当リポジトリの作成日時: created_at
* 該当リポジトリの更新日時: open_updated_at


### 以下のように対応しました
* API取得できるWatchers数がStars数と同じで、WEBページの値と異なるため、API自体にバグがあると思われる。ただ、修正されることを期待して表示はする
* 返信が、検索結果、レポジトリの詳細、所有者の情報に分かれているので、それぞれFreezedでDTO(Data Transfer Object)を作成した。(lib/infrastructures/github_repositories/dto)
* DTOのメンバー変数の名前をAPIの項目名と合わせることで、わかりやすくコードを作成しできた。命名規則は、Jsonの項目名はスネーク形式、Dartクラスはパスカル方式だが、Freezedで以下の設定をすることでDartのパスカル方式のままJsonの項目に一致させられる。

``` 
@JsonSerializable(fieldRename: FieldRename.snake)
```

* DTOはGithubの仕様にも基づくので、github_repositories内にある
* DTOをそのまま使うとコーディングしづらいので、ドメイン内のデータクラスに変換して使用する。(lib/domain/entities/git_repository_data.dart)

## アピールポイントと使用した技術
### 機能
* ソート方法を選択できる
* テーマ切り替えボタンがあり、テーマを切り替えられる。デフォルトはシステムの設定から取得する
* 検索結果は最初にデフォルトの30項目を取得し、一番下まで行くと次のページのデータを取得する
* レポジトリ詳細ページのGithubを押すと、該当のレポジトリのページをブラウザで開く


###  DDD(Domain Driven Development)によるレイヤー構造
* DDDをベースとして、ドメイン知識を一つのディレクトリにまとめている(可能なら、別プロジェクトにするのが正解だと思われる)。詳しくは、「[ファイル構造の詳細](#ファイル構造の詳細)」にて説明。
### ファイル構造
* ドメイン(ドメイン知識)、UI(アプリ関連)、インフラストラクチャ(外部通信用のクラス)を分離
* UIを関心ベースで構造化
  同一フォルダにView(ページ)、ViewModel(ページに表示したいデータ、実施したい項目が入っている)、Logic(ドメイン知識でないページ独自のロジック)を集めている
* アトミックデザインによるWidget管理
  UIの情報を、Atoms（原子)、Molecules（分子）、Organisms（有機体）、Templates（テンプレート）、Pages（ページ）に分割するUIデザインシステム(参考：[アトミックデザインとは？5つのコンポーネントから作るUIデザイン手法 ](https://www.creativevillage.ne.jp/category/topcreators/web-creator/web-designer/94262/)))
  本システムでのシステム内容は[詳細にて後述](#アトミックデザインの詳細)します。

###  RIverpodを使用したMVVM
* MVVMモデルを採用している
* View
  ConsumerStatefulWidget や StatelessWidgetの継承クラスで、Widgetによる画面デザインとユーザイベントへ対応して呼び出すViewModelのメソッドを定義している。
* ViewModel
  対応するViewで表示する値をRiverpodのStateProviderで持っている。値を参照するProviderへのget、イベントに対するメソッドも持っている。
  RIverpodを利用してリアクティブを実現している。StateNotifierを使用するサンプルが多いが、通常のクラスの方が単純で使いやすいので、通常のDartでクラスを作成している。
  メソッドはViewのイベントに対応しており、StateProviderの値を書き換える処理をする。
  getはStateProviderの値を外部で取得できるようにしており、Viewでgetを参照して画面にリアクティブに表示できる。
  メソッド内に簡単なロジックも記載している。(良いかどうかは不明)

詳しくは[Udemy: Flutter x Riverpod x MVVMで実現するシンプルな設計](https://flutter.salon/riverpod)を参照。

迷いポイント
* ダイアログの表示は[adaptive_dialog](https://pub.dev/packages/adaptive_dialog)を採用しているので、Viewの設定がほぼない。そのためViewModelの中に入れてある。これで良いのか、Viewに入れるのが正解か、ダイアログの表示項目のロジックがあるので独立させるのが良いのか。

###  国際化対応
Google翻訳の自動翻訳機能を使って、75言語に対応している。
詳しい方法は[Udemy: 最短で75言語に対応させ、あなたのアプリを世界の人が届ける方法](https://flutter.salon/l10n)を参照
#### 知りたい点
ソート方法をSortMethodとしてenumで定義している。enumの値を国際化を対応させる方法が知りたい。国際化対応した文字は、**AppLocalizations.of(context)** で取得するため、contextが必要になる。一方でenumの内部には固定値しか持てないため、contextをもつことができない。
国際語対応の機能にキーと対応する文字列が一緒になった単純なマップがあれば解決する。build_runner の勉強に作成したい。

#### 残念な点
言語ファイルや翻訳は自動作成できても、アプリストアのページの言語毎の設定を自動でしてくれるわけではない。

### テーマに対応
アプリの右上のボタンを押すことで、ライトモードとダークモードの入れ替えを行える。初期値はシステムのダークモードから設定している。
RIverpod を使用してテーマの切換を実現している。

### レスポンシブ対応
スマーフォン、タブレット、ブラウザの使用を前提として、縦向き横向きで対応している。
contextを拡張する形で対応している。
対応点は以下の通り
* 全体
  表示領域が横1024ピクセル以上になっても、コンテンツを表示する領域は最大1024ピクセルとなり、両端に空白ができる
* 検索画面
  アプリで横向きの場合、キーボードが表示されると、Githubのアイコンとテーマの切り替えボタンが消える。キーワードを入力すると、Githubのアイコンが消えて、「検索」ボタンが現れる
  アプリの場合、検索はキーボードの決定ボタンを前提としているので、キーワード入力前は検索ボタンが非表示で、入力されると表示される。

* レポジトリ詳細ページ
  表示領域が横640ピクセル未満の場合、Starsなどの項目がアイコンの下に2列で表示される。640ピクセル以上の場合、アイコンの右側に横4列で表示される。

### Flutter Web 対応
上記のレスポンシブ対応に加えて、Flutter Webの日本語入力の以下に問題点に対応している
* 日本語変換中にTabキーを押すと、変換中でも次のTabに移動する
* 日本語変換中に変換したい文字列を矢印で選択すると、すでに選択した文字に文字選択があたる。

Flutter Webそのものの問題なので、いかんともしがたいが、上記2つに対する一時的な解決策は見つかったので実施する。今後も改善を試みたい。Enterによるフォーカス移動は実現したい。
現時点では、デフォルトのcanvas-rendererだと発生し、web-renderer に変えると発生しないことが分かっている。

### レポジトリパターンを採用
DBやWeb APIなどの外部システムは、他社の都合でインターフェースが変更される。また、別システムに変更する可能性もある。開発システムへの影響を少なくしたい。そのため、レポジトリパターンを使用してる。(本システムでは、ほぼAPIの仕様変更はないでしょうが)
「したいこと」をドメインのRepository内に抽象クラスとして定義し、「すること」をインフラストラクチャにシステム毎に定義する。ドメイン内の呼び出す側と、インフラストラクチャの呼び出される側を分割することで、外部システムの影響をインフラストラクチャ内だけで完結できる。

### MockとDIを使用したテスト
DI (Dependency Injection、依存性注入)を利用している。テスト時にMockを利用して、以下を実現している。
* Github APIでの取得データのモックデータ取得
* インテグレーションテスト実施時の縦向き横向きの固定
* ViewModelをモック化して、独立したViewのテスト

### ゴールデンテスト
Mac mini(macOS 12.5.1)で正解データを作成し、Code Magicにてゴールデンテストができるようにした。OSやOSのバージョンによって、生成する画像が異なる。実施した所感を[こちら](https://flutter.salon/others/cicd/)にまとめた。

### インテグレーションテスト
Pixel 5aとiPhoneSE(2nd Generation)の実機にてインテグレーションテストを実施した。

### アニメーション
* 検索結果一覧のレポジトリカード
  押している間小さくなり、離すと元に戻る。その後に画面遷移を行う
* テーマ切り替えボタン
  表と裏があり、押すと回転して、テーマが切り替わる。[flip_card](https://pub.dev/packages/flip_card)パッケージは使用していない。
* 検索画面のGithubのアイコン
  上がりながら徐々に登場する
  ・結果一覧ページと、レポジトリ詳細ページの間の遷移
  Heroを使用して、遷移すると前のページのアイコンが次のページの場所にアニメーションする

### Semantic対応
Semanticを設定して、AndroidのTalkBackで確認した。

### CodeMagicによるCI/CD
現在設定中。テストとコンパイルは通過して、Code Magic内でAndroidとiOS用のパッケージを作成するところまで進みました。引き続き、アプリストアへの自動配信までを目指す。

参考
[CodemagicでFlutter(iOS & Android)アプリを自動配信-全体設定編](https://riscait.medium.com/build-and-publish-a-flutter-app-with-codemagic-2fac4da0ebe9)

### 使用したプラグイン
* DI: get_it
* テストのモック:mockto
* インテグレーションテスト:integration_test(新しい方)

### 細かい工夫
* レポジトリ詳細ページのGithubアイコンを押すと、該当Githubレポジトリがブラウザで開かれる
* lib/domain/repository_data_type.dart で関連ファイルをexportしているので、このファイルをインポートすれば、大量のファイルをインポートせずにすむ





### DIを使って、モックでデータを取得する
GithubAPIで直接Githubのレポジトリのデータを使うと、状態で結果が変わる。しかしhttp.Clientがモックのため毎回同じデータを取得できるので、表示結果が常に同じことが期待される。

### DIを使って、画面の縦向き横向きを設定
インテグレーションテストを実施すると、現在の端末の向きで実施される。その場合の問題点として、毎回端末を固定しなければならなく、縦横のテストをそれぞれ実施する必要がある。
その問題点を避けるため、DIを使ってテストケースから端末を向きを設定する。最初のテストで縦向きに設定し、次のテストで横向きに設定しテストすることで、一度のテストで実施でき、端末の向きをテスターが気にする必要がない。

### インテグレーションテストでの実施項目
* テキストとアイコンをタップ
* テキスト入力
* キーボード表示(画面には表示されるが、キャプチャーできない)
* 画面遷移
* ドラッグ(画面スクロール)

## 課題
### インテグレーションテストについて、改善の余地がある
* Androidでテストが開始されないことがある
  「VMServiceFlutterDriver: request_data message is taking a long time to complete... 」と表示されて、テストが開始されないときがある(2回に1回、Issueあり)
  [integration_test package pauses isolates and calling pumpAndSettle() never finishes. #73355](https://github.com/flutter/flutter/issues/73355)

* iPhoneで画像キャプチャができない

## アトミックデザインの詳細
アトミックデザインそのものの考え方がWebベースであるし、Flutterで採用した場合の解釈もまちまちですが、本システムでは以下のように定義しています。
#### Atoms（原子)
Widget単体から成り立つ
基本のWidgetは汎用性が高いので、用途を限定させるために作成する。もしくは、特定の目的を果たすためのWidget。
状態を持っていない。
ドメイン、ビジネスロジックは持たず、上位のWidgetからの定義が必要。

* GithubIcon: Githubのアイコンを表示させる専用のWidget。
* CancelTabKey: Flutter Web使用時にTabキーの入力があった場合、キャンセルするという目的を実施している

#### Molecules（分子）
複数のWidgeから構成される。色々な用途に使える(はずの)再利用可能なデザインを作成する。
ドメイン、ビジネスロジックは持たず、上位のWidgetからの定義が必要。
状態を持っていない。

* SearchTextField: 検索キーワード入力用のTextField。TextFieldと2つのアイコンから成り立っている。デザインは定義しているが、検索やソート方法選択用のダイアログの実施は上位からファンクションを渡されているので、これ自体にはロジックはない。
* RepositoryDataCard: レポジトリの簡易的な情報を表示するためのWieget。画像やテキストなど複数のWidgetから成り立っている。アプリで共通の「ソート方法」を取得するのに、内部で状態管理の取得を使っている。

#### Organisms（有機体）
複数のWidgeから構成される。色々な用途に使える(はずの)再利用可能なデザインを作成する。
ドメイン、ビジネスロジックを持っているページのどこかに配置する特定の用途の専用のWidget。
状態を持っている。また、状態管理を更新して良い。

* SunAndMoonCoin: テーマの切り替えボタンという目的がある独立したWidget.。

#### Templates（テンプレート）
複数のPageで共有するレイアウトを定義するWidget。

* DayNightTemplate: 本システムで共通となる「AppBarとテーマ切り替えボタンがある」テンプレート。

#### Pages（ページ）
画面に表示されるページのWidget。該当のページで適応させるTemplateを外枠にして、中に定義していく。

* SearchPage: 検索ページ
*
#### 状態管理との関係性
全てのWidgetから状態管理にアクセスできると、どこから更新されているか分からなくなり、チームで混乱が生じる。そのため、使用目的があるOrganismsとPagesからのみアクセスできるように限定した方が設計としては良いと考える。
ただWidget Treeの下の方に所属していて、状態管理への読み取りが必要な場合、データの受け渡しで「バケツリレー」することになる。それを避けるためにAtomsとMoleculesでも状態管理の読込は可能にしようがよいかと考える。

#### ファイル構成
uiの中にwidgetsとpagesを作成する。widgetsの中にatoms, molecules, organisms, templatesを作成し、該当のWidgetをいれる。pagesにはページ名のディレクトリを作成し、その中にページのWidgetを入れる。
pagesを別にするのは、ページに関連するクラス(ViewModelやページのロジック)を一カ所に収めたい。またpagesがないと、widgetsのフォルダの並びが粒度の小さい順に並べられる。

```
ui
├─pages
│  ├─search_page
│  │      search_page.dart
│  └─search_result_page
│          search_result_page.dart
│
└─widgets
    ├─atoms
    │      cancel_tab_key.dart
    │      github_icon.dart
    ├─molecules
    │      repository_data_card.dart
    ├─organisms
    │      sun_and_moon_coin.dart
    └─templates
            day_night_template.dart
```

## ファイル構造の詳細
全体の構成は、DDD(Domain Drive Development)をベースにしている。
トップにはdomain, ui, infrastructuresのプロダクトコードの3つのディレクトリ、test, integration_test, test_driverのテストコードの3つのディレクトリがある。その他は通常のFlutterと同様。

「[C#でドメイン駆動開発とテスト駆動開発を使って保守性の高いプログラミングをする方法](https://www.amazon.co.jp/C-%E3%81%A7%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA%E3%81%A8%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E4%BF%9D%E5%AE%88%E6%80%A7%E3%81%AE%E9%AB%98%E3%81%84%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E3%82%92%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95-%E3%83%94%E3%83%BC%E3%82%B3%E3%83%83%E3%82%AF%E3%82%A2%E3%83%B3%E3%83%80%E3%83%BC%E3%82%BD%E3%83%B3-ebook/dp/B078ZF79CL/ref=sr_1_3?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&crid=21FGDKGBAI3FM&keywords=C%23%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3&qid=1671351733&s=digital-text&sprefix=c+%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3%2Cdigital-text%2C281&sr=1-3)」をベースにFlutter用にアレンジしている。


### domain
ドメインに関わるコードを収めている。
業務知識のため、変更が少ないと考えられる。その部分を切り出して、変更が大きいUIの影響をなるべく受けないようにする。
また、この部分にはGUIがない。そのため、簡単にテストコードを作成し、メンテナンスし続けることができる。

データベースやWEBAPIなどの外部システムは、他社の都合で変更される。変更による開発システムへの影響を少なくしたい。そのため、Domain内にRepositoryを定義する。
この中で抽象クラスとして「したいこと」の関数を定義し、Infrastructures内に実際のクラスを作成する。

### infrastractures
それぞれのプラットフォーム(SharedPreferenceやSecureStorage)や外部システム(Firestore)に依存する実装クラスが入っている。抽象クラスはdomain/repositoriesに入っている。
依存する外部システムが変更になった場合でも、実装クラスを作成し、DIの元データを切り替えれば、domainやuiのプログラムを変更しなくても動作するようにしている（例えば、FirebaseをSpabaseに切り替えた時など）

### ui
Widgetによるアプリケーションが収まっている。

ディレクトリは機能ごとに分けてある。
実際に呼び出されるWidgetはPage、その中で呼び出されるWidgetはそれぞれのディレクトリに入っている。その中に関連のあるコントローラとしてディレクトリを作成して収めている。

### test
ユニットテスト、Widgetテスト、ゴールデンテストのコードが入っている。ゴールデンテストの成功画像が入っている。
ゴールデンテストに失敗すると、正解画像、テスト画像、差分画像2種類がテスト毎に作成されて、failureディレクトリに入る。

### test_driver
インテグレーションテストを開始するためのコードが入っている。

### integration_test
インテグレーションテストで実施するコードが入っている。

#### integration_test/screenshots
インテグレーションテストが実施されてキャプチャされた画像がこのディレクトリに生成される(ように設定してある)。
確認して問題なかった画像は、実施機器名のフォルダに入れてある。

## lib直下
### main.dart
DIと画面の向きの設定をする

## domainのディレクトリ
ドメインについてのコードが入っている。ドメインとアプリとのコードを分ける考え方としては、このアプリがコマンドラインになったとしても、流用できるコードを「ドメイン」としている。

### lib/domain/value_objects
DDDでいうところのValueObjectが入っている。ValueObjectはintやStringなどの値を基本一つ持っている。それに加えて、その値を操作する関数を持っている。
ValueObjectを使用する利点としては、int型をそのまま使用した場合、メソッドの引数に使用した場合、別の引数を間違える可能性がある。その可能性を大幅に減らすことができる。
また、そのObjectに関連するメソッドや表示方法などを一カ所に集約することができる。
ディレクトリの中のvalue_object.dartに定義したValueObjectを継承して作成する。

(値が二つ以上のValueObjects)
お金などは複数の値が必要になる。
100円は100という値と、円という単位の2つのデータから成り立っている。

(留意点)
現在それぞれのValueObjectに対して、Converterクラスを付随させている。画面遷移時に例外が発生したため作成したが、なんらかの工夫で取り除けるかも知れない。
全てのデータに対してValueObjectsを作成するのは、やりすぎか、とは思っています。

### lib/domain/entities
DDDのEntitiesが入っている。リテラル型やValueObjectsなどをメンバー変数に持つ、データモデルとなります。
データクラスの場合、データのみを保存しています。しかしEntityの場合、データモデルで必要になる操作なども含まれて、関連する処理を一カ所に集約しています。

#### ValueObjectsと関係
データベースでいうところの、RowがEntity、ColumnがValueObjectと考えるとイメージしやすい。

#### Freezedの使用
Json変換が必要であればFreezed, 必要なければ通常のDartクラスで良い

### lib/domain/entities/converter
ValueObjectsやEntitiesはJson変換のためFreezedの機能を使用しています。しかしDateTimeについてはJson変換をする機能がないので、DateTime用のコンバータを作成してます。

### lib/domain/repositories
データベースやWebAPIなど外部システムとの通信が必要になる機能を抽象クラスを作成してます。抽象クラスとすることで、「やりたいこと」を記載します。実際に「行うこと」は抽象クラスを継承した実装クラスで実現してます。
今回はGithubとのWebAPIだけなので、抽象クラスを作る必要はほぼありませんが、今後の参考に作ります。その他のGitサーバに同等のAPIがあるようなら、ここの抽象クラスを実装すれば本システムで動作します。

### lib/domain/services
ドメインサービスのコードが入っています。データのあるロジックはEntity内に入れますが、データのないロジックはサービスとして設定してこちらに定義します。
本システムでは未使用です。

## infrastructures のディレクトリ
domain/repositories で定義した抽象クラスの実装クラスを作成している。

### lib/infrastructures/github_repositories
Github APIを使用してデータを取得するコードが入っています。
github_repository.dartには、Github用の検索用URLを作成するメソッド、実際にデータを取得するメソッドが入っている。

## ui
アプリの画面構成を作成するクラスを作成している。

### lib/ui/pages
ページ毎にディレクトリを作成している。

### lib/ui/widgets
ページのパーツとなるWiegetを作成している

### lib/ui/my_app.dart
アプリケーションが起動するクラス。
テーマ、ルート、多言語対応の切換を実施する。


## testのディレクトリ
「flutter test」で実行されるテスト(インテグレーションテスト以外のテスト。つまり、ユニットテスト、Widgetテスト、ゴールデンテストの３種類)のコードが格納されている。

### testのルート
* test\flutter_test_config.dart
  テスト全体の設定を定義できる。
  本システムでは、「MacOS以外ではゴールデンテストをとばす」と定義している。

### ゴールデンテストのあるディレクトリ
各ディレクトリにあるテストコードの中にゴールデンテストがあった場合、同じディレクトリに以下のディレクトリが作成される
* goldens: ゴールデンを新規作成
* failures: テストを実行して、ゴールデンテストが失敗した時
#### goldens
各ディレクトリの「goldens」に[ゴールデン](#ゴールデン)が入っている。こちらは「flutter test --update-goldens」で自動作成された画像となる。
最初の作成時に一度目視確認をして、問題がなければGitに登録しておく。再度自動生成した場合、前のゴールデンと新しく作成したゴールデンがエディタ上で並べられて見られる。この機能でコミット前にまとめて変更された箇所が確認できる。
#### failures
各ディレクトリの「failures」には、「flutter test」でゴールデンテストを失敗したときの画像が入っている。
失敗したテストの、ゴールデン、テスト時に生成した画像、２つの画像を差分画像と合成画像の４つの画像が作成される。つまり「失敗したテストの数 *４」の画像が生成される

### test/assets
テスト実施時に必要で、アプリ実行時に不要なアセットを入れる。

### test/domain
ドメインに対するテストが入っている。

### test/packages
パッケージに対するテストが入っている。パッケージに対するテストが必要な理由は以下の通り。
* README.mdの内容で動作するか、実際の使い方を試す
* 導入するのに必要な機能が入っていることを確認する
* パッケージのバージョンが上がった場合に確認する
  破壊的変更があり、コンパイルエラーが発生しないか
  以前と同じように動作し続けているか実行してテストする(動作が変わった場合、プロダクトコードの中より、単体テストのコードの方が容易に発見できる)

### なんとか_mocks.dart のファイル
各ディレクトリにファイル名の最後が「_mocks.dart」となっているファイルがある。こちらは「_mock」を抜いたファイル名のテストコードから、mockitoが作成したファイルとなります。作成元のファイルで使用されるMockクラスをmockitoが「flutter pub run build_runner build」時に自動生成します。

## インテグレーションテストのディレクトリ
### test_driverのディレクトリ
#### test_driver/integration_test.dart
インテグレーションテストをはじめるためのコードがある。
インテグレーションテストでスクリーンショットの設定がある。
### integration_testrのディレクトリ
インテグレーションテストで実施する項目が書かれたコードと実施結果がある
#### integration_test/app_test.dart
インテグレーションテストで実行するコード

