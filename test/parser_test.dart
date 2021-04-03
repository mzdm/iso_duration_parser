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
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 600);
      expect(isoDuration, isoDurationNullable);

      input = 'P0M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.toIso(), 'PT0S');
      expect(isoDuration.isZero, true);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDuration, isoDurationNullable);

      input = 'PT0S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(seconds: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isZero, true);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDuration, isoDurationNullable);

      input = 'P4M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: 4));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P4M2W';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: 4, weeks: 2));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P2W1DT5M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(weeks: 2, days: 1, minutes: 5));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 1296300);

      input = 'P5Y';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 5));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P5Y2M10D';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 5, months: 2, days: 10));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P3Y6M4DT12H30M5S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
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
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 129600);

      input = 'PT15H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 15));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 54000);

      input = 'PT36H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 36));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 129600);

      input = 'PT8H15M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 8, minutes: 15));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 29700);

      input = 'PT2H25M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 2, minutes: 25));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 8700);

      input = 'PT16H35M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: 16, minutes: 35));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 59700);

      input = 'P10D';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(days: 10));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
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
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), -600);
      expect(isoDuration, isoDurationNullable);

      input = '-P0M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.toIso(), 'PT0S');
      expect(isoDuration.isZero, true);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDuration, isoDurationNullable);

      input = '-PT0S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(seconds: 0));
      expect(isoDuration, IsoDuration());
      expect(isoDuration.toIso(), 'PT0S');
      expect(isoDuration.isZero, true);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), 0);
      expect(isoDuration, isoDurationNullable);

      input = '-P4M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: -4));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = '-P4M2W';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(months: -4, weeks: -2));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = '-P2W1DT5M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(weeks: -2, days: -1, minutes: -5));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), -1296300);

      input = '-P5Y';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: -5));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = '-P5Y2M10D';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: -5, months: -2, days: -10));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = '-P3Y6M4DT12H30M5S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, false);
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
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), -129600);

      input = '-PT15H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -15));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), -54000);

      input = '-PT36H';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -36));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), -129600);

      input = '-PT8H15M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -8, minutes: -15));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), -29700);

      input = '-PT2H25M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -2, minutes: -25));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), -8700);

      input = '-PT16H35M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(hours: -16, minutes: -35));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), -59700);

      input = '-P10D';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(days: -10));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isZero, false);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, false);
      expect(isoDuration.toSeconds(), -864000);
      expect(isoDuration, isoDurationNullable);
    });

    test('decimal input', () {
      input = 'PT8M40.215S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, true);
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
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, true);
      expect(isoDuration.toSeconds(), 0.5);

      input = 'PT0,5S';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(seconds: 0.5));
      expect(isoDuration.toIso(), 'PT0.5S');
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, true);
      expect(isoDuration.toSeconds(), 0.5);

      input = 'P0.5Y';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 0.5));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, true);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'PT2.75M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(minutes: 2.75));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, true);
      expect(isoDuration.toSeconds(), 165);

      input = 'PT2,75M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(minutes: 2.75));
      expect(isoDuration.toIso(), 'PT2.75M');
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, true);
      expect(isoDuration.hasDecimals, true);
      expect(isoDuration.toSeconds(), 165);

      input = 'P1,5Y2.5M';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 1.5, months: 2.5));
      expect(isoDuration.toIso(), 'P1.5Y2.5M');
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, true);

      input = 'P2Y3.5M1W';
      isoDurationNullable = IsoDuration.tryParse(input);
      expect(isoDurationNullable, isNotNull);
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration, IsoDuration(years: 2, months: 3.5, weeks: 1));
      expect(isoDuration.toIso(), input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.isPrecise, false);
      expect(isoDuration.hasDecimals, true);
    });

    test('copyWith method', () {
      late IsoDuration isoDurationCopy;

      isoDuration = IsoDuration(hours: 5, minutes: 50);
      isoDurationCopy = isoDuration.copyWith(minutes: 0);
      expect(isoDuration, isoDuration.copyWith());
      expect(isoDuration, isNot(isoDurationCopy));
      expect(isoDurationCopy.toIso(), 'PT5H');

      isoDuration = IsoDuration(hours: 0, minutes: 0);
      isoDurationCopy = isoDuration.copyWith(minutes: 0);
      expect(isoDuration, isoDurationCopy);
      expect(isoDurationCopy.toIso(), 'PT0S');

      isoDuration = IsoDuration();
      isoDurationCopy = isoDuration.copyWith();
      expect(isoDuration, isoDurationCopy);
      expect(isoDurationCopy.toIso(), 'PT0S');

      isoDuration = IsoDuration(days: -5, hours: -5, minutes: -50, seconds: -5);
      isoDurationCopy = isoDuration.copyWith(minutes: 0);
      expect(isoDuration, isoDuration.copyWith());
      expect(isoDuration, isNot(isoDurationCopy));
      expect(isoDurationCopy.toIso(), '-P5DT5H5S');
    });

    test('inverse', () {
      input = 'PT0S';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.inverse().isNegative, false);

      input = 'PT10M';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, false);
      print(isoDuration.inverse());
      expect(isoDuration.inverse().isNegative, true);

      input = 'P4M2WT1S';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.inverse().isNegative, true);
      expect(
        isoDuration.inverse(),
        IsoDuration(months: -4, weeks: -2, seconds: -1),
      );

      input = '-P4M2WT1S';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.inverse().isNegative, false);
      expect(
        isoDuration.inverse(),
        IsoDuration(months: 4, weeks: 2, seconds: 1),
      );

      input = 'P2W1DT5M';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.inverse().isNegative, true);

      input = 'P0.5Y';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.inverse().isNegative, true);

      input = 'P1DT2H45M';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.inverse().isNegative, true);

      input = '-P1DT2H45M';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.inverse().isNegative, false);

      input = 'P1DT12H';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, false);
      expect(isoDuration.inverse().isNegative, true);

      input = '-P1DT12H';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isNegative, true);
      expect(isoDuration.inverse().isNegative, false);
    });

    test('format', () {
      late String format;

      input = 'PT4H5M';
      format = 'Call me in {hh}h {m}m';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), 'Call me in 04h 5m');

      input = 'PT10M';
      format = '{mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '10');

      input = 'PT10M';
      format = '{m}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '10');

      input = 'PT0S';
      format = '{mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '00');

      input = 'PT0S';
      format = '{ss}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '00');

      input = 'PT0S';
      format = '{s}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '0');

      input = 'P4M2WT1S';
      format = '{ww} {mm}:{s}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{ww} 00:1');

      input = '-P4M2WT1S';
      format = '{ww} {mm}:{s}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{ww} 00:-1');

      input = 'P0.5Y';
      format = 'm{mm}m';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), 'm00m');

      input = 'P2W1DT5M';
      format = 'length: {m} minutes ...';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), 'length: 5 minutes ...');

      input = 'P1DT12H';
      format = '{hh}:{mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '12:00');

      input = 'P1DT2H45M';
      format = '{hh}:{mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '02:45');

      input = 'P1DT2H45M';
      format = '{h}:{mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '2:45');

      input = '-P1DT12H';
      format = '{hh}:{mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '-12:00');

      input = '-P1DT2H45M';
      format = '{hh}:{mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '-02:-45');

      input = '-P1DT2H45M';
      format = '{h}:{mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '-2:-45');

      input = '-P1DT12H';
      format = '{hh}:{mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '-12:00');

      input = 'P10D';
      format = '{h}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '0');

      input = 'P4M2WT1S';
      format = '{ww} {MM}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{ww} 04');

      input = 'P4M2WT1S';
      format = '{WW} {MM}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '02 04');

      input = '-P4M2WT1S';
      format = '{WW} {MM}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '-02 -04');

      input = 'P0.5Y3MT1M';
      format = 'yyyy-MM-dd';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), 'yyyy-MM-dd');

      input = 'P5Y3M1DT1M';
      format = '{YY}-{MM}-{DD}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '05-03-01');

      input = 'P5Y';
      format = 'm{MM}m..{Y}y';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), 'm00m..5y');

      input = '-P5Y';
      format = 'm{MM}m..{Y}y';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), 'm00m..-5y');

      input = 'PT1M';
      format = '{{mm}min';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{01min');

      input = 'PT1M';
      format = '.{m}min';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '.1min');

      input = 'PT1M';
      format = '.{m}.min';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '.1.min');

      input = 'PT1M';
      format = '.{{m}}.min';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '.{1}.min');

      input = '-PT1M';
      format = '.{{m}}.min';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '.{-1}.min');

      // incorrect format
      input = 'PT1M';
      format = '{}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{}');

      input = 'PT1M';
      format = '{m';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{m');

      input = 'PT1M';
      format = '{mm';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{mm');

      input = 'PT1M';
      format = '{Mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{Mm}');

      input = 'P1MT1M';
      format = '{Mm}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{Mm}');

      input = 'PT1M';
      format = '{Mm';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{Mm');

      input = 'PT1M';
      format = '{{}}';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.format(format), '{{}}');
    });

    test('comparing durations', () {
      late String input2;
      late IsoDuration isoDuration2;

      input = 'PT24H';
      input2 = 'P1D';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), true);
      expect(isoDuration.isBefore(isoDuration2), false);
      expect(isoDuration.isAfter(isoDuration2), false);

      input = 'PT24H';
      input2 = 'PT24H';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, true);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), true);
      expect(isoDuration.isBefore(isoDuration2), false);
      expect(isoDuration.isAfter(isoDuration2), false);

      input = 'P0M';
      input2 = 'P4M';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), true);
      expect(isoDuration.isAfter(isoDuration2), false);

      input = 'P0M';
      input2 = 'PT10M';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), true);
      expect(isoDuration.isAfter(isoDuration2), false);

      input = 'P0M';
      input2 = 'P4M';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), true);
      expect(isoDuration.isAfter(isoDuration2), false);

      input = 'PT0,5S';
      input2 = 'P2W1DT5M';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), true);
      expect(isoDuration.isAfter(isoDuration2), false);

      input = 'P6M';
      input2 = 'P2W1DT5M';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), false);
      expect(isoDuration.isAfter(isoDuration2), true);

      input = 'P3Y6M4DT12H30M5S';
      input2 = 'P1DT12H';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), false);
      expect(isoDuration.isAfter(isoDuration2), true);

      input = 'PT8H15M';
      input2 = 'PT2H25M';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), false);
      expect(isoDuration.isAfter(isoDuration2), true);

      input = 'P2W1DT5M';
      input2 = '-P2W1DT5M';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), false);
      expect(isoDuration.isAfter(isoDuration2), true);

      input = 'P6M30.5D';
      input2 = 'P1Y';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), true);
      expect(isoDuration.isAfter(isoDuration2), false);

      input = 'P12MT1H';
      input2 = 'P1Y';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      print(isoDuration.withDate(DateTime(2000)));
      print(isoDuration2.withDate(DateTime(2000)));
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), false);
      expect(isoDuration.isAfter(isoDuration2), true);

      input = 'P1DT12H';
      input2 = 'P1D';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, false);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), false);
      expect(isoDuration.isBefore(isoDuration2), false);
      expect(isoDuration.isAfter(isoDuration2), true);

      input = '-PT0S';
      input2 = 'PT0H';
      isoDuration = IsoDuration.parse(input);
      isoDuration2 = IsoDuration.parse(input2);
      expect(isoDuration == isoDuration2, true);
      expect(isoDuration.isAtSameMomentAs(isoDuration2), true);
      expect(isoDuration.isBefore(isoDuration2), false);
      expect(isoDuration.isAfter(isoDuration2), false);
    });

    test('withDate', () {
      final testDateTime = DateTime(2000);
      final testDateTimeMid = DateTime(2000, 6, 15, 12);
      final testDateTime2 = DateTime(2021, 5, 20);
      final testDateTime3 = DateTime(2021, 5, 20, 10, 30);

      input = 'PT24H';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 2),
      );
      expect(
        isoDuration.withDate(testDateTime2),
        DateTime(2021, 5, 21),
      );

      input = 'PT10M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 1, 0, 10),
      );

      input = 'P0M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000),
      );

      input = 'PT0S';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000),
      );

      input = 'P4M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 5),
      );
      expect(
        isoDuration.withDate(testDateTime2),
        DateTime(2021, 9, 20),
      );

      input = 'P4M2W';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 5, 15),
      );

      input = 'P2W1DT5M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 16, 0, 5),
      );

      input = 'P5Y';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2005),
      );

      input = 'P5Y2M10D';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2005, 3, 11),
      );

      input = 'P3Y6M4DT12H30M5S';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2003, 7, 5, 12, 30, 5),
      );

      input = 'P1DT12H';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 2, 12),
      );

      input = 'PT15H';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 1, 15),
      );
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 25, 30),
      );

      input = 'PT36H';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 1, 36),
      );

      input = 'PT8H15M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 1, 8, 15),
      );
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 18, 45),
      );

      input = 'PT2H25M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 1, 2, 25),
      );
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 12, 55),
      );

      input = 'PT16H35M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 1, 16, 35),
      );

      input = 'P10D';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 11),
      );
      expect(
        isoDuration.withDate(testDateTime2),
        DateTime(2021, 5, 30),
      );

      input = 'P14D';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000, 1, 15),
      );
      expect(
        isoDuration.withDate(testDateTime2),
        DateTime(2021, 5, 34),
      );
      expect(
        isoDuration.withDate(testDateTime2),
        DateTime(2021, 6, 3),
      );

      input = '-PT10M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 10, 20),
      );

      input = '-P0M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000),
      );
      expect(
        isoDuration.withDate(testDateTime2),
        testDateTime2,
      );
      expect(
        isoDuration.withDate(testDateTime3),
        testDateTime3,
      );

      input = '-PT0S';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(2000),
      );
      expect(
        isoDuration.withDate(testDateTime2),
        testDateTime2,
      );
      expect(
        isoDuration.withDate(testDateTime3),
        testDateTime3,
      );

      input = '-P4M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(1999, 9),
      );
      expect(
        isoDuration.withDate(testDateTime2),
        DateTime(2021, 1, 20),
      );

      input = '-P4M2W';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(2000, 2, 1, 12),
      );

      input = '-P2W1DT5M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(2000, 6, 0, 11, 55),
      );

      input = '-P5Y';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime),
        DateTime(1995),
      );

      input = '-P5Y2M10D';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(1995, 4, 5, 12),
      );

      input = '-P3Y5M4DT12H30M5S';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(1997, 1, 10, 23, 29, 55),
      );

      input = '-P1DT12H';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(2000, 6, 14, 0),
      );

      input = '-PT15H';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(2000, 6, 15, -3),
      );

      input = '-PT36H';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(2000, 6, 15, -24),
      );
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(2000, 6, 14, 0),
      );

      input = '-PT8H15M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime2),
        DateTime(2021, 5, 20, -8, -15),
      );

      input = '-PT2H25M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(2000, 6, 15, 9, 35),
      );

      input = '-PT16H35M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime2),
        DateTime(2021, 5, 20, -16, -35),
      );

      input = '-P10D';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTimeMid),
        DateTime(2000, 6, 5, 12),
      );
      expect(
        isoDuration.withDate(testDateTime2),
        DateTime(2021, 5, 10),
      );

      input = 'PT8M40.215S';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 10, 38, 40, 215),
      );

      input = '-PT8M40.215S';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 10, 22, -40, -215),
      );

      input = 'PT0.5S';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 10, 30, 0, 500),
      );

      input = '-PT0.5S';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 10, 30, 0, -500),
      );

      input = 'PT2.75M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 10, 32, 45),
      );

      input = '-PT2.75M';
      isoDuration = IsoDuration.parse(input);
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 10, 27, 15),
      );
      expect(
        isoDuration.withDate(testDateTime3),
        DateTime(2021, 5, 20, 10, 28, -45),
      );

      input = 'P0.5Y';
      isoDuration = IsoDuration.parse(input);
      expect(
        () => isoDuration.withDate(testDateTime),
        throwsA(isA<AssertionError>()),
      );

      input = '-P0.5Y';
      isoDuration = IsoDuration.parse(input);
      expect(
        () => isoDuration.withDate(testDateTime),
        throwsA(isA<AssertionError>()),
      );

      input = '-P1,5Y2.5M';
      isoDuration = IsoDuration.parse(input);
      expect(
        () => isoDuration.withDate(testDateTime),
        throwsA(isA<AssertionError>()),
      );

      input = '-P1,5Y2.5M';
      isoDuration = IsoDuration.parse(input);
      expect(
        () => isoDuration.withDate(testDateTime),
        throwsA(isA<AssertionError>()),
      );

      input = 'P2Y3.5M1W';
      isoDuration = IsoDuration.parse(input);
      expect(
        () => isoDuration.withDate(testDateTime),
        throwsA(isA<AssertionError>()),
      );

      input = '-P2Y3.5M1W';
      isoDuration = IsoDuration.parse(input);
      expect(
        () => isoDuration.withDate(testDateTime),
        throwsA(isA<AssertionError>()),
      );
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

    test('decimal years or months are not precise', () {
      late IsoDuration isoDuration;

      input = 'P5.5Y';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isPrecise, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P5,5Y';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isPrecise, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P5.5Y4M';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isPrecise, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P5.5Y4.25M';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isPrecise, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));

      input = 'P4.1M';
      isoDuration = IsoDuration.parse(input);
      expect(isoDuration.isPrecise, false);
      expect(() => isoDuration.toSeconds(), throwsA(isA<AssertionError>()));
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

    test('invalid initialization', () {
      expect(() => IsoDuration(minutes: 0, seconds: -0),
          isNot(throwsA(isA<AssertionError>())));
      expect(() => IsoDuration(minutes: 0, seconds: -5),
          isNot(throwsA(isA<AssertionError>())));
      expect(() => IsoDuration(hours: 0, minutes: 0.01, seconds: -5),
          throwsA(isA<AssertionError>()));
      expect(() => IsoDuration(years: -5, minutes: 1, seconds: -5),
          throwsA(isA<AssertionError>()));
      expect(() => IsoDuration(minutes: 0.00000001, seconds: -1),
          throwsA(isA<AssertionError>()));
      expect(
          () => IsoDuration(
              years: -5,
              months: -5,
              weeks: 0,
              days: -1,
              hours: -2,
              minutes: -5,
              seconds: 2),
          throwsA(isA<AssertionError>()));
      expect(
          () => IsoDuration(
              years: -5,
              months: -5,
              weeks: 0,
              days: -1,
              hours: -2,
              minutes: -5,
              seconds: -2),
          isNot(throwsA(isA<AssertionError>())));
    });
  });
}
