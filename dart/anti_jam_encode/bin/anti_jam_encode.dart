import 'package:anti_jam_encode/anti_jam_encode.dart' as anti_jam_encode;
import 'package:intl/intl.dart';

void main(List<String> arguments) {
  print('# Capacity of the communication channel where k(signal types): 9 and '
      't(time): 0.23');
  print('\tC: ${anti_jam_encode.calcCapacity(k: 9, t: 0.23)}\n');
  print('# Calculation of characteristics of communication channel with '
      'interference');
  var numberFormat = NumberFormat.simpleCurrency(locale: 'uk');
  var numberFormatDecimal = NumberFormat.decimalPattern();
  for (var n in <int>[1, 3, 5, -1]) {
    var data = <String, double>{};
    if (n == -1) {
      data = anti_jam_encode.calcCharsCommunChannel(
          i: 3.4, c1: 0.02, c0: 2, parityBit: 4);
      print('## With parity bit');
    } else {
      data =
          anti_jam_encode.calcCharsCommunChannel(n: n, i: 3.4, c1: 0.02, c0: 2);
      print('## Number of reps is $n');
    }

    print(
        '\tTotal transmitted (vu): ${numberFormatDecimal.format(data['vu'])} bits');
    print(
        '\tCorrect transmitted (v1): ${numberFormatDecimal.format(data['v1'])} bits');
    print(
        '\tInorrect transmitted (v0): ${numberFormatDecimal.format(data['v0'])} bits');
    if (n == -1) {
      print(
          '\tSkipped inorrect transmitted  (v2): ${numberFormatDecimal.format(data['v2'])} bits');
    }
    print('\tIncome (s1): ${numberFormat.format(data['s1'])}');
    print('\tPenalty (s0): ${numberFormat.format(data['s0'])}');
    print('\tNet income (sΔ): ${numberFormat.format(data['sdelta'])}');
  }
}
