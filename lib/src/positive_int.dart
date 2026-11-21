import "dart:math";

import "package:meta/meta.dart";

import "invalid_value_exception.dart";
import "zero_or_positive_int.dart";

/// A Dart integer that must be greater than zero.
///
/// Use this type for values such as counts that must contain at least one
/// item. A [PositiveInt] can be passed to an API expecting a
/// [ZeroOrPositiveInt]. Use [ZeroOrPositiveInt] directly when zero is allowed.
///
/// The constructor and the arithmetic methods declared here check the
/// result and throw [InvalidPositiveIntException] if it is less than one.
/// This type uses Dart's `int` range and arithmetic.
@immutable
extension type const PositiveInt._(int _value) implements ZeroOrPositiveInt {
  /// The smallest valid positive integer.
  static PositiveInt get one => const PositiveInt._(1);

  /// Validates an integer, throwing [InvalidPositiveIntException] for zero or
  /// a negative value.
  PositiveInt(this._value) {
    if (!validate(_value)) throw InvalidPositiveIntException(_value);
  }

  /// Adds [other] and validates that the result remains positive.
  PositiveInt operator +(int other) {
    final result = _value + other;
    if (!validate(result)) throw InvalidPositiveIntException(result);
    return PositiveInt(result);
  }

  /// Subtracts [other] and validates that the result remains positive.
  PositiveInt operator -(PositiveInt other) {
    final result = _value - other._value;
    if (!validate(result)) throw InvalidPositiveIntException(result);
    return PositiveInt(result);
  }

  /// Adds one, clamping the result to [maximum] when supplied.
  ///
  /// If this value is already at or above [maximum], returns [maximum].
  PositiveInt increment([PositiveInt? maximum]) {
    if (maximum != null && _value >= maximum) return maximum;
    return PositiveInt(_value + 1);
  }

  /// Subtracts one, clamping the result to [minimum] when supplied.
  ///
  /// Without a lower bound, decrementing [one] throws
  /// [InvalidPositiveIntException]. Passing [one] as the lower bound keeps
  /// that value at one.
  PositiveInt decrement([PositiveInt? minimum]) {
    final decremented = _value - 1;
    if (minimum == null) return PositiveInt(decremented);

    return PositiveInt(max(decremented, minimum.toInt()));
  }

  /// Returns the greater of this value and [minimum].
  PositiveInt coerceAtLeast(PositiveInt minimum) =>
      PositiveInt(max(_value, minimum.toInt()));

  /// Returns the smaller of this value and [maximum].
  PositiveInt coerceAtMost(PositiveInt maximum) =>
      PositiveInt(min(_value, maximum.toInt()));

  /// Whether [value] is greater than zero.
  static bool validate(int value) => value > 0;
}

/// Checked conversion from a Dart integer to [PositiveInt].
extension ForPositiveIntExtension on int {
  /// Returns this integer as a [PositiveInt], or throws
  /// [InvalidPositiveIntException] if it is zero or negative.
  PositiveInt toPositiveInt() => PositiveInt(this);
}
