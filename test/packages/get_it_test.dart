import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() async {
  test('register again', () async {
    expect(GetIt.I.isRegistered<List<DeviceOrientation>>(), false);

    GetIt.I.registerSingleton<List<DeviceOrientation>>(
      [DeviceOrientation.portraitUp],
    );
    expect(GetIt.I.isRegistered<List<DeviceOrientation>>(), true);
  });
}
