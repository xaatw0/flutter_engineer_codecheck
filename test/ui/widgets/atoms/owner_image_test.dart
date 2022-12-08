import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/atoms/owner_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Widget target() => MaterialApp(
      home: Column(
        children: [
          OwnerImage(
            url: 'test',
            size: 32,
          ),
          OwnerImage(
            url: 'test',
            size: 64,
          ),
        ],
      ),
    );

void main() {
  testGoldens('OwnerImage', (WidgetTester tester) async {
    await loadAppFonts();

    const size6 = Size(375, 667);
    await tester.pumpWidgetBuilder(target(), surfaceSize: size6);
    await screenMatchesGolden(tester, 'OwnerImage');
  });
}
