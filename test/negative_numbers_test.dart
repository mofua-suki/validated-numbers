import 'package:test/test.dart';
import 'package:validated_numbers/validated_numbers.dart';

void main() {
  group('NegativeInt', () {
    test('accepts negative integers and preserves the type in arithmetic', () {
      final value = (-3).toNegativeInt();
      final NegativeInt sum = value + 1;
      final NegativeInt difference = value - 2;

      expect(NegativeInt.validate(-1), isTrue);
      expect(value, -3);
      expect(sum, -2);
      expect(difference, -5);
    });

    test('rejects zero and positive inputs and results', () {
      final invalid = throwsA(isA<InvalidNegativeIntException>());
      final value = NegativeInt(-3);

      expect(NegativeInt.validate(0), isFalse);
      expect(() => NegativeInt(0), invalid);
      expect(() => 1.toNegativeInt(), invalid);
      expect(() => value + 3, invalid);
      expect(() => value - (-4), invalid);
    });
  });

  group('NegativeDouble', () {
    test(
      'accepts finite negative values and preserves the type in arithmetic',
      () {
        final value = (-1.5).toNegativeDouble();
        final NegativeDouble sum = value + 0.5;
        final NegativeDouble difference = value - 0.5;

        expect(NegativeDouble.validate(-double.minPositive), isTrue);
        expect(sum, -1.0);
        expect(difference, -2.0);
      },
    );

    for (final value in [
      0.0,
      -0.0,
      1.0,
      double.nan,
      double.infinity,
      double.negativeInfinity,
    ]) {
      test('rejects $value at construction and conversion', () {
        final invalid = throwsA(isA<InvalidNegativeDoubleException>());
        expect(NegativeDouble.validate(value), isFalse);
        expect(() => NegativeDouble(value), invalid);
        expect(value.toNegativeDouble, invalid);
      });
    }

    test('rejects zero, sign changes, and non-finite arithmetic results', () {
      final invalid = throwsA(isA<InvalidNegativeDoubleException>());
      final value = NegativeDouble(-1.5);
      final smallest = NegativeDouble(-double.maxFinite);

      expect(() => value + 1.5, invalid);
      expect(() => value - (-2.0), invalid);
      expect(() => smallest - double.maxFinite, invalid);
      expect(() => value + double.nan, invalid);
    });
  });
}
