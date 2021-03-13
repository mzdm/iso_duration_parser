import 'package:iso_duration_parser/iso_duration_parser.dart';

void main() {
  final dur = IsoDuration.parse('PT36H');
  dur.days; // 0
  dur.hours; // 36.0
  dur.minutes; // 0
  dur.seconds; // 0
  dur.toSeconds(); // 129600.0
  dur.toIso(); // 'PT36H'
  final dateTime = DateTime(2021, 1, 20, 8); // 2021-01-20 08:00:00.000
  dur.withDate(dateTime); // 2021-01-21 20:00:00.000

  final durFormat = IsoDuration.parse('PT4H5M');
  durFormat.format('Call me in {hh}h {m}m'); // Call me in 04h 5m

  final dur2 = IsoDuration.parse('PT12H30M50.4S');
  dur2.hours; // 12.0
  dur2.minutes; // 30
  dur2.seconds; // 50.4
  dur2.toSeconds(); // 45054.5
  dur2.toIso(); // 'PT12H30M50.4S'

  final dur3 = IsoDuration.parse('P5Y'); // IsoDuration{years: 5, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0};
  //dur3.toSeconds(); // assertion error, years and months must be equal to 0

  IsoDuration.parse('P3Y6M4DT12H30M5S'); // IsoDuration{years: 3, months: 6, weeks: 0, days: 4, hours: 12, minutes: 30, seconds: 5};

  // can parse decimal (accepts both comma and dots):
  IsoDuration.parse('PT8M40.215S'); // IsoDuration{years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: 8, seconds: 40.215};

  try {
    IsoDuration.parse('P 50M');
  } on FormatException {
    // invalid input in parse throws FormatException
  }
  IsoDuration.tryParse('P 50M'); // invalid input in tryParse returns null
}
