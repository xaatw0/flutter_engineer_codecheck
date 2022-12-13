import 'package:flutter_engineer_codecheck/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('start', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await binding.takeScreenshot('test-screenshot');
  });
}
