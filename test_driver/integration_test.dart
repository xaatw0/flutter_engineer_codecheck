import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      onScreenshot: (String screenshotName, List<int> screenshotBytes) async {
        final image =
            await File('integration_test/screenshots/$screenshotName.png')
                .create(recursive: true);
        image.writeAsBytesSync(screenshotBytes);
        return true;
      },
    );
  } on Exception catch (e) {
    // ignore: avoid_print
    print('Exception was thrown: $e');
  }
}
