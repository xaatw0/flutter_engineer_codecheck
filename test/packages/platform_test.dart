import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('環境変数を取得する', () async {
    final env = Platform.environment;
    expect(env.containsKey('FLUTTER_TEST'), true);
    expect(env['FLUTTER_TEST'], 'true');

    expect(env.containsKey('OS'), true);
    // print(env['OS']);
    // Windows 11→ Windows_NT
  });

  test('OSの判定', () async {
    final env = Platform.environment;

    if (env['OS'] == 'Windows_NT') {
      expect(Platform.isWindows, true);
    } else if (env['OS'] == 'Mac') {
      expect(Platform.isMacOS, true);
    }
  });

  test('Platform.operatingSystem', () async {
    // 家のWindows 11
    expect(Platform.operatingSystem, 'windows');
    expect(Platform.operatingSystemVersion,
        '"Windows 10 Home" 10.0 (Build 22621)');
  });
}
