import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('環境変数を取得する', () async {
    final env = Platform.environment;
    expect(env.containsKey('FLUTTER_TEST'), true);
    expect(env['FLUTTER_TEST'], 'true');

    // 家の Windows 11
    // expect(env.containsKey('OS'), true);
    // print(env['OS']);
    // Windows 11→ Windows_NT

    // 家のMacBook Pro
    // macosでは、存在しない
    // expect(env.containsKey('OS'), false);
  });

  test('OSの判定', () async {
    final env = Platform.environment;

    if (env['OS'] == 'Windows_NT') {
      expect(Platform.isWindows, true);
    } else if (env['OS'] == 'Mac') {
      expect(Platform.isMacOS, true);
    }
  });

  final runOnWindows = <String, dynamic>{
    'linux': Skip('Windowsのみでテスト'),
    'mac-os': Skip('Windowsのみでテスト'),
    'browser': Skip('Windowsのみでテスト'),
  };
  final runOnMacOS = <String, dynamic>{
    'windows': Skip('MacOSのみでテスト'),
    'linux': Skip('MacOSのみでテスト'),
    'browser': Skip('MacOSのみでテスト'),
  };

  final runOnLinux = <String, dynamic>{
    'windows': Skip('runOnLinux'),
    'mac-os': Skip('runOnLinux'),
    'browser': Skip('runOnLinux'),
  };

  test(
    'run on windows',
    onPlatform: runOnWindows,
    () async {
      // 家のWindows 11
      expect(Platform.operatingSystem, 'windows');
      expect(Platform.isWindows, true);
    },
  );

  test(
    'run on macos',
    onPlatform: runOnMacOS,
    () async {
      expect(Platform.operatingSystem, 'macos');

      // 家のMacBook Pro で有効
      // expect(Platform.operatingSystemVersion, 'Version 13.1 (Build 22C65)');

      expect(Platform.isMacOS, true);
    },
  );

  test(
    'Platform.operatingSystem',
    skip: true,
    () async {
      // 家のWindows 11
      expect(Platform.operatingSystem, 'windows');
      expect(Platform.operatingSystemVersion,
          '"Windows 10 Home" 10.0 (Build 22621)');

      // 家のMacBook Pro
      expect(Platform.operatingSystem, 'macos');
      expect(Platform.operatingSystemVersion, 'Version 13.1 (Build 22C65)');
    },
  );
}
