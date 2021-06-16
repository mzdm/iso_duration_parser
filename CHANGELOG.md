## 1.1.1
- Constructor is now const.
- Updated docs & README.
- Updated tests.
- Updated CI.

## 1.1.0
- `withDate` now handles and supports UTC `DateTime`.
- `format` now supports years, months, weeks and days as well.
- Added `inverse` method which makes `IsoDuration` positive if it is negative and vice versa.
- Updated README.

## 1.0.0
- Added `toIso` method which returns ISO 8601 Duration format from the IsoDuration object.
- Added `withDate` method which adds/subtracts `IsoDuration` from a `DateTime`
```dart
final isoDur = IsoDuration.parse('PT12H');
final dateTime = DateTime(2021, 1, 20, 8); // 2021-01-20 08:00:00.000
isoDur.withDate(dateTime); // 2021-01-20 20:00:00.000
```
- Added `format` method which formats `IsoDuration` to specified String format
```dart
final durFormat = IsoDuration.parse('PT4H5M');
durFormat.format('See you in {hh}h {m}m'); // See you in 04h 5m
```
- Other added methods: `isAfter`, `isBefore`, `isAtSameMomentAs`, `isPrecise`, `hasDecimals`, `copyWith`
- Added a possibility to parse negative durations. `Minus` operator is allowed only before the literal `P`. An example:

```dart
-P1DT15H
```
- Bug fixes.
- Updated dependencies.

## 0.2.0
- Added `toSeconds` method for calculating total sum of all individual parts.
- Improved pub.dev score.
- Renamed properties of `IsoDuration` to differentiate from the Dart's `Duration`.

## 0.1.0
- Initial release.
