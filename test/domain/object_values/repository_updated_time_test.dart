import 'package:flutter_engineer_codecheck/domain/value_objects/repository_created_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() async {
  final timeOffset = DateTime.now().timeZoneOffset.inHours;

  test('datetime test', () async {
    // 2012年3月4日 5時6分7秒
    final datetime = DateTime(2012, 3, 4, 5, 6, 7);
    expect(datetime.toString(), '2012-03-04 05:06:07.000');
    expect(datetime.toIso8601String(), '2012-03-04T05:06:07.000');

    expect(
      DateTime.parse('2022-12-06T18:37:57Z'),
      DateTime(2022, 12, 6, 18 + 9, 37, 57).toUtc(),
    );

    expect(
      DateTime(2022, 12, 6, 18 + 9, 37, 57).toUtc().toString(),
      '2022-12-06 18:37:57.000Z',
    );

    expect(
      DateTime(2022, 12, 6, 18 + timeOffset, 37, 57).toUtc().toIso8601String(),
      '2022-12-06T18:37:57.000Z',
    );

    final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    expect(
      formatter.format(DateTime(2022, 12, 6, 18, 37, 57)),
      '2022-12-06T18:37:57',
    );
  });

  test('converter', () async {
    const converter = RepositoryCreateTimeConverter();
    expect(
      converter.fromJson('2022-12-06T18:37:57Z')(),
      DateTime(2022, 12, 6, 18 + 9, 37, 57).toUtc(),
    );
    expect(
      converter.toJson(
        RepositoryCreateTime(DateTime(2022, 12, 6, 18 + timeOffset, 37, 57)),
      ),
      '2022-12-06 18:37:57.000Z',
    );
  });
}
