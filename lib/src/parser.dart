const _pattern =
    r'^(-)?P(?!$)(\d+(?:[.,]\d+)?Y)?(\d+(?:[.,]\d+)?M)?(\d+(?:[.,]\d+)?W)?(\d+(?:[.,]\d+)?D)?(T(?=\d)(\d+(?:[.,]\d+)?H)?(\d+(?:[.,]\d+)?M)?(\d+(?:[.,]\d+)?S)?)?$';

const _secsInDay = 86400;
const _secsInHour = 3600;
const _microsecsInSec = 1000000;

/// [IsoDuration] - ISO 8061 Duration Data Type
///
/// The duration data type is used to specify a time interval.
///
/// This format is often used as response value in
/// REST APIs (YouTube video duration or length of the flight).
///
/// The time interval is specified in the following form `PnYnMnDTnHnMnS` where:
///
/// - P indicates the period (required)
/// - nY indicates the number of years
/// - nM indicates the number of months
/// - nW indicates the number of weeks
/// - nD indicates the number of days
/// - T indicates the start of a time section
/// (required if you are going to specify hours, minutes, or seconds)
/// - nH indicates the number of hours
/// - nM indicates the number of minutes
/// - nS indicates the number of seconds
///
///
/// Example:
///
/// ```dart
/// IsoDuration.parse('P5Y'); // IsoDuration{years: 5, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0};
/// IsoDuration.parse('P3Y6M4DT12H30M5S'); // IsoDuration{years: 3, months: 6, weeks: 0, days: 4, hours: 12, minutes: 30, seconds: 5};
///
/// can parse also decimal:
/// IsoDuration.parse('PT8M40.215S'); // IsoDuration{years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: 8, seconds: 40.215};
/// ```
///
/// **Note**: This [IsoDuration] is not like Dart's implementation of [Duration].
///
/// Despite the similar name, a [Duration] object does not implement "Durations"
/// as specified by ISO 8601. In particular, a duration object does not keep track
/// of the individually provided members (such as "days" or "hours"),
/// but only uses these arguments to compute the length of
/// the corresponding time interval.
///
/// See also:
///
///  * [Wikipedia, ISO_8601 Durations](https://en.wikipedia.org/wiki/ISO_8601#Durations)
///  * [XSD Duration Data Type](https://www.w3schools.com/xml/schema_dtypes_date.asp)
class IsoDuration {
  /// The duration part in years, if was given, otherwise defaults to 0.
  final double years;

  /// The duration part in months, if was given, otherwise defaults to 0.
  final double months;

  /// The duration part in weeks, if was given, otherwise defaults to 0.
  final double weeks;

  /// The duration part in days, if was given, otherwise defaults to 0.
  final double days;

  /// The duration part in hours, if was given, otherwise defaults to 0.
  final double hours;

  /// The duration part in minutes, if was given, otherwise defaults to 0.
  final double minutes;

  /// The duration part in seconds, if was given, otherwise defaults to 0.
  final double seconds;

  /// Creates a new [IsoDuration] object where each value represents
  /// an individual duration part.
  ///
  /// This [IsoDuration] is not like Dart's implementation of [Duration]
  /// whose value is the sum of all individual parts.
  ///
  /// All arguments are 0 by default.
  ///
  /// See more:
  ///
  ///  * [IsoDuration] - ISO 8061 Duration Data Type
  IsoDuration({
    this.years = 0,
    this.months = 0,
    this.weeks = 0,
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  }) : assert(
          <double>[years, months, weeks, days, hours, minutes, seconds].every(
                (e) => e <= 0,
              ) ||
              <double>[years, months, weeks, days, hours, minutes, seconds]
                  .every((e) => e >= 0),
          'Can not mix positive and negative values!',
        );

  /// Returns `true` if all values of [IsoDuration] object are equal to 0.
  bool get isZero => _allProperties.every((element) => element == 0);

  /// Returns `true` if the [IsoDuration] is negative.
  ///
  /// An example format of the parsed negative [IsoDuration]:
  /// ```
  /// -PT15H
  /// ```
  ///
  /// `Minus` operator is allowed only before the literal `P`.
  bool get isNegative => _allProperties.any((element) => element < 0);

  /// Returns `true` if any property of the [IsoDuration] has decimals.
  bool get hasDecimals => _allProperties.any((element) => element.isDecimal());

  /// Returns `true` if both [years] and [months] are equal to 0, meaning that
  /// [toSeconds] method can be accurately calculated.
  bool get isPrecise => years == 0 && months == 0;

  List<double> get _allProperties => <double>[
        years,
        months,
        weeks,
        days,
        hours,
        minutes,
        seconds,
      ];

  /// Parses the ISO 8601 - Duration. If the operation was not successful then
  /// it throws [FormatException].
  ///
  /// Usage example:
  ///
  /// ```dart
  /// IsoDuration.parse('P5Y'); // IsoDuration{years: 5, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0};
  /// IsoDuration.parse('P3Y6M4DT12H30M5S'); // IsoDuration{years: 3, months: 6, weeks: 0, days: 4, hours: 12, minutes: 30, seconds: 5};
  ///
  /// can parse also decimal (accepts both comma and dots):
  /// IsoDuration.parse('PT8M40.215S'); // IsoDuration{years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: 8, seconds: 40.215};
  /// ```
  ///
  /// See also:
  ///
  ///  * [Wikipedia, ISO_8601 Durations](https://en.wikipedia.org/wiki/ISO_8601#Durations)
  ///  * [XSD Duration Data Type](https://www.w3schools.com/xml/schema_dtypes_date.asp)
  static IsoDuration parse(String input) {
    final parsed = tryParse(input);
    if (parsed != null) {
      return parsed;
    }
    throw FormatException('Could not parse the ISO Duration: $input');
  }

  /// Like [parse] but safely parses the ISO 8601 - Duration and
  /// returns `null` if the [input] is invalid.
  static IsoDuration? tryParse(String input) {
    final regExp = RegExp(_pattern);
    final matches = regExp.matchAsPrefix(input);

    if (matches != null) {
      final y = matches.group(2)?.replaceFirst('Y', '').replaceComma();
      final m = matches.group(3)?.replaceFirst('M', '').replaceComma();
      final w = matches.group(4)?.replaceFirst('W', '').replaceComma();

      final d = matches.group(5)?.replaceFirst('D', '').replaceComma();
      final hrs = matches.group(7)?.replaceFirst('H', '').replaceComma();
      final min = matches.group(8)?.replaceFirst('M', '').replaceComma();
      final sec = matches.group(9)?.replaceFirst('S', '').replaceComma();

      // additional check if some input was wrongly matched
      if (<String?>[y, m, w, d, hrs, min, sec].any(
        (element) {
          if (element == null) return false;
          if (double.tryParse(element) == null) return true;
          return false;
        },
      )) {
        return null;
      }

      final years = double.tryParse(y ?? '');
      final months = double.tryParse(m ?? '');
      final weeks = double.tryParse(w ?? '');
      final days = double.tryParse(d ?? '');
      final hours = double.tryParse(hrs ?? '');
      final minutes = double.tryParse(min ?? '');
      final seconds = double.tryParse(sec ?? '');

      final isNegative = matches.group(1) == '-';
      final multipl = isNegative ? -1 : 1;

      return IsoDuration(
        years: (years ?? 0) * multipl,
        months: (months ?? 0) * multipl,
        weeks: (weeks ?? 0) * multipl,
        days: (days ?? 0) * multipl,
        hours: (hours ?? 0) * multipl,
        minutes: (minutes ?? 0) * multipl,
        seconds: (seconds ?? 0) * multipl,
      );
    }
    return null;
  }

  /// Calculates total duration in seconds as a sum of all individual parts
  /// (except [years] and [months]) from the [IsoDuration] object.
  ///
  /// [years] and [months] of [IsoDuration] **must be** equal to 0.
  /// Otherwise, it is not possible to accurately count the total of seconds.
  ///
  /// For example:
  ///
  /// ```dart
  /// final dur = IsoDuration(hours: 1, minutes: 2, seconds: 5.5);
  /// dur.toSeconds(); // 3725.5
  /// ```
  double toSeconds() {
    assert(
      isPrecise,
      'years and months values of the IsoDuration object must be equal to 0!',
    );
    final weeksToSecs = weeks * _secsInDay * 7;
    final daysToSecs = days * _secsInDay;
    final hrsToSecs = hours * _secsInHour;
    final minsToSecs = minutes * 60;
    return weeksToSecs + daysToSecs + hrsToSecs + minsToSecs + seconds;
  }

  /// This method returns a [String] value from the [IsoDuration] object in
  /// ISO 8601 - Duration (`PnYnMnDTnHnMnS` format).
  ///
  /// If any part is zero then it is omitted. If all parts are zero then it
  /// returns `PT0S`.
  ///
  /// Decimal is separated with a dot.
  ///
  /// Example:
  /// ```dart
  /// final dur = IsoDuration(hours: 1, minutes: 2, seconds: 5.5);
  /// dur.toIso(); // 'PT1H2M5.5S'
  /// ```
  ///
  /// See also:
  ///
  ///  * [Wikipedia, ISO_8601 Durations](https://en.wikipedia.org/wiki/ISO_8601#Durations)
  ///  * [XSD Duration Data Type](https://www.w3schools.com/xml/schema_dtypes_date.asp)
  String toIso() {
    if (isZero) {
      return 'PT0S';
    }

    final strNegative = isNegative ? '-' : '';
    final strBuffer = StringBuffer('${strNegative}P');

    if (years != 0) strBuffer.write('${_delTrailingZero(years.inv())}Y');
    if (months != 0) strBuffer.write('${_delTrailingZero(months.inv())}M');
    if (weeks != 0) strBuffer.write('${_delTrailingZero(weeks.inv())}W');
    if (days != 0) strBuffer.write('${_delTrailingZero(days.inv())}D');

    if (<double>[hours, minutes, seconds].any((e) => e != 0)) {
      strBuffer.write('T');

      if (hours != 0) strBuffer.write('${_delTrailingZero(hours.inv())}H');
      if (minutes != 0) strBuffer.write('${_delTrailingZero(minutes.inv())}M');
      if (seconds != 0) strBuffer.write('${_delTrailingZero(seconds.inv())}S');
    }

    return strBuffer.toString();
  }

  /// Returns formatted String with a specified [format].
  ///
  /// Currently allowed format types:
  /// - h, hh
  /// - m, mm
  /// - s, ss
  ///
  /// To use it as a format type wrap it with curly braces.
  ///
  /// Two character length format type, e.g. 'ss', adds a trailing zero at
  /// the beginning if it is lesser than 10.
  ///
  /// Example:
  /// ```dart
  /// final dur = IsoDuration(hours: 2, minutes: 30);
  /// dur.format('See you in {h} hours and {mm} minutes'); // 'See you in 2 hours and 30 minutes'
  /// ```
  String format(String format) {
    final strBuffer = StringBuffer('');

    final list = format.split(RegExp('(?={)|(?<=})'));
    for (final item in list) {
      if (!RegExp('({)[A-Za-z]{1,2}(})').hasMatch(item)) {
        strBuffer.write(item);
        continue;
      }

      var tempItem = item.replaceAll(RegExp('[{}]'), '');
      if (_TimeFormat.values.any((e) => e.describe() == tempItem)) {
        strBuffer.write(_getFormat(tempItem));
      } else {
        strBuffer.write(item);
      }
    }
    return strBuffer.toString();
  }

  String _getFormat(String format) {
    final isShort = format.length == 1;
    final value = _formatValueMap[isShort ? '$format$format' : format]!.toInt();
    return isShort ? value.toString() : _addLeadingZeroIfNeeded(value);
  }

  Map<String, double> get _formatValueMap => {
    _TimeFormat.hh.describe(): hours,
    _TimeFormat.mm.describe(): minutes,
    _TimeFormat.ss.describe(): seconds,
  };

  String _addLeadingZeroIfNeeded(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  /// Adds current [IsoDuration] to a specified [dateTime] (or subtracts if
  /// [isNegative] is `true`).
  ///
  /// Both [years] and [months] must not be decimal, otherwise it is not
  /// possible to accurately calculate and return from it new [DateTime].
  ///
  /// Example:
  /// ```dart
  /// final dur = IsoDuration(hours: 2, minutes: 30);
  /// final dateTime = DateTime(2021, 1, 20, 8); // 2021-01-20 08:00:00.000
  /// dur.withDate(dateTime); // 2021-01-20 10:30:00.000
  /// ```
  DateTime withDate(DateTime dateTime) {
    assert(
      !years.isDecimal() && !months.isDecimal(),
      'Years and months must not be decimal!',
    );

    if (isZero) {
      return dateTime;
    }

    if (isPrecise) {
      final microseconds = (toSeconds().secsToMicrosecs()).truncate();
      if (isNegative) {
        final duration = Duration(microseconds: microseconds * -1);
        return dateTime.subtract(duration);
      }
      return dateTime.add(Duration(microseconds: microseconds));
    }

    final newDate = DateTime(
      dateTime.year + years.truncate(),
      dateTime.month + months.truncate(),
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.millisecond,
      dateTime.microsecond,
    );

    final precisePart = copyWith(years: 0, months: 0);
    final microseconds = precisePart.toSeconds().secsToMicrosecs().truncate();
    if (isNegative) {
      newDate.subtract(Duration(microseconds: microseconds * -1));
    } else {
      newDate.add(Duration(microseconds: microseconds));
    }

    return newDate;
  }

  /// Returns `true` if this [IsoDuration] this occurs after the `other`.
  ///
  /// Each [IsoDuration] is calculated as a sum of all properties and then
  /// the duration is compared.
  ///
  /// Example:
  /// ```dart
  /// final dur = IsoDuration(hours: 1, minutes: 30);
  /// final dur2 = IsoDuration(hours: 10, minutes: 0);
  /// dur.isAfter(dur2); // false
  /// ```
  bool isAfter(IsoDuration other) {
    if (this == other) return false;
    if (isNegative && !other.isNegative) return false;
    if (!isNegative && other.isNegative) return true;
    if (isPrecise && other.isPrecise) return toSeconds() > other.toSeconds();
    return _isAfter(other);
  }

  /// Returns `true` if this [IsoDuration] occurs before the `other`.
  ///
  /// Each [IsoDuration] is calculated as a sum of all properties and then
  /// the duration is compared.
  ///
  /// Example:
  /// ```dart
  /// final dur = IsoDuration(hours: 1, minutes: 30);
  /// final dur2 = IsoDuration(hours: 10, minutes: 0);
  /// dur.isAfter(dur2); // true
  /// ```
  bool isBefore(IsoDuration other) {
    if (this == other) return false;
    if (!isNegative && other.isNegative) return false;
    if (isNegative && !other.isNegative) return true;
    if (isPrecise && other.isPrecise) return toSeconds() < other.toSeconds();
    return !_isAfter(other);
  }

  /// Returns `true` if this [IsoDuration] occurs at the same time as `other`.
  ///
  /// This is different from == (equals), where all properties must be same,
  /// not only the total duration.
  ///
  /// Each [IsoDuration] is calculated as a sum of all properties and then
  /// the duration is compared.
  ///
  /// Example:
  /// ```dart
  /// final dur = IsoDuration(hours: 0, minutes: 60);
  /// final dur2 = IsoDuration(hours: 1, minutes: 0);
  /// final dur3 = IsoDuration(minutes: 60);
  /// dur.isAtSameMomentAs(dur2); // true
  /// dur == dur2; // false
  /// dur == dur3; // true
  /// ```
  bool isAtSameMomentAs(IsoDuration other) {
    if (this == other) return true;
    if (isPrecise && other.isPrecise) return toSeconds() == other.toSeconds();
    return _isAtSameMomentAs(other);
  }

  bool _isAfter(IsoDuration other) {
    final testDate = DateTime(2000);
    final date1 = withDate(testDate);
    final date2 = other.withDate(testDate);

    return date1.isAfter(date2);
  }

  bool _isAtSameMomentAs(IsoDuration other) {
    final testDate = DateTime(2000);
    final date1 = withDate(testDate);
    final date2 = other.withDate(testDate);

    return date1.isAtSameMomentAs(date2);
  }

  /// Creates a copy of this object with the given fields
  /// replaced with the new values.
  IsoDuration copyWith({
    double? years,
    double? months,
    double? weeks,
    double? days,
    double? hours,
    double? minutes,
    double? seconds,
  }) {
    return IsoDuration(
      years: years ?? this.years,
      months: months ?? this.months,
      weeks: weeks ?? this.weeks,
      days: days ?? this.days,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  @override
  String toString() =>
      'IsoDuration{years: $years, months: $months, weeks: $weeks, days: $days, hours: $hours, minutes: $minutes, seconds: $seconds}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsoDuration &&
          runtimeType == other.runtimeType &&
          years == other.years &&
          months == other.months &&
          weeks == other.weeks &&
          days == other.days &&
          hours == other.hours &&
          minutes == other.minutes &&
          seconds == other.seconds;

  @override
  int get hashCode =>
      years.hashCode ^
      months.hashCode ^
      weeks.hashCode ^
      days.hashCode ^
      hours.hashCode ^
      minutes.hashCode ^
      seconds.hashCode;
}

String _delTrailingZero(double n) {
  final hasTrailingZero = n.truncateToDouble() == n;
  if (hasTrailingZero) {
    return n.toStringAsFixed(0);
  }
  return n.toString();
}

extension _IsoDurationStringExt on String {
  String replaceComma() => replaceFirst(',', '.');
}

extension _IsoDurationDoubleExt on double {
  double inv() => this < 0 ? this * -1 : this;

  bool isDecimal() => this != truncateToDouble();

  double secsToMicrosecs() => this * _microsecsInSec;
}

enum _TimeFormat { h, hh, m, mm, s, ss }

extension _TimeFormatExt on _TimeFormat {
  String describe() => toString().split('.').last;
}