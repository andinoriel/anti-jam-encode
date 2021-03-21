import 'dart:math';

import 'package:calc/calc.dart';

double calcCapacity({double k, double t}) {
  return log2(k) / t;
}

Map<String, double> calcCharsCommunChannel(
    {int bits, int n, double i, double c0, double c1, double q, double p}) {
  var vu = bits / n;
  var r = getBinom(a: p, b: q, n: n);
  var v1 = vu *
      r.sublist(0, r.length ~/ 2).reduce((value, element) => value + element);
  var v0 =
      vu * r.sublist(r.length ~/ 2).reduce((value, element) => value + element);
  var s1 = v1 / i * c1;
  var s0 = v0 * c0;
  var sdelta = s1 - s0;
  return {
    'vu': vu,
    'v0': v0,
    'v1': v1,
    'v2': 0,
    's1': s1,
    's0': s0,
    'sdelta': sdelta,
  };
}

Map<String, double> calcCharsCommunChannelWithParityBit(
    {int bits,
    int n = 1,
    double i,
    double c0,
    double c1,
    double q,
    double p,
    int parityBit}) {
  var coeff = parityBit / (parityBit + 1);
  var vu = bits * coeff;
  var r = getBinom(a: p, b: q, n: 5);
  var v1 = vu * r[0];
  var v0 = vu * r[2];
  var v2 = vu * r[1];
  var s1 = v1 / i * c1;
  var s0 = v0 * c0;
  var sdelta = s1 - s0;
  return {
    'vu': vu,
    'v0': v0,
    'v1': v1,
    'v2': v2,
    's1': s1,
    's0': s0,
    'sdelta': sdelta,
  };
}

int calculate() {
  return 6 * 7;
}

List<double> getBinom({double a, double b, int n}) {
  var results = <double>[];
  for (var k = 0; k <= n; k++) {
    results.add(getC(n, k) * pow(a, (n - k)) * pow(b, k));
  }
  return results;
}

int getC(int n, int k) {
  return factorial(n) ~/ (factorial(k) * factorial(n - k));
}

double log2(num x) {
  return log(x) / ln2;
}
