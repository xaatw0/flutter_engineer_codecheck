import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アプリのテーマ
class AppTheme {
  /// 現在のテーマ
  static final themeMode = StateProvider((ref) => ThemeMode.light);

  /// ライトモード時のテーマ
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: Colors.grey.shade100,
  );

  /// ダークモード時のテーマ
  static final dartTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: Colors.grey.shade900,
  );
}
