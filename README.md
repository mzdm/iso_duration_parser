# iso_duration_parser

[![pub package](https://img.shields.io/pub/v/iso_duration_parser.svg)](https://pub.dev/packages/iso_duration_parser) ![tests](https://github.com/mzdm/iso_duration_parser/actions/workflows/main.yml/badge.svg)

A package which parses [ISO 8061 Duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) PnYnMnDTnHnMnS format.

## Usage

A simple usage example:

```dart
import 'package:iso_duration_parser/iso_duration_parser.dart';

void main() {
  final dur = IsoDuration.parse('PT12H30M50.4S');
  dur.hours; // 12.0
  dur.minutes; // 30
  dur.seconds; // 50.4
  dur.toSeconds(); // 45054.5
  dur.toIso(); // 'PT12H30M50.4S'

  final dur2 = IsoDuration.parse('PT36H');
  dur2.days; // 0
  dur2.hours; // 36.0
  dur2.minutes; // 0
  dur2.seconds; // 0
  dur2.toSeconds(); // 129600.0
  dur2.toIso(); // 'PT36H'

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

... [read more](https://www.w3schools.com/xml/schema_dtypes_date.asp)

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/mzdm/iso_duration_parser/issues) or feel free to raise a PR to the linked issue.
