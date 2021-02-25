import 'package:iso_duration_parser/iso_duration_parser.dart';
import 'package:test/test.dart';

void main() {
  late String input;
  IsoDuration isoDuration;
  IsoDuration? isoDurationNullable;

  group('valid input', () {
    test('positive input', () {
      input = 'PT10M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(
        isoDuration,
        IsoDuration(
          inYears: 0,
          inMonths: 0,
          inWeeks: 0,
          inDays: 0,
          inHours: 0,
          inMinutes: 10,
          inSeconds: 0,
        ),
      );
      expect(isoDuration.isZero, false);
      expect(isoDurationNullable, isNotNull);
      expect(isoDuration, isoDurationNullable);

      input = 'P0M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inMonths: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.isZero, true);
      expect(isoDurationNullable, isNotNull);
      expect(isoDuration, isoDurationNullable);

      input = 'PT0S';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inSeconds: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.isZero, true);
      expect(isoDurationNullable, isNotNull);
      expect(isoDuration, isoDurationNullable);

      input = 'P4M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inMonths: 4));
      expect(isoDurationNullable, isNotNull);

      input = 'P4M2W';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inMonths: 4, inWeeks: 2));
      expect(isoDurationNullable, isNotNull);

      input = 'P5Y';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inYears: 5));
      expect(isoDurationNullable, isNotNull);

      input = 'P5Y2M10D';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inYears: 5, inMonths: 2, inDays: 10));
      expect(isoDuration.isZero, false);
      expect(isoDurationNullable, isNotNull);

      input = 'P3Y6M4DT12H30M5S';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration.isZero, false);
      expect(
        isoDuration,
        IsoDuration(
          inYears: 3,
          inMonths: 6,
          inWeeks: 0,
          inDays: 4,
          inHours: 12,
          inMinutes: 30,
          inSeconds: 5,
        ),
      );
      expect(isoDurationNullable, isNotNull);
      expect(isoDuration, isoDurationNullable);

      input = 'P1DT12H';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inDays: 1, inHours: 12));
      expect(isoDurationNullable, isNotNull);

      input = 'PT15H';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inHours: 15));
      expect(isoDurationNullable, isNotNull);

      input = 'PT36H';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inHours: 36));
      expect(isoDurationNullable, isNotNull);

      input = 'PT8H15M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inHours: 8, inMinutes: 15));
      expect(isoDurationNullable, isNotNull);

      input = 'PT2H25M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inHours: 2, inMinutes: 25));
      expect(isoDurationNullable, isNotNull);

      input = 'PT16H35M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inHours: 16, inMinutes: 35));
      expect(isoDurationNullable, isNotNull);
    });

    test('decimal input', () {
      input = 'PT8M40.215S';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration,
        IsoDuration(
          inYears: 0,
          inMonths: 0,
          inWeeks: 0,
          inDays: 0,
          inHours: 0,
          inMinutes: 8,
          inSeconds: 40.215,
        ),
      );
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);

      input = 'PT0.5S';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inSeconds: 0.5));
      expect(isoDurationNullable, isNotNull);

      input = 'PT0,5S';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inSeconds: 0.5));
      expect(isoDurationNullable, isNotNull);

      input = 'P0.5Y';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(inYears: 0.5));
      expect(isoDurationNullable, isNotNull);
    });

    // TODO: Possibility to parse negative ISO duration values
    // test('negative values', () {
    //   input = '-P10D';
    //   isoDuration = IsoDuration.parse(input);
    //   expect(isoDuration, IsoDuration(inDays: -10));
    // });
  });

  group('invalid input', () {
    test('missing digit after decimal/comma', () {
      input = 'PT1,S';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);

      input = 'PT1.S';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });

    test('minus is not before P', () {
      input = 'P-10M';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });

    test(
        'T must must be absent if no time values are present (hrs, mins, secs)',
        () {
      input = 'P1Y2MT';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });

    test('T must must be present when usng hrs, mins or secs', () {
      input = 'P2H';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });

    test('missing value for M', () {
      input = 'P1YM';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });

    test('missing value for M', () {
      input = 'P1YM';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });

    test('missing values for after P', () {
      input = 'P';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });

    test('missing P literal', () {
      input = '5Y1M';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });

    test('incorrect order (M before Y)', () {
      input = 'P2M5Y';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });
  });
}
