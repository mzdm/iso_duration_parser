const _pattern =
    r'^P(?!$)(\d+(?:\.\d+)?Y)?(\d+(?:\.\d+)?M)?(\d+(?:\.\d+)?W)?(\d+(?:\.\d+)?D)?(T(?=\d)(\d+(?:\.\d+)?H)?(\d+(?:\.\d+)?M)?(\d+(?:[\.,\,]\d+)?S)?)?$';

class IsoDuration {
  /// The duration part in years, if was given, otherwise defaults to 0.
  final double inYears;

  /// The duration part in months, if was given, otherwise defaults to 0.
  final double inMonths;

  /// The duration part in weeks, if was given, otherwise defaults to 0.
  final double inWeeks;

  /// The duration part in days, if was given, otherwise defaults to 0.
  final double inDays;

  /// The duration part in hours, if was given, otherwise defaults to 0.
  final double inHours;

  /// The duration part in minutes, if was given, otherwise defaults to 0.
  final double inMinutes;

  /// The duration part in seconds, if was given, otherwise defaults to 0.
  final double inSeconds;

  const IsoDuration({
    this.inYears = 0,
    this.inMonths = 0,
    this.inWeeks = 0,
    this.inDays = 0,
    this.inHours = 0,
    this.inMinutes = 0,
    this.inSeconds = 0,
  });

  /// Returns `true` if all values of [IsoDuration] object are 0.
  bool get isZero => <double>[
        inYears,
        inMonths,
        inWeeks,
        inDays,
        inHours,
        inMinutes,
        inSeconds
      ].every((element) => element == 0);

  /// Parses the ISO 8601 - Duration. If the operation was not successful then
  /// it throws [FormatException].
  ///
  /// Usage example:
  ///
  /// ```dart
  /// IsoDuration.parse('P5Y'); // IsoDuration{inYears: 5, inMonths: 0, inWeeks: 0, inDays: 0, inHours: 0, inMinutes: 0, inSeconds: 0};
  /// IsoDuration.parse('P3Y6M4DT12H30M5S'); // IsoDuration{inYears: 3, inMonths: 6, inWeeks: 0, inDays: 4, inHours: 12, inMinutes: 30, inSeconds: 5};
  ///
  /// can parse also decimal:
  /// IsoDuration.parse('PT8M40.215S'); // IsoDuration{inYears: 0, inMonths: 0, inWeeks: 0, inDays: 0, inHours: 0, inMinutes: 8, inSeconds: 40.215};
  /// ```
  ///
  /// See also:
  ///
  ///  * [Wikipedia, ISO_8601 Durations](https://en.wikipedia.org/wiki/ISO_8601#Durations)
  ///  * [XML Schema 1.0 xsd:duration](http://www.datypic.com/sc/xsd/t-xsd_duration.html)
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
    Match? matches;
    try {
      matches = regExp.matchAsPrefix(input);
    } catch (e) {
      print(e);
    }
    if (matches != null) {
      return IsoDuration(
          inYears: double.tryParse(matches
                      .group(1)
                      ?.replaceFirst('Y', '')
                      .replaceFirst(',', '.') ??
                  '') ??
              0,
          inMonths: double.tryParse(matches
                      .group(2)
                      ?.replaceFirst('M', '')
                      .replaceFirst(',', '.') ??
                  '') ??
              0,
          inWeeks: double.tryParse(
                  matches.group(3)?.replaceFirst('W', '').replaceFirst(',', '.') ??
                      '') ??
              0,
          inDays:
              double.tryParse(matches.group(4)?.replaceFirst('D', '').replaceFirst(',', '.') ?? '') ?? 0,
          inHours: double.tryParse(matches.group(6)?.replaceFirst('H', '').replaceFirst(',', '.') ?? '') ?? 0,
          inMinutes: double.tryParse(matches.group(7)?.replaceFirst('M', '').replaceFirst(',', '.') ?? '') ?? 0,
          inSeconds: double.tryParse(matches.group(8)?.replaceFirst('S', '').replaceFirst(',', '.') ?? '') ?? 0);
    }
    return null;
  }

  @override
  String toString() =>
      'IsoDuration{inYears: $inYears, inMonths: $inMonths, inWeeks: $inWeeks, inDays: $inDays, inHours: $inHours, inMinutes: $inMinutes, inSeconds: $inSeconds}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsoDuration &&
          runtimeType == other.runtimeType &&
          inYears == other.inYears &&
          inMonths == other.inMonths &&
          inWeeks == other.inWeeks &&
          inDays == other.inDays &&
          inHours == other.inHours &&
          inMinutes == other.inMinutes &&
          inSeconds == other.inSeconds;

  @override
  int get hashCode =>
      inYears.hashCode ^
      inMonths.hashCode ^
      inWeeks.hashCode ^
      inDays.hashCode ^
      inHours.hashCode ^
      inMinutes.hashCode ^
      inSeconds.hashCode;
}

extension IsoDurationExt on IsoDuration {
  /// TODO: Unimplemented: Possibility to convert back to ISO
  ///
  /// This method returns a [String] value from the [IsoDuration] object in
  /// ISO 8601 - Duration format (`PnYnMnDTnHnMnS`).
  ///
  /// If any part is zero then it is omitted. If all parts are zero then it
  /// returns `PT0S`.
  ///
  /// See also:
  ///
  ///  * [Wikipedia, ISO_8601 Durations](https://en.wikipedia.org/wiki/ISO_8601#Durations)
  ///  * [XML Schema 1.0 xsd:duration](http://www.datypic.com/sc/xsd/t-xsd_duration.html)
  String _toIso() {
    throw 'Unimplemented method call';
  }

  /// TODO: Unimplemented: Convert total to seconds
  /// Calculates total duration only in seconds from the [IsoDuration] object.
  ///
  /// **Note:** values `inYears` and `inMonths` of [IsoDuration] must be 0.
  /// Otherwise, it is not possible to accurately count the total of seconds.
  ///
  /// For example:
  ///
  /// ```dart
  /// final dur = IsoDuration(inHours: 1, inMinutes: 2, inSeconds: 5.5)
  /// dur.toSeconds(); // 3725.5
  /// ```
  double _toSeconds(IsoDuration isoDuration) {
    assert(isoDuration.inYears == 0 && isoDuration.inMonths == 0,
        'inYears and inMonths values of the IsoDuration object must be 0!');
    throw 'Unimplemented method call';
  }
}
