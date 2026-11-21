import "package:validated_numbers/validated_numbers.dart";
import "package:test/test.dart";

void main() {
  group("[UnitTest] ZeroOrPositiveInt", () {
    /// ---------- 正常系 ---------- ///

    test("[Positive] 0で生成できる", () {
      // 実行
      final result = ZeroOrPositiveInt(0);

      // 検証
      expect(result, 0.toZeroOrPositiveInt());
    });

    test("[Positive] incrementで1加算される", () {
      // 準備
      final value = 1.toZeroOrPositiveInt();

      // 実行
      final result = value.increment();

      // 検証
      expect(result, 2.toZeroOrPositiveInt());
    });

    test("[Positive] incrementはmaximumを超えない", () {
      // 準備
      final value = 3.toZeroOrPositiveInt();
      final maximum = 3.toZeroOrPositiveInt();

      // 実行
      final result = value.increment(maximum);

      // 検証
      expect(result, maximum);
    });

    test("[Positive] incrementはmaximumがnullなら通常加算される", () {
      // 準備
      final value = 1.toZeroOrPositiveInt();

      // 実行
      final result = value.increment(null);

      // 検証
      expect(result, 2.toZeroOrPositiveInt());
    });

    test("[Positive] incrementは現在値が上限を超えている場合に上限を返す", () {
      // 準備
      final value = 3.toZeroOrPositiveInt();
      final maximum = ZeroOrPositiveInt.zero;

      // 実行
      final result = value.increment(maximum);

      // 検証
      expect(result, maximum);
    });

    test("[Positive] incrementはintの最大値を上限に指定してもオーバーフローしない", () {
      // 準備
      final maximum = int.parse("9223372036854775807").toZeroOrPositiveInt();

      // 実行
      final result = maximum.increment(maximum);

      // 検証
      expect(result, maximum);
    });

    test("[Positive] decrementで1減算される", () {
      // 準備
      final value = 2.toZeroOrPositiveInt();

      // 実行
      final result = value.decrement();

      // 検証
      expect(result, 1.toZeroOrPositiveInt());
    });

    test("[Positive] decrementはminimumを下回らない", () {
      // 準備
      final value = ZeroOrPositiveInt.zero;
      final minimum = ZeroOrPositiveInt.zero;

      // 実行
      final result = value.decrement(minimum);

      // 検証
      expect(result, minimum);
    });

    test("[Positive] decrementはminimumがnullなら通常減算される", () {
      // 準備
      final value = 2.toZeroOrPositiveInt();

      // 実行
      final result = value.decrement(null);

      // 検証
      expect(result, 1.toZeroOrPositiveInt());
    });

    test("[Positive] validateは0以上の値でtrueを返す", () {
      // 実行
      final result = ZeroOrPositiveInt.validate(0);

      // 検証
      expect(result, isTrue);
    });

    /// ---------- 異常系 ---------- ///

    test("[Negative] 負の値で生成するとInvalidZeroOrPositiveIntExceptionがthrowされる", () {
      // 実行・検証
      expect(
        () => ZeroOrPositiveInt(-1),
        throwsA(isA<InvalidZeroOrPositiveIntException>()),
      );
    });

    test(
      "[Negative] decrementで0未満になるとInvalidZeroOrPositiveIntExceptionがthrowされる",
      () {
        // 準備
        final value = ZeroOrPositiveInt.zero;

        // 実行・検証
        expect(
          value.decrement,
          throwsA(isA<InvalidZeroOrPositiveIntException>()),
        );
      },
    );

    test("[Negative] validateは負の値でfalseを返す", () {
      // 実行
      final result = ZeroOrPositiveInt.validate(-1);

      // 検証
      expect(result, isFalse);
    });
  });
}
