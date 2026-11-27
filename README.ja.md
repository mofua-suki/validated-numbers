# Validated Numbers

[English](https://github.com/mofua-suki/validated-numbers/blob/main/README.md) · [pub.dev](https://pub.dev/packages/validated_numbers)

API が受け付ける数値の範囲を型で表現できます。

## インストール

対応する Dart SDK は 3.14.0 以上 4.0.0 未満です。

```sh
dart pub add validated_numbers
```

| 範囲 | 整数 | 有限の浮動小数点数 |
| --- | --- | --- |
| 正（0 より大きい） | `PositiveInt` | `PositiveDouble` |
| 非負（0 以上） | `ZeroOrPositiveInt` | `ZeroOrPositiveDouble` |
| 負（0 より小さい） | `NegativeInt` | `NegativeDouble` |

```dart
import 'package:validated_numbers/validated_numbers.dart';

final remaining = 2.toZeroOrPositiveInt().decrement(); // 1
final charge = 1.5.toPositiveDouble() + 0.5; // 2.0
final adjustment = NegativeInt(-2) + 1; // -1
final offset = (-1.5).toNegativeDouble() - 0.5; // -2.0
```

コンストラクターと変換用の拡張メソッドは、値が範囲外のときに `InvalidValueException` のサブタイプを投げます。すべての浮動小数点型で NaN と正負の無限大を拒否します。`ZeroOrPositiveDouble` は正負どちらのゼロも受け付けます。パッケージが定義する加算・減算演算子は結果も検証します。継承した他の演算は通常の `int` や `double` を返すことがあり、必要に応じてコンストラクターや変換メソッドで再検証できます。

## 開発

このリポジトリのルートで次のコマンドを実行します。

```sh
dart pub get
dart analyze
dart test
```

使用例は `dart run example/validated_numbers_example.dart` で実行できます。
