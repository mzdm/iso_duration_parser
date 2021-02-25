import 'package:iso_duration_parser/iso_duration_parser.dart';

void main() {
  final dur = IsoDuration.tryParse('PT12H30M50.4S')!;
  dur.inHours; // 12.0
  dur.inMinutes; // 30
  dur.inSeconds; // 50.4

  final dur2 = IsoDuration.tryParse('PT36H')!;
  dur2.inDays; // 0
  dur2.inHours; // 36.0
  dur2.inMinutes; // 0
  dur2.inSeconds; // 0

  IsoDuration.tryParse('P5Y'); // IsoDuration{inYears: 5, inMonths: 0, inWeeks: 0, inDays: 0, inHours: 0, inMinutes: 0, inSeconds: 0};
  IsoDuration.tryParse('P3Y6M4DT12H30M5S'); // IsoDuration{inYears: 3, inMonths: 6, inWeeks: 0, inDays: 4, inHours: 12, inMinutes: 30, inSeconds: 5};

  // can parse decimal:
  IsoDuration.tryParse('PT8M40.215S'); // IsoDuration{inYears: 0, inMonths: 0, inWeeks: 0, inDays: 0, inHours: 0, inMinutes: 8, inSeconds: 40.215};

  try {
    IsoDuration.parse('P50.M'); // invalid input in parse throws FormatException
  } catch (e) {
    print(e);
  }
  IsoDuration.tryParse('P50.M'); // invalid input in tryParse returns null
}
