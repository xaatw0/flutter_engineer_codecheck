import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// GoldenTestのユーティリティクラス
/// 解像度参考: https://fastcoding.jp/blog/all/info/designwidth-2022-2/
class GoldenTestUtility {
  // 縦向き
  /// iPhone5.5 縦向き
  static const iPhone55P =
      Device(name: 'iPhone55P', size: Size(414, 736), devicePixelRatio: 3);

  /// iPhone6.5 縦向き
  static const iPhone65P =
      Device(name: 'iPhone65P', size: Size(414, 896), devicePixelRatio: 3);

  /// iPad 12.9インチ 縦向き
  static const iPad129P =
      Device(name: 'iPad129P', size: Size(1366, 1024), devicePixelRatio: 2);

  // 横向き
  /// iPhone5.5 横向き
  static const iPhone55L =
      Device(name: 'iPhone55L', size: Size(736, 414), devicePixelRatio: 3);

  /// iPhone6.5 横向き
  static const iPhone65L =
      Device(name: 'iPhone65L', size: Size(896, 414), devicePixelRatio: 3);

  /// iPad 12.9インチ 横向き
  static const iPad129L =
      Device(name: 'iPad129L', size: Size(1024, 1366), devicePixelRatio: 2);

  // PC
  /// デスクトップブラウザ
  static const webDesktop = Device(name: 'desktop', size: Size(1920, 1080));

  /// ラップトップブラウザ
  static const webLaptop = Device(name: 'laptop', size: Size(1536, 864));

  /// デバイスの一覧
  List<Device> get devices => [
        iPhone55P,
        iPhone65P,
        iPad129P,
        iPhone55L,
        iPhone65L,
        iPad129L,
        webDesktop,
        webLaptop,
      ];

  /// windowsのGoldenテストの結果ディレクトリ
  static const kDirWindows = 'windows';

  /// macos12のGoldenテストの結果ディレクトリ
  static const kDirMac12 = 'mac12';

  /// macos13のGoldenテストの結果ディレクトリ
  static const kDirMac13 = 'mac13';

  /// MacOS12 で動作している確認する
  bool get isMacOS12 =>
      Platform.isMacOS &&
      Platform.operatingSystemVersion.startsWith('Version 12');

  /// MacOS13 で動作している確認する
  bool get isMacOS13 =>
      Platform.isMacOS &&
      Platform.operatingSystemVersion.startsWith('Version 13');

  /// OS毎にゴールデンテストの結果を保存するディレクトリ
  String get dirOS => isMacOS12
      ? kDirMac12
      : isMacOS13
          ? kDirMac13
          : isWindows
              ? kDirWindows
              : throw UnsupportedError(
                  'Supported on only windows, mac12 and mac13',
                );
}
