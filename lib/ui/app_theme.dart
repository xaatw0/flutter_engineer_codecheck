import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アプリのテーマ

/// 現在のテーマ(システムのテーマモードを初期値に設定する)
final themeMode = StateProvider<ThemeMode>((ref) {
  final brightness = SchedulerBinding.instance.window.platformBrightness;
  return brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
});

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
    primarySwatch: Colors.grey,
    accentColor: Colors.orangeAccent,
  ),
  appBarTheme: appBarTheme,
);

/// ダークモード時のテーマ
final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: appBarTheme,
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    accentColor: Colors.orangeAccent,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.grey),
    ),
  ),
);
