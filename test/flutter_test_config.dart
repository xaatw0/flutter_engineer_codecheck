import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Golden TestをWindowsとMacでのみ実施する設定
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      /// 日本語のフォントを読み込む
      final fontFile = File('test/assets/NotoSansJP-Regular.otf');
      final fontData = await fontFile.readAsBytes();
      final fontLoader = FontLoader('Roboto')
        ..addFont(Future.value(ByteData.view(fontData.buffer)));
      await fontLoader.load();
      await loadAppFonts();

      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => !(Platform.isWindows || Platform.isMacOS),
    ),
  );
}
