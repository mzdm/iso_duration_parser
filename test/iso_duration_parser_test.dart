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
          years: 0,
          months: 0,
          weeks: 0,
          days: 0,
          hours: 0,
          minutes: 10,
          seconds: 0,
        ),
      );
      expect(isoDuration.isZero, false);
      expect(isoDuration.toSeconds(), 600);
      expect(isoDurationNullable, isNotNull);
      expect(isoDuration, isoDurationNullable);

      input = 'P0M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(months: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.isZero, true);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDurationNullable, isNotNull);
      expect(isoDuration, isoDurationNullable);

      input = 'PT0S';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(seconds: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.isZero, true);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDurationNullable, isNotNull);
      expect(isoDuration, isoDurationNullable);

      input = 'P4M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(months: 4));
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));
      expect(isoDurationNullable, isNotNull);

      input = 'P4M2W';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(months: 4, weeks: 2));
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));
      expect(isoDurationNullable, isNotNull);

      input = 'P5Y';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(years: 5));
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));
      expect(isoDurationNullable, isNotNull);

      input = 'P5Y2M10D';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(years: 5, months: 2, days: 10));
      expect(isoDuration.isZero, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));
      expect(isoDurationNullable, isNotNull);

      input = 'P3Y6M4DT12H30M5S';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration.isZero, false);
      expect(
        isoDuration,
        IsoDuration(
          years: 3,
          months: 6,
          weeks: 0,
          days: 4,
          hours: 12,
          minutes: 30,
          seconds: 5,
        ),
      );
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));
      expect(isoDurationNullable, isNotNull);
      expect(isoDuration, isoDurationNullable);

      input = 'P1DT12H';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(days: 1, hours: 12));
      expect(isoDuration.toSeconds(), 129600);
      expect(isoDurationNullable, isNotNull);

      input = 'PT15H';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(hours: 15));
      expect(isoDuration.toSeconds(), 54000);
      expect(isoDurationNullable, isNotNull);

      input = 'PT36H';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(hours: 36));
      expect(isoDuration.toSeconds(), 129600);
      expect(isoDurationNullable, isNotNull);

      input = 'PT8H15M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(hours: 8, minutes: 15));
      expect(isoDuration.toSeconds(), 29700);
      expect(isoDurationNullable, isNotNull);

      input = 'PT2H25M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(hours: 2, minutes: 25));
      expect(isoDuration.toSeconds(), 8700);
      expect(isoDurationNullable, isNotNull);

      input = 'PT16H35M';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(hours: 16, minutes: 35));
      expect(isoDuration.toSeconds(), 59700);
      expect(isoDurationNullable, isNotNull);
    });

    test('decimal input', () {
      input = 'PT8M40.215S';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(
        isoDuration,
        IsoDuration(
          years: 0,
          months: 0,
          weeks: 0,
          days: 0,
          hours: 0,
          minutes: 8,
          seconds: 40.215,
        ),
      );
      expect(isoDuration.toSeconds(), 520.215);
      expect(isoDurationNullable, isNotNull);

      input = 'PT0.5S';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(seconds: 0.5));
      expect(isoDuration.toSeconds(), 0.5);
      expect(isoDurationNullable, isNotNull);

      input = 'PT0,5S';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(seconds: 0.5));
      expect(isoDuration.toSeconds(), 0.5);
      expect(isoDurationNullable, isNotNull);

      input = 'P0.5Y';
      isoDuration = IsoDuration.parse(input);
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDuration, IsoDuration(years: 0.5));
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));
      expect(isoDurationNullable, isNotNull);
    });

    // TODO: Possibility to parse negative ISO duration values
    // test('negative values', () {
    //   input = '-P10D';
    //   isoDuration = IsoDuration.parse(input);
    //   expect(isoDuration, IsoDuration(days: -10));
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

    test('minus must not be after P', () {
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

    test('T must must be present when using hrs, mins or secs', () {
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

    test('contains empty space', () {
      input = 'P 5M';
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

    test('random unrelated input', () {
      input = '_';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);

      input = '';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);

      input = ' ';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);

      input = 'PnYnMnDTnHnMnS';
      expect(() => IsoDuration.parse(input), throwsA(isA<FormatException>()));
      expect(IsoDuration.tryParse(input), null);
    });
  });
}
