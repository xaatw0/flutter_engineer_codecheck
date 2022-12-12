import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アプリのテーマ

/// 現在のテーマ
final themeMode = StateProvider((ref) => ThemeMode.light);

/// AppBarのテーマ(透明)
const appBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
);

/// ライトモード時のテーマ
final lightTheme = ThemeData(
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
final dartTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: appBarTheme,
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    accentColor: Colors.orangeAccent,
  ),
);
