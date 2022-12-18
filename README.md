# flutter_engineer_codecheck

本プロジェクトは「[株式会社ゆめみ Flutter エンジニアコードチェック課題](https://github.com/yumemi-inc/flutter-engineer-codecheck)」の課題に対する回答です。
ちなみに作成時時点では、カジュアル面談に申し込んだだけなので、「本課題が与えられ」てません。
自分の勉強しているFlutterの知識を詰め込んで、自分自身のポートフォリオになるようにしました。また(止められなければ、) 今後Flutterを勉強する方のための資料になるために公開したいと思います。

## アプリの概要
3つの画面から構成されている。
* 検索ページ
* 検索結果ページ
* レポジトリ詳細ページ

以下は、インテグレーションテストを動画で撮影し、30秒目までインテグレーションテスト(実機での自動テスト)を撮影し、31秒目から各機能の解説になってます。
![flutterccodecheck](https://user-images.githubusercontent.com/7291860/208287960-30719948-ff93-4152-977b-b6376a8fa2bc.gif)
大きい画面向けのmp4は、[こちら](https://github.com/xaatw0/flutter_engineer_codecheck/blob/master/flutterccodecheck.mp4)。

## 言葉の定義
* 本システム
  このレポジトリから作成されるシステム。
  Github APIからデータを取得し表示する。Android, iOSのアプリとホスティングできるWebページを生成できる。
  最終的には、WindowsとMacでも動かしたい。

* ドメイン知識
  扱う業務に関する知識。
  本システムでは、Gitからデータを取得するところと各ソート方法。

* ゴールデンテスト
  Flutterの自動テストの一種。最初に正解用の画像を作成し、その画像を目視確認する。その後はテストする毎に画像を生成し、画像を異なる場合に失敗するテスト。目視確認の手間が減るが、OSやOSのバージョンによって生成する画像が微妙に異なるので、CI実施時は注意が必要(となることが今回分かった)
  以下が詳しい。[Udemy: 60分で分かるFlutter Golden Tests ](https://flutter.salon/gt)

* インテグレーションテスト
  Flutterで実機やエミュレータを使って、実際にアプリを自動で起動・動作させるテスト。
  古いテスト方法があるが、今回は新しいテスト方法を採用している[(参考: Flutterの新しいIntegration Testの導入)](https://zenn.dev/sakusin/articles/4a3a5f0510438e)。

* CI
  続的インテグレーション。
  本システムでは、ユニットテスト(ドメインは真面目にしている)、Widgetテスト(していない)、ゴールデンテスト(ページは本気)、インテグレーションテスト(本気)で取り組んでいる。
  本システムではCode Magicベースのため、Githubにプッシュしてから実施されるようになっている。たぶんGithubにPushした瞬間実施されるのが正解だろう。

* CD
  継続的デリバリ
  本システムでは、CodeMagicベースで実施している。
  最終的には、Google Play Concole と AppStoreConnectに生成したバイナリが登録され、Firebase Hostingに設定されるところまでいきたい。

* アプリストア
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
  何番目のページを取得するかを設定する。本アプリでも使用しているデフォルト設定では1ページに30個のレポジトリを取得する。2ページ面は、31-60番目のレポジトリが表示される。

### APIで取得した結果の以下の項目を使用します
* 該当リポジトリのリポジトリ名: name
* 該当リポジトリのオーナーアイコン: owner.
* 該当リポジトリのプロジェクト言語: avatar_url
* 該当リポジトリのStar 数: stargazers_count
* 該当リポジトリのWatcher 数: watchers_count
* 該当リポジトリのFork 数: forks_count
* 該当リポジトリのIssue 数: open_issues_count

対応
* API取得できるWatchers数がStars数と同じで、WEBページの値と異なるため、API自体にバグがあると思われる。(修正されることを期待して表示はする)
* 返信が、検索結果、レポジトリの詳細、所有者の情報に分かれているので、それぞれFreezedでDTO(Data Transfer Object)を作成した。(lib/infrastructures/github_repositories/dto)
* DTOから扱いやすいようにするデータクラスに変換している。(lib/domain/entities/git_repository_data.dart)

## 使用した技術(アピールポイント)
### 機能
＊ソート方法を選択できる
* テーマ切り替えボタンがある
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
  対応するViewで表示する値をRiverpodのStateProviderで持っている。値を参照するProviderへのget、イベントに対するファンクションも持っている。
  RIverpodを利用してリアクティブを実現している。StateNotifierを使用するサンプルが多いが、通常のクラスの方が単純で使いやすいので、通常のDartでクラスを作成している。
  ファンクションはViewのイベントに対応しており、StateProviderの値を書き換える処理をする。
  getはStateProviderの値を外部で取得できるようにしており、Viewでgetを参照して画面にリアクティブに表示できる。
  ファンクション内に簡単なロジックも記載している。(良いかどうかは不明)

詳しくは[Udemy: Flutter x Riverpod x MVVMで実現するシンプルな設計](https://flutter.salon/riverpod)を参照。

迷いポイント
* ダイアログの表示は[adaptive_dialog](https://pub.dev/packages/adaptive_dialog)を採用しているので、Viewの設定がほぼない。そのためViewModelの中に入れてある。これで良いのか、Viewに入れるのが正解か、ダイアログの表示項目のロジックがあるので独立させるのが良いのか。

###  国際化対応
Google翻訳の自動翻訳機能を使って、75言語に対応している。
詳しい方法は[Udemy: 最短で75言語に対応させ、あなたのアプリを世界の人が届ける方法](https://flutter.salon/l10n)を参照
#### 知りたい点
ソート方法をSortMethodとしてenumで定義している。enumの値を国際化を対応させる方法が知りたい。enumの内部には固定値しか持てないため、contextが必要なenum内部に設定することができない。
国際語対応の機能にキーと対応する文字列が一緒になった単純なマップがあれば解決するのだが、、、

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

*レポジトリ詳細ページ
表示領域が横640ピクセル未満の場合、Starsなどの項目がアイコンの下に2列で表示される。640ピクセル以上の場合、アイコンの右側に横4列で表示される。

### Flutter Web 対応
上記のレスポンシブ対応に加えて、Flutter Webの日本語入力の以下に問題点に対応している
* 日本語変換中にTabキーを押すと、変換中でも次のTabに移動する
* 日本語変換中に変換したい文字列を矢印で選択すると、すでに選択した文字に文字選択があたる。

Flutter Webそのものの問題なので、いかんともしがたいが、一時的な解決策はあったので実施する。

### MockとDIを使用したテスト


### ゴールデンテスト
### インテグレーションテスト
各画面のれ
### アニメーション
* 検索結果一覧のレポジトリカード
  押している間小さくなり、離すと元に戻る。必要があれば、その後にアクションをする(画面遷移)
* テーマ切り替えボタン
  表と裏があり、押すと回転して、テーマが切り替わる。[https://pub.dev/packages/flip_card](flip_card)は使用していない。
* 検索画面のGithubのアイコン
  上がりながら徐々に登場する
  ・結果一覧ページとレポジトリ詳細ページの遷移
  Heroを使用して、遷移すると前のページのアイコンが次のページの場所にアニメーションする

### Semantic対応
### CodeMagicによるCI/CD
### 細かい工夫
* レポジトリ詳細ページのGithubアイコンを押すと、該当Githubレポジトリがブラウザで開かれる
* lib/domain/repository_data_type.dart で関連ファイルをexportしているので、このファイルをインポートすれば、大量のファイルをインポートせずにすむ

現在設定中。テストコンパイルは通過して、AndroidとiOS用のパッケージを作成するところまで進みました。引き続き、アプリストアへの自動配信までを目指す。

参考
[CodemagicでFlutter(iOS & Android)アプリを自動配信-全体設定編](https://riscait.medium.com/build-and-publish-a-flutter-app-with-codemagic-2fac4da0ebe9)



## 一般知識
### 使用したプラグイン
* DI: get_it
* テストのモック:mockto
* インテグレーションテスト:integration_test(新しい方)

### テスト結果の画像はPixel5aで実施したデータ

### DIを使って、モックでデータを取得する
GithubAPIで直接Githubのレポジトリのデータを使うと、状態で結果が変わる。しかしhttp.Clientがモックのため毎回同じデータを取得できるので、表示結果お案じことが期待される。

### DIを使って、画面の縦向き横向きを設定
インテグレーションテストを実施すると、現在の端末の向きで実施される。その場合の問題点として、毎回端末を固定しなければならなく、縦横のテストをそれぞれ実施する必要がある。
その問題点を避けるため、DIを使ってテストケースから端末を縦向きに設定し、テストをし、その後、横向きに設定しテストすることで、一度のテストで実施でき、端末の向きを気にする必要もない。

### インテグレーションテストでの実施項目
テキストとアイコンをタップ、テキスト入力、キーボード表示(画面には表示されるが、キャプチャーできない)、画面遷移、ドラッグ(画面スクロール)
Widgetの数の確認

## 課題
Pixel5aでの実施が前提になっているので、検索結果ページで10項目表示される前提でキャプチャしている。実際の使用では、以下をけす必要がある
expect(find.byType(RepositoryDataCard), findsNWidgets(10));

- 「VMServiceFlutterDriver: request_data message is taking a long time to complete... 」と表示されて、テストが開始されないときがある(2回に1回、Issueあり)
  [integration_test package pauses isolates and calling pumpAndSettle() never finishes. #73355](https://github.com/flutter/flutter/issues/73355)

## アトミックデザインの詳細
アトミックデザインそのものの考え方がWebベースであるし、Flutterで採用した場合の解釈もまちまちですが、本システムでは以下のように定義しています。
#### Atoms（原子)
Widget単体から成り立つ。基本のWidgetは汎用性が高いので、用途を限定させるために作成する。状態を持っていない。
ドメイン、ビジネスロジックは持たず、上位のWidgetからの定義が必要。
もしくは、特定の目的を果たすためのWidget。

* GithubIcon: Githubのアイコンを表示させる専用のWidget。
* CancelTabKey: Flutter Web使用時にTabキーの入力があった場合、キャンセルするという目的を実施している

#### Molecules（分子）
複数のWidgeから構成される。色々な用途に使える(はずの再利用可能なデザインを作成する。
ドメイン、ビジネスロジックは持たず、上位のWidgetからの定義が必要。
状態を持っていない。ただ、Widget Treeの下の方に所属していて、データの受け渡しで「バケツリレー」しなければならない場合、状態管理を使用する。

* SearchTextField: 検索キーワード入力用のTextField。TextFieldと2つのアイコンから成り立っている。デザインは定義しているが、検索やソート方法選択用のダイアログの実施は上位からファンクションを渡されているので、これ自体にはロジックはない。
* RepositoryDataCard: レポジトリの簡易的な情報を表示するためのWieget。画像やテキストなど複数のWidgetから成り立っている。アプリで共通の「ソート方法」を取得するのに、内部で状態管理の取得を使っている。

#### Organisms（有機体）
複数のWidgeから構成される。色々な用途に使える(はずの再利用可能なデザインを作成する。
ドメイン、ビジネスロジックを持っているページのどこかに配置する特定の用途の専用のWidget。
状態を持っている。また、状態管理へアクセスして良い。

* SunAndMoonCoin: テーマの切り替えボタンという目的がある独立したWidget.。

#### Templates（テンプレート）
複数のPageで共有するレイアウトを定義するWidget。

* DayNightTemplate: 本システムで共通となる「AppBarとテーマ切り替えボタンがある」テンプレート。

#### Pages（ページ）
画面に表示されるページのWidget。該当のページで適応させるTemplateを外枠にして、中に定義していく。

* SearchPage: 検索ページ

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
トップにはdomain, ui, infrastructuresのプロダクトコードの3つのディレクトリ、test, integration_test, test_driverのテストコードの3つのディレクトリがある。
その他は

### domain
業務知識に関わるコードを収めている。
業務知識のため、変更が少ないと考えられる。その部分を切り出して、変更が大きいUIの影響をなるべく受けないようにする。
またこの部分にはGUIがない。そのため、簡単にテストコードを作成し、メンテナンスし続けることができる。

データベースやWEBAPIなどの外部システムは、他社の都合で変更される。変更による開発システムへの影響を少なくしたい。そのため、Domain内にRepositoryを定義する。
この中で抽象クラスとして「したいこと」の関数を定義し、Infrastructures内に実際のクラスを作成する。

・infrastractures
それぞれのプラットフォーム(SharedPreferenceやSecureStorage)や外部システム(Firestore)に依存する実像クラスが入っている。抽象クラスはdomain/repositoriesに入っている。
依存する外部システムが変更になった場合でも、実像クラスを作成し、DIの元データを切り替えれば、domainやuiのプログラムを変更しなくても動作するようにしている（例えば、FirebaseをSpabaseに切り替えた時など）

・ui
Flutterによるアプリケーションが収まっている。

ディレクトリは機能ごとに分けてある。
実際に呼び出されるWidgetはPage、その中で呼び出されるWidgetはそれぞれのディレクトリに入っている。その中に関連のあるコントローラとしてディレクトリを作成して収めている。

・test
テストコード。

●domainのディレクトリ
業務知識についてのプログラムが入っている。業務知識とアプリとのコードを分ける考え方としては、このアプリがコマンドラインになったとしても、流用できるソースを業務知識としている。
・domain/value_objects
DDDでいうところのValueObjectsが入っている。ValueObjectsはintやStringなどの値を基本一つ持っている。それに加えて、その値を操作する関数を持っている。
ValueObjectを使用する利点としては、int型をそのまま使用した場合、メソッドの引数に使用した場合、別の引数を間違える可能性がある。その可能性を大幅に減らすことができる。
また、そのObjectに関連するメソッドや表示方法などを一カ所に集約することができる。

・domain/entities
DDDのEntitiesが入っている。リテラル型やValueObjectsなどをメンバー変数に持ち、データモデルとなります。
データクラスの場合、データのみを保存しています。しかしEntityの場合、データモデルで必要になる操作なども含まれて、関連する処理を一カ所に集約しています。
Freezedを使用することでImmutableを実現してます。

・domain/entities/converter
ValueObjectsやEntitiesはJson変換にFreezedの機能を使用しています。しかしDateTimeについてはJson変換をする機能がないので、DateTime用のコンバータを作成してます。

・domain/repositories
FirebaseやWebAPIなど外部システムとの通信が必要になる機能を抽象クラスを作成しています。抽象クラスとすることで、「やりたいこと」を記載します。実際に「行うこと」は抽象クラスを継承した実装クラスで実現してます。
外部システムはこちらの意図とは別に変更される可能性があるため、その変更が実装クラス内で収まるようにします。domain内では抽象クラスを使用することで、外部システムの変更にdomain内のクラスの影響が出ないようにします。
DIを使用して、どの実装クラスをどの抽象クラスに割り当てるかを決定している。

・domain/services
ドメインサービスのプログラムが入っています。
送料の計算や検索結果の整列順などデータがないものをサービスとして設定してます。

●infrastructures
domain/repositories で定義した抽象クラスの実装クラスを作成している。

・infrastructures/device_repositories
デバイスに保存するためのクラスが入っている。
スマートフォンに保存する場合SecureStorage, FlutterWebで保存する場合SharedPreferencesで保存する。

・infrastructures/firebase_repositories
Firebaseと通信を行うクラスが作成されている。

FirebaseAuthenticationRepository については、FirebaseAuthenticationからのエラーをユーザへのメッセージになるように、Authenticationのエラーコードとシステムのエラーメッセージの対応を定義してある。

・infrastructures/firebase_repositories/dto
domain内で定義したモデルがデータベースに格納するのに適していない場合がある。そのときには、DTO(Data Transfer Object)を使って、データベースに適切な形式に変換してからデータを保存する。

・infrastructures/postal_code_repositorise
郵便番号に対応する住所をWebAPIで取得取得している。将来別のWebAPIに変わっても新しいクラスを作成し、DIで変更するだけで対応できる。

・infrastructures/postal_code_repositorise/dto
郵便番号を取得するAPIの結果と、アプリ内で使用するモデルとで違いがある。その違いの橋渡しとなるDTOクラスを作成している。

●ui
アプリの画面構成を作成するクラスを作成している

・ui/activity
それぞれの画面とそれに関するコントローラを作成してある

・ui/controller
アプリ全体で使用するコントローラーを作成している

・ui/helper
各画面で使用される共通のWidgetを定義してある

・ui/theme
アプリで使用されるテーマと色を定義してる

●test
domain,uiに関連するテストが格納されている