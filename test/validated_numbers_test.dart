import 'package:test/test.dart';
import 'package:validated_numbers/validated_numbers.dart';

void main() {
  group('PositiveDouble', () {
    test('accepts finite positive values and validates arithmetic results', () {
      final value = 1.25.toPositiveDouble();
      final PositiveDouble sum = value + 0.75;
      final PositiveDouble difference = sum - value;

      expect(PositiveDouble.validate(double.minPositive), isTrue);
      expect(sum, 2.0);
      expect(difference, 0.75);
      expect(value.toZeroOrPositiveDouble(), 1.25);
      expect(
        () => value - value,
        throwsA(isA<InvalidPositiveDoubleException>()),
      );
    });

    for (final value in [
      0.0,
      -0.0,
      -1.0,
      double.nan,
      double.infinity,
      double.negativeInfinity,
    ]) {
      test('rejects $value at construction and conversion', () {
        expect(PositiveDouble.validate(value), isFalse);
        expect(
          () => value.toPositiveDouble(),
          throwsA(isA<InvalidPositiveDoubleException>()),
        );
      });
    }

    test('rejects overflow and NaN in wrapped arithmetic', () {
      final largest = PositiveDouble(double.maxFinite);
      final invalid = throwsA(isA<InvalidPositiveDoubleException>());

      expect(() => largest + double.maxFinite, invalid);
      expect(() => largest + double.nan, invalid);
    });
  });

  group('ZeroOrPositiveDouble', () {
    test('accepts both signed zeros and permits subtraction to zero', () {
      final positive = 1.25.toZeroOrPositiveDouble();
      final ZeroOrPositiveDouble zero = positive - 1.25;
      final ZeroOrPositiveDouble sum = zero + 0.75;

      expect(ZeroOrPositiveDouble.validate(0.0), isTrue);
      expect(ZeroOrPositiveDouble(-0.0).isNegative, isTrue);
      expect(zero, 0.0);
      expect(sum, 0.75);
      expect(
        () => zero - 1.0,
        throwsA(isA<InvalidZeroOrPositiveDoubleException>()),
      );
    });

    for (final value in [
      -1.0,
      double.nan,
      double.infinity,
      double.negativeInfinity,
    ]) {
      test('rejects $value at construction and conversion', () {
        expect(ZeroOrPositiveDouble.validate(value), isFalse);
        expect(
          () => value.toZeroOrPositiveDouble(),
          throwsA(isA<InvalidZeroOrPositiveDoubleException>()),
        );
      });
    }

    test('rejects overflow and non-finite arithmetic results', () {
      final largest = ZeroOrPositiveDouble(double.maxFinite);
      final invalid = throwsA(isA<InvalidZeroOrPositiveDoubleException>());

      expect(() => largest + double.maxFinite, invalid);
      expect(() => largest - double.negativeInfinity, invalid);
      expect(() => largest + double.nan, invalid);
    });
  });
}
