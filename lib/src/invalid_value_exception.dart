import "package:meta/meta.dart";

/// An operation received or produced a value outside its allowed range.
///
/// [invalidValue] contains the rejected value. [message] describes the
/// requirement it failed. For example, decimal division rejects a divisor
/// that is numerically zero.
@immutable
class const InvalidValueException<T>({
  required final T invalidValue,
  required final String message,
}) implements Exception {
  @override
  String toString() =>
      "${runtimeType.toString()}: $message, but was $invalidValue.";
}

/// A positive integer was required, but the value was zero or negative.
class const InvalidPositiveIntException(int invalidValue)
    extends InvalidValueException<int> {
  this : super(invalidValue: invalidValue, message: "value must be positive");
}

/// A non-negative integer was required, but the value was negative.
class const InvalidZeroOrPositiveIntException(int invalidValue)
    extends InvalidValueException<int> {
  this : super(invalidValue: invalidValue, message: "value must be 0 or more");
}
