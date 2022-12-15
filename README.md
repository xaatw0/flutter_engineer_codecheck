# flutter_engineer_codecheck

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 準備
# 実行前
flutter pub get
flutter pub run build_runner build
flutter gen-l10n

# テストの実施
flutter test
flutter test --update-goldens
flutter test --update-goldens .\test\ui\pages\search_page/search_page_test.dart

flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart

# Github APIの調査
## APIの送信仕様
WEB APIは以下を使用する
https://api.github.com/search/repositories?q=${検索キーワード}&page=${ページ目}

## APIで取得した結果の以下の項目を使用します
該当リポジトリのリポジトリ名: name
該当リポジトリのオーナーアイコン: owner.
該当リポジトリのプロジェクト言語: avatar_url
該当リポジトリのStar 数: stargazers_count
該当リポジトリのWatcher 数: watchers_count
該当リポジトリのFork 数: forks_count
該当リポジトリのIssue 数: open_issues_count

ただ、API取得できるWatcher 数がStar数と同じで、WEBページの値と異なるため、API自体にバグがあると思われる。(修正されることを期待して表示はする)
返信が、検索結果、レポジトリの詳細、所有者の情報に分かれているので、それぞれFreezedでDTO(Data Transfer Object)を作成した。(lib/infrastructures/github_repositories/dto)
そのDTOから扱いやすいようにするデータクラスに変換している。(lib/domain/entities/git_repository_data.dart)


# 国際化対応
## ゴールデンテスト

## インテグレーションテスト
# 一般知識
# 本アプリでの特徴
インテグレーションテストを追加した
## 使用したプラグイン
DI: get_it モック:mockto インテグレーションテスト:integration_test(新しい方)
## テスト結果の画像はPixel5aで実施したデータ

## DIを使って、モックでデータを取得する
GithubAPIで直接Githubのレポジトリのデータを使うと、状態で結果が変わる。しかしhttp.Clientがモックのため毎回同じデータを取得できるので、表示結果お案じことが期待される。

# DIを使って、画面の縦向き横向きを設定
インテグレーションテストを実施すると、現在の端末の向きで実施される。その場合の問題点として、毎回端末を固定しなければならなく、縦横のテストをそれぞれ実施する必要がある。
その問題点を避けるため、DIを使ってテストケースから端末を縦向きに設定し、テストをし、その後、横向きに設定しテストすることで、一度のテストで実施でき、端末の向きを気にする必要もない。

## インテグレーションテストでの実施項目
テキストとアイコンをタップ、テキスト入力、キーボード表示(画面には表示されるが、キャプチャーできない)、画面遷移、ドラッグ(画面スクロール)
Widgetの数の確認

## 課題
Pixel5aでの実施が前提になっているので、検索結果ページで10項目表示される前提でキャプチャしている。実際の使用では、以下をけす必要がある
expect(find.byType(RepositoryDataCard), findsNWidgets(10));

- 「VMServiceFlutterDriver: request_data message is taking a long time to complete... 」と表示されて、テストが開始されないときがある(2回に1回、Issueあり)
[integration_test package pauses isolates and calling pumpAndSettle() never finishes. #73355](https://github.com/flutter/flutter/issues/73355)



●全体
全体の構成は、DDD(Domain Drive Development)をベースにしている。
トップにはdomain, ui, infrastructures, testの4つのディレクトリがある。

・domain
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