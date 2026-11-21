import "package:validated_numbers/validated_numbers.dart";
import "package:test/test.dart";

void main() {
  group("[UnitTest] PositiveInt", () {
    /// ---------- 正常系 ---------- ///

    test("[Positive] 正の値で生成できる", () {
      // 実行
      final result = PositiveInt(1);

      // 検証
      expect(result, 1.toPositiveInt());
    });

    test("[Positive] ZeroOrPositiveInt として受け取った値は 0 まで減算できる", () {
      // 準備
      final ZeroOrPositiveInt value = PositiveInt.one;

      // 実行
      final result = value.decrement();

      // 検証
      expect(result, ZeroOrPositiveInt.zero);
    });

    test("[Positive] incrementで1加算される", () {
      // 準備
      final value = 1.toPositiveInt();

      // 実行
      final result = value.increment();

      // 検証
      expect(result, 2.toPositiveInt());
    });

    test("[Positive] incrementはmaximumを超えない", () {
      // 準備
      final value = 3.toPositiveInt();
      final maximum = 3.toPositiveInt();

      // 実行
      final result = value.increment(maximum);

      // 検証
      expect(result, maximum);
    });

    test("[Positive] incrementはmaximumがnullなら通常加算される", () {
      // 準備
      final value = 1.toPositiveInt();

      // 実行
      final result = value.increment(null);

      // 検証
      expect(result, 2.toPositiveInt());
    });

    test("[Positive] incrementは現在値が上限を超えている場合に上限を返す", () {
      // 準備
      final value = 3.toPositiveInt();
      final maximum = PositiveInt.one;

      // 実行
      final result = value.increment(maximum);

      // 検証
      expect(result, maximum);
    });

    test("[Positive] incrementはintの最大値を上限に指定してもオーバーフローしない", () {
      // 準備
      final maximum = int.parse("9223372036854775807").toPositiveInt();

      // 実行
      final result = maximum.increment(maximum);

      // 検証
      expect(result, maximum);
    });

    test("[Positive] decrementで1減算される", () {
      // 準備
      final value = 2.toPositiveInt();

      // 実行
      final result = value.decrement();

      // 検証
      expect(result, 1.toPositiveInt());
    });

    test("[Positive] decrementはminimumを下回らない", () {
      // 準備
      final value = 1.toPositiveInt();
      final minimum = 1.toPositiveInt();

      // 実行
      final result = value.decrement(minimum);

      // 検証
      expect(result, minimum);
    });

    test("[Positive] decrementはminimumがnullなら通常減算される", () {
      // 準備
      final value = 3.toPositiveInt();

      // 実行
      final result = value.decrement(null);

      // 検証
      expect(result, 2.toPositiveInt());
    });

    test("[Positive] validateは正の値でtrueを返す", () {
      // 実行
      final result = PositiveInt.validate(1);

      // 検証
      expect(result, isTrue);
    });

    /// ---------- 異常系 ---------- ///

    test("[Negative] 0で生成するとInvalidPositiveIntExceptionがthrowされる", () {
      // 実行・検証
      expect(() => PositiveInt(0), throwsA(isA<InvalidPositiveIntException>()));
    });

    test("[Negative] decrementで0になるとInvalidPositiveIntExceptionがthrowされる", () {
      // 準備
      final value = 1.toPositiveInt();

      // 実行・検証
      expect(value.decrement, throwsA(isA<InvalidPositiveIntException>()));
    });

    test("[Negative] validateは0以下の値でfalseを返す", () {
      // 実行
      final result = PositiveInt.validate(0);

      // 検証
      expect(result, isFalse);
    });
  });
}
