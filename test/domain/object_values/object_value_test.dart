import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:flutter_test/flutter_test.dart';

class IntValueObject extends ValueObject<int> {
  IntValueObject(super.value);
}

class StringValueObject extends ValueObject<String> {
  StringValueObject(super.value);
}

main() {
  test('int', () async {
    final target = IntValueObject(100);
    expect(target.toString(), 'IntValueObject[100]');
    expect(target(), 100);
    expect(target.value, 100);

    expect(IntValueObject(200)(), 200);
  });

  test('string', () async {
    final target = StringValueObject('abc');
    expect(target.toString(), 'StringValueObject[abc]');
    expect(target(), 'abc');
    expect(target.value, 'abc');

    expect(StringValueObject('ABC')(), 'ABC');
  });
}
