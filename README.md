# Validated Numbers

Use a numeric type that encodes the range your API accepts.

| Range | Integer | Finite double |
| --- | --- | --- |
| Greater than zero | `PositiveInt` | `PositiveDouble` |
| Greater than or equal to zero | `ZeroOrPositiveInt` | `ZeroOrPositiveDouble` |
| Less than zero | `NegativeInt` | `NegativeDouble` |

```dart
import 'package:validated_numbers/validated_numbers.dart';

final remaining = 2.toZeroOrPositiveInt().decrement(); // 1
final charge = 1.5.toPositiveDouble() + 0.5; // 2.0
final adjustment = NegativeInt(-2) + 1; // -1
final offset = (-1.5).toNegativeDouble() - 0.5; // -2.0
```

Constructors and conversion extensions throw an `InvalidValueException`
subtype when given an out-of-range value. All double types reject NaN and both
infinities. `ZeroOrPositiveDouble` accepts either signed zero. The package's
addition and subtraction operators validate their results. Other inherited
arithmetic can return a plain `int` or `double`, which can be validated again
with a constructor or conversion.

Run `dart pub get`, `dart analyze`, and `dart test` from this package directory.
