import "dart:math";

import "package:meta/meta.dart";

import "invalid_value_exception.dart";

/// A Dart integer that may be zero but cannot be negative.
///
/// Use this type for quantities that can reach zero, such as a count or
/// the number of fractional digits to retain in decimal arithmetic.
/// Use scale [zero] when rounding a decimal to an integer.
///
/// The constructor and the arithmetic methods declared here check the
/// result and throw [InvalidZeroOrPositiveIntException] if it is negative.
/// This type uses Dart's `int` range and arithmetic.
@immutable
extension type const ZeroOrPositiveInt._(int _value) implements int {
  /// The smallest valid non-negative integer.
  static ZeroOrPositiveInt get zero => const ZeroOrPositiveInt._(0);

  /// Validates an integer, throwing [InvalidZeroOrPositiveIntException] for
  /// a negative value.
  ZeroOrPositiveInt(this._value) {
    if (!validate(_value)) throw InvalidZeroOrPositiveIntException(_value);
  }

  /// Adds [other] and validates that the result remains non-negative.
  ZeroOrPositiveInt operator +(int other) {
    final result = _value + other;
    if (!validate(result)) throw InvalidZeroOrPositiveIntException(result);
    return ZeroOrPositiveInt(result);
  }

  /// Subtracts [other] and validates that the result remains non-negative.
  ZeroOrPositiveInt operator -(int other) {
    final result = _value - other;
    if (!validate(result)) throw InvalidZeroOrPositiveIntException(result);
    return ZeroOrPositiveInt(result);
  }

  /// Adds one, clamping the result to [maximum] when supplied.
  ///
  /// If this value is already at or above [maximum], returns [maximum].
  ZeroOrPositiveInt increment([ZeroOrPositiveInt? maximum]) {
    if (maximum != null && _value >= maximum) return maximum;
    return ZeroOrPositiveInt(_value + 1);
  }

  /// Subtracts one, clamping the result to [minimum] when supplied.
  ///
  /// Without a lower bound, decrementing [zero] throws
  /// [InvalidZeroOrPositiveIntException]. Passing [zero] as the lower bound
  /// keeps that value at zero.
  ZeroOrPositiveInt decrement([ZeroOrPositiveInt? minimum]) {
    final decremented = _value - 1;
    if (minimum == null) return ZeroOrPositiveInt(decremented);

    return ZeroOrPositiveInt(max(decremented, minimum.toInt()));
  }

  /// Returns the greater of this value and [minimum].
  ZeroOrPositiveInt coerceAtLeast(ZeroOrPositiveInt minimum) =>
      ZeroOrPositiveInt(max(_value, minimum.toInt()));

  /// Returns the smaller of this value and [maximum].
  ZeroOrPositiveInt coerceAtMost(ZeroOrPositiveInt maximum) =>
      ZeroOrPositiveInt(min(_value, maximum.toInt()));

  /// Whether [value] is zero or greater.
  static bool validate(int value) => value >= 0;

  /// Whether this value equals zero.
  bool get isZero => _value == 0;
}

/// Checked conversion from a Dart integer to [ZeroOrPositiveInt].
extension ForZeroOrPositiveIntExtension on int {
  /// Returns this integer as a [ZeroOrPositiveInt], or throws
  /// [InvalidZeroOrPositiveIntException] if it is negative.
  ZeroOrPositiveInt toZeroOrPositiveInt() => ZeroOrPositiveInt(this);
}
