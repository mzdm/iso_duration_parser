# iso_duration_parser

[![pub package](https://img.shields.io/pub/v/iso_duration_parser.svg)](https://pub.dev/packages/iso_duration_parser)

A package which parses [ISO 8061 Duration](https://en.wikipedia.org/wiki/ISO_8601#Durations).

## Usage

A simple usage example:

```dart
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
```

## Duration ISO 8061

**Duration Data Type**

The duration data type is used to specify a time interval.

This format is often used as response value in REST APIs (YouTube video duration or [length of the flight](https://developers.amadeus.com/self-service/category/air/api-doc/flight-offers-search/api-reference)).

The time interval is specified in the following form `PnYnMnDTnHnMnS` where:</br>
- P indicates the period (**required**)</br>
- nY indicates the number of years</br>
- nM indicates the number of months</br>
- nD indicates the number of days</br>
- T indicates the start of a time section (**required** if you are going to specify hours, minutes, or seconds)</br>
- nH indicates the number of hours</br>
- nM indicates the number of minutes</br>
- nS indicates the number of seconds</br>

... [read more](http://www.datypic.com/sc/xsd/t-xsd_duration.html)

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/mzdm/iso_duration_parser/issues) or feel free to raise a PR to the linked issue.
