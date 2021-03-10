const _pattern =
    r'^(-)?P(?!$)(\d+(?:[.,]\d+)?Y)?(\d+(?:[.,]\d+)?M)?(\d+(?:[.,]\d+)?W)?(\d+(?:[.,]\d+)?D)?(T(?=\d)(\d+(?:[.,]\d+)?H)?(\d+(?:[.,]\d+)?M)?(\d+(?:[.,]\d+)?S)?)?$';

const _secsInDay = 86400;
const _secsInHour = 3600;

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
  const IsoDuration({
    this.years = 0,
    this.months = 0,
    this.weeks = 0,
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  });

  /// Returns `true` if all values of [IsoDuration] object are equal to 0.
  bool get isZero => <double>[
        years,
        months,
        weeks,
        days,
        hours,
        minutes,
        seconds
      ].every((element) => element == 0);

  /// Returns `true` if the [IsoDuration] is negative.
  ///
  /// An example format of the parsed negative [IsoDuration]:
  /// ```
  /// -PT15H
  /// ```
  ///
  /// `Minus` operator is allowed only before the literal `P`.
  bool get isNegative => <double>[
        years,
        months,
        weeks,
        days,
        hours,
        minutes,
        seconds
      ].any((element) => element < 0);

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
  /// Values `years` and `months` of [IsoDuration] **must be** equal to 0.
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
      years == 0 && months == 0,
      'years and months values of the IsoDuration object must be 0!',
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
}
