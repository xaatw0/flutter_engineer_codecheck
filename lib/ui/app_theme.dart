import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アプリのテーマ
class AppTheme {
  /// 現在のテーマ
  static final themeMode = StateProvider((ref) => ThemeMode.light);

  /// AppBarのテーマ(透明)
  static const appBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  );

  /// ライトモード時のテーマ
  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey.shade100,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: Colors.grey,
      accentColor: Colors.orangeAccent,
    ),
    appBarTheme: appBarTheme,
  );

  /// ダークモード時のテーマ
  static final dartTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: appBarTheme,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.grey,
      accentColor: Colors.orangeAccent,
    ),
  );
}
