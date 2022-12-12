import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:flutter_test/flutter_test.dart';

class IntValueObject extends ValueObject<int> {
  IntValueObject(super.value);
}

class IntValueAnotherObject extends ValueObject<int> {
  IntValueAnotherObject(super.value);
}

class StringValueObject extends ValueObject<String> {
  StringValueObject(super.value);
}

void main() {
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

  test('compare', () {
    final value1 = IntValueObject(1);
    final value1_ = IntValueObject(1);
    final value2 = IntValueObject(2);
    final value3 = IntValueAnotherObject(1);

    expect(value1, value1_);
    expect(value1 == value1_, true);
    expect(value1 == value2, false);
    expect(value1 == value3, false);
  });
}
