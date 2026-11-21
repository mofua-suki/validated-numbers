import 'invalid_value_exception.dart';

/// An integer strictly less than zero.
extension type const NegativeInt._(int _value) implements int {
  /// Throws [InvalidNegativeIntException] for an invalid [value].
  NegativeInt(int value) : this._(_validated(value));

  /// Adds [other] and validates the result.
  NegativeInt operator +(int other) => NegativeInt(_value + other);

  /// Subtracts [other] and validates the result.
  NegativeInt operator -(int other) => NegativeInt(_value - other);

  /// Checks whether [value] is strictly less than zero.
  static bool validate(int value) => value < 0;

  static int _validated(int value) {
    if (!validate(value)) throw InvalidNegativeIntException(value);
    return value;
  }
}

/// Converts an int to a validated negative integer.
extension ForNegativeIntExtension on int {
  /// Validates this value and returns it as a [NegativeInt].
  NegativeInt toNegativeInt() => NegativeInt(this);
}

/// The supplied value is outside the range of [NegativeInt].
final class InvalidNegativeIntException extends InvalidValueException<int> {
  /// Records the rejected [value].
  const InvalidNegativeIntException(int value)
    : super(invalidValue: value, message: 'value must be negative');
}
