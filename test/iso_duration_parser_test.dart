import 'package:iso_duration_parser/iso_duration_parser.dart';
import 'package:test/test.dart';

void main() {
  late String input;
  IsoDuration isoDuration;
  IsoDuration? isoDurationNullable;

  group('valid input', () {
    test('positive input', () {
      input = 'PT10M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
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
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 600);
      expect(isoDuration, isoDurationNullable);

      input = 'P0M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.isZero, true);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDuration, isoDurationNullable);

      input = 'PT0S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(seconds: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.isZero, true);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDuration, isoDurationNullable);

      input = 'P4M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: 4));
      expect(isoDuration.isNegative, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P4M2W';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: 4, weeks: 2));
      expect(isoDuration.isNegative, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P2W1DT5M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(weeks: 2, days: 1, minutes: 5));
      expect(isoDuration.toSeconds(), 1296300);

      input = 'P5Y';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 5));
      expect(isoDuration.isNegative, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P5Y2M10D';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 5, months: 2, days: 10));
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P3Y6M4DT12H30M5S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, false);
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
      expect(isoDuration, isoDurationNullable);

      input = 'P1DT12H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(days: 1, hours: 12));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 129600);

      input = 'PT15H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 15));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 54000);

      input = 'PT36H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 36));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 129600);

      input = 'PT8H15M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 8, minutes: 15));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 29700);

      input = 'PT2H25M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 2, minutes: 25));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 8700);

      input = 'PT16H35M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 16, minutes: 35));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 59700);

      input = 'P10D';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(days: 10));
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 864000);
      expect(isoDuration, isoDurationNullable);
    });

    test('negative input', () {
      input = '-PT10M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration,
        IsoDuration(
          years: 0,
          months: 0,
          weeks: 0,
          days: 0,
          hours: 0,
          minutes: -10,
          seconds: 0,
        ),
      );
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.toSeconds(), -600);
      expect(isoDuration, isoDurationNullable);

      input = '-P0M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.isZero, true);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDuration, isoDurationNullable);

      input = '-PT0S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(seconds: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.isZero, true);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDuration, isoDurationNullable);

      input = '-P4M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: -4));
      expect(isoDuration.isNegative, true);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = '-P4M2W';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: -4, weeks: -2));
      expect(isoDuration.isNegative, true);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = '-P2W1DT5M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(weeks: -2, days: -1, minutes: -5));
      expect(isoDuration.toSeconds(), -1296300);

      input = '-P5Y';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: -5));
      expect(isoDuration.isNegative, true);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = '-P5Y2M10D';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: -5, months: -2, days: -10));
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, true);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = '-P3Y6M4DT12H30M5S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, true);
      expect(
        isoDuration,
        IsoDuration(
          years: -3,
          months: -6,
          weeks: 0,
          days: -4,
          hours: -12,
          minutes: -30,
          seconds: -5,
        ),
      );
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));
      expect(isoDuration, isoDurationNullable);

      input = '-P1DT12H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(days: -1, hours: -12));
      expect(isoDuration.isNegative, true);
      expect(isoDuration.toSeconds(), -129600);

      input = '-PT15H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -15));
      expect(isoDuration.isNegative, true);
      expect(isoDuration.toSeconds(), -54000);

      input = '-PT36H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -36));
      expect(isoDuration.isNegative, true);
      expect(isoDuration.toSeconds(), -129600);

      input = '-PT8H15M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -8, minutes: -15));
      expect(isoDuration.isNegative, true);
      expect(isoDuration.toSeconds(), -29700);

      input = '-PT2H25M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -2, minutes: -25));
      expect(isoDuration.isNegative, true);
      expect(isoDuration.toSeconds(), -8700);

      input = '-PT16H35M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -16, minutes: -35));
      expect(isoDuration.isNegative, true);
      expect(isoDuration.toSeconds(), -59700);

      input = '-P10D';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(days: -10));
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.toSeconds(), -864000);
      expect(isoDuration, isoDurationNullable);
    });

    test('decimal input', () {
      input = 'PT8M40.215S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, false);
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

      input = 'PT0.5S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(seconds: 0.5));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 0.5);

      input = 'PT0,5S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(seconds: 0.5));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 0.5);

      input = 'P0.5Y';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 0.5));
      expect(isoDuration.isNegative, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'PT2.75M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(minutes: 2.75));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 165);

      input = 'PT2,75M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(minutes: 2.75));
      expect(isoDuration.isNegative, false);
      expect(isoDuration.toSeconds(), 165);

      input = 'P1,5Y2.5M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 1.5, months: 2.5));
      expect(isoDuration.isNegative, false);

      input = 'P2Y3.5M1W';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 2, months: 3.5, weeks: 1));
      expect(isoDuration.isNegative, false);
    });
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
