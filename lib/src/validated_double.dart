import 'invalid_value_exception.dart';

/// A finite double strictly greater than zero.
extension type const PositiveDouble._(double _value) implements double {
  /// Throws [InvalidPositiveDoubleException] for an invalid [value].
  PositiveDouble(double value) : this._(_validated(value));

  /// Adds [other] and validates the result.
  PositiveDouble operator +(double other) => PositiveDouble(_value + other);

  /// Subtracts [other] and validates the result.
  PositiveDouble operator -(PositiveDouble other) =>
      PositiveDouble(_value - other._value);

  /// Checks whether [value] is finite and strictly greater than zero.
  static bool validate(double value) => value.isFinite && value > 0;

  static double _validated(double value) {
    if (!validate(value)) throw InvalidPositiveDoubleException(value);
    return value;
  }
}

/// A finite double greater than or equal to zero.
extension type const ZeroOrPositiveDouble._(double _value) implements double {
  /// Throws [InvalidZeroOrPositiveDoubleException] for an invalid [value].
  ZeroOrPositiveDouble(double value) : this._(_validated(value));

  /// Adds [other] and validates the result.
  ZeroOrPositiveDouble operator +(double other) =>
      ZeroOrPositiveDouble(_value + other);

  /// Subtracts [other] and validates the result.
  ZeroOrPositiveDouble operator -(double other) =>
      ZeroOrPositiveDouble(_value - other);

  /// Checks whether [value] is finite and at least zero.
  static bool validate(double value) => value.isFinite && value >= 0;

  static double _validated(double value) {
    if (!validate(value)) throw InvalidZeroOrPositiveDoubleException(value);
    return value;
  }
}

/// A finite double strictly less than zero.
extension type const NegativeDouble._(double _value) implements double {
  /// Throws [InvalidNegativeDoubleException] for an invalid [value].
  NegativeDouble(double value) : this._(_validated(value));

  /// Adds [other] and validates the result.
  NegativeDouble operator +(double other) => NegativeDouble(_value + other);

  /// Subtracts [other] and validates the result.
  NegativeDouble operator -(double other) => NegativeDouble(_value - other);

  /// Checks whether [value] is finite and strictly less than zero.
  static bool validate(double value) => value.isFinite && value < 0;

  static double _validated(double value) {
    if (!validate(value)) throw InvalidNegativeDoubleException(value);
    return value;
  }
}

/// Converts a double to a validated positive double.
extension ForPositiveDoubleExtension on double {
  /// Validates this value and returns it as a [PositiveDouble].
  PositiveDouble toPositiveDouble() => PositiveDouble(this);
}

/// Converts a double to a validated non-negative double.
extension ForZeroOrPositiveDoubleExtension on double {
  /// Validates this value and returns it as a [ZeroOrPositiveDouble].
  ZeroOrPositiveDouble toZeroOrPositiveDouble() => ZeroOrPositiveDouble(this);
}

/// Converts a double to a validated negative double.
extension ForNegativeDoubleExtension on double {
  /// Validates this value and returns it as a [NegativeDouble].
  NegativeDouble toNegativeDouble() => NegativeDouble(this);
}

/// The supplied value is outside the range of [PositiveDouble].
final class InvalidPositiveDoubleException
    extends InvalidValueException<double> {
  /// Records the rejected [value].
  const InvalidPositiveDoubleException(double value)
    : super(invalidValue: value, message: 'value must be finite and positive');
}

/// The supplied value is outside the range of [ZeroOrPositiveDouble].
final class InvalidZeroOrPositiveDoubleException
    extends InvalidValueException<double> {
  /// Records the rejected [value].
  const InvalidZeroOrPositiveDoubleException(double value)
    : super(
        invalidValue: value,
        message: 'value must be finite and non-negative',
      );
}

/// The supplied value is outside the range of [NegativeDouble].
final class InvalidNegativeDoubleException
    extends InvalidValueException<double> {
  /// Records the rejected [value].
  const InvalidNegativeDoubleException(double value)
    : super(invalidValue: value, message: 'value must be finite and negative');
}
