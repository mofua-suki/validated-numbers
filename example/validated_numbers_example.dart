import 'package:validated_numbers/validated_numbers.dart';

void main() {
  final count = 2.toZeroOrPositiveInt();
  print(count.decrement()); // 1
  final rate = 1.5.toPositiveDouble();
  print(rate + 0.5); // 2.0
  final adjustment = (-1.5).toNegativeDouble();
  print(adjustment - 0.5); // -2.0
}
