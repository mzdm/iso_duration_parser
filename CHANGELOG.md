## 1.0.0

- Added `toIso` method which returns ISO 8601 Duration format from the IsoDuration object.
- Added a possibility to parse negative durations. `Minus` operator is allowed only before the literal `P`. An example:

```dart
-PT15H
```
- Bug fixes.
- Updated dependencies.

## 0.2.0

- Added `toSeconds` method for calculating total sum of all individual parts.
- Improved pub.dev score.
- Renamed properties of `IsoDuration` to differentiate from the Dart's `Duration`.

## 0.1.0

- Initial release.
