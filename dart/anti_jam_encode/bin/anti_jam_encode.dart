import 'dart:math';

import 'package:anti_jam_encode/anti_jam_encode.dart';
import 'package:intl/intl.dart';

void main(List<String> arguments) {
  var numberFormat = NumberFormat.simpleCurrency(locale: 'uk');
  var numberFormatDecimal = NumberFormat.decimalPattern();
  var k = 9;
  var t = 0.23;
  var bits = pow(10, 6);
  var q = pow(10, -5);
  var p = 1 - q;
  var i = 3.0;
  var c0 = 3.4;
  var c1 = 0.04;
  print(
      'Capacity of the communication channel: ${numberFormatDecimal.format(calcCapacity(k: 9, t: 0.23))}, where k(signal types): $k and t(time): $t:\n');
  var data = <Map<String, double>>[];
  data.add(calcCharsCommunChannel(
      bits: bits, p: p, q: q, i: i, c0: c0, c1: c1, n: 1));
  data.add(calcCharsCommunChannel(
      bits: bits, p: p, q: q, i: i, c0: c0, c1: c1, n: 3));
  data.add(calcCharsCommunChannel(
      bits: bits, p: p, q: q, i: i, c0: c0, c1: c1, n: 5));
  data.add(calcCharsCommunChannelWithParityBit(
      bits: bits, p: p, q: q, i: i, c0: c0, c1: c1, parityBit: 4));
  print_data(data);
  print('Penalty: ${c0.toStringAsFixed(2)}');
  while (data[0]['sdelta'] > data[3]['sdelta']) {
    data[0] = calcCharsCommunChannel(
        bits: bits, p: p, q: q, i: i, c0: c0, c1: c1, n: 1);
    data[1] = calcCharsCommunChannel(
        bits: bits, p: p, q: q, i: i, c0: c0, c1: c1, n: 3);
    data[2] = calcCharsCommunChannel(
        bits: bits, p: p, q: q, i: i, c0: c0, c1: c1, n: 5);
    data[3] = calcCharsCommunChannelWithParityBit(
        bits: bits, p: p, q: q, i: i, c0: c0, c1: c1, parityBit: 4);
    c0 += 0.001;
  }
  print_data(data);
  print('Penalty: ${c0.toStringAsFixed(2)}');
}

void print_data(
  List<Map<String, double>> data,
) {
  var length = 19;
  var nameLength = 35;
  var string = ''.padLeft(nameLength);
  for (var element in [
    'With a 1 repetition',
    'With 2 repetitions',
    'With 3 repetitions',
    'With parity bit'
  ]) {
    string += ' ${element.padLeft(length)} |';
  }
  print(string);
  string = 'Total Transmitted (vu) |'.padLeft(nameLength);
  for (var element in data) {
    string += ' ${element['vu'].toStringAsFixed(2).padLeft(length)} |';
  }
  print(string);
  string = 'Correct Transmitted (v1) |'.padLeft(nameLength);
  for (var element in data) {
    string += ' ${element['v1'].toStringAsFixed(2).padLeft(length)} |';
  }
  print(string);
  string = 'Inorrect Transmitted (v0) |'.padLeft(nameLength);
  for (var element in data) {
    string += ' ${element['v0'].toStringAsFixed(2).padLeft(length)} |';
  }
  print(string);
  string = 'Skipped Inorrect Transmitted (v2) |'.padLeft(nameLength);
  for (var element in data) {
    string += ' ${element['v2'].toStringAsFixed(2).padLeft(length)} |';
  }
  print(string);
  string = 'Income (s1) |'.padLeft(nameLength);
  for (var element in data) {
    string += ' ${element['s1'].toStringAsFixed(2).padLeft(length)} |';
  }
  print(string);
  string = 'Penalty (s0) |'.padLeft(nameLength);
  for (var element in data) {
    string += ' ${element['s0'].toStringAsFixed(2).padLeft(length)} |';
  }
  print(string);
  string = 'Net Income (sΔ) |'.padLeft(nameLength);
  for (var element in data) {
    string += ' ${element['sdelta'].toStringAsFixed(2).padLeft(length)} |';
  }
  print(string);
  var max_income = 0.0;
  for (var element in data) {
    max_income = max(max_income, element['sdelta']);
  }
  print('Max Net Income: ${max_income.toStringAsFixed(2)}');
}
