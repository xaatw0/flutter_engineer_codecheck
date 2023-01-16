import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/atoms/owner_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_test_utility.dart';

Widget target() => MaterialApp(
      home: Column(
        children: const [
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
  final utility = GoldenTestUtility();
  final dirOS = utility.dirOS;

  testGoldens('OwnerImage', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(
      target(),
      surfaceSize: utility.devices.first.size,
    );
    await screenMatchesGolden(tester, '$dirOS/OwnerImage');
  });
}
