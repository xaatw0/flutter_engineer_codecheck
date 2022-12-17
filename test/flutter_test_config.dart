import 'dart:async';
import 'dart:io';

import 'package:golden_toolkit/golden_toolkit.dart';

/// Golden TestをMacでのみ実施する設定
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
}
