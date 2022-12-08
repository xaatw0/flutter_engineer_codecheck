import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/my_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 起点クラス
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
