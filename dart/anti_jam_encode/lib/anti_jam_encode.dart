import 'dart:math';

import 'package:calc/calc.dart';

int getC(int n, int k) {
  return factorial(n) ~/ (factorial(k) * factorial(n - k));
}

List<double> getBinom({double a, double b, int n}) {
  var results = <double>[];
  for (var k = 0; k <= n; k++) {
    results.add(getC(n, k) * pow(a, (n - k)) * pow(b, k));
  }
  return results;
}

double log2(num x) {
  return log(x) / ln2;
}

int calculate() {
  return 6 * 7;
}

// 1. Calculate the capacity of the communication channel without noise when
//    transmitting different types of signals (Appendix D).
// 2. Calculation of characteristics of communication channel with interference
//    when using binary communication system (0-1) when transmitting text
//    information (Appendix E). Choose the best method of information
//    transmission (from 2 or more options) in commercial operation of the
//    channel.
// 3. Solve the inverse problem for item 2: find the size of the penalty for
//    skipping distortion during transmission for which both codes will give
//    equal economic effect.

double calcCapacity({double k, double t}) {
  return log2(k) / t;
}

Map<String, double> calcCharsCommunChannel(
    {int n = 1, double i, double c1, double c0, int parityBit = -1}) {
  var vu = 0.0;
  var bits = pow(10, 9);
  var q = pow(10, -4);
  var p = 1 - q;
  var v = <double>[];
  var r = <double>[];
  vu = bits / n;
  if (parityBit != -1) {
    var coeff = parityBit / (parityBit + 1);
    vu = vu * coeff;
    r = getBinom(a: p, b: q, n: 5);
    v.add(vu * r[2]); // v0
    v.add(vu * r[1]); // v1
    v.add(vu * r[0]); // v2
  } else {
    r = getBinom(a: p, b: q, n: n);
    print(r.sublist(r.length ~/ 2).reduce((value, element) => value + element));
    print(r
        .sublist(0, r.length ~/ 2)
        .reduce((value, element) => value + element));
    v.add(vu *
        r.sublist(r.length ~/ 2).reduce((value, element) => value + element));
    v.add(vu *
        r
            .sublist(0, r.length ~/ 2)
            .reduce((value, element) => value + element));
  }
  var s0 = v[0] * c0;
  var s1 = v[1] / i * c1;
  var sdelta = s1 - s0;
  return {
    'vu': vu,
    'v0': v[0],
    'v1': v[1],
    'v2': v.length > 2 ? v[2] : -1,
    's1': s1,
    's0': s0,
    'sdelta': sdelta,
  };
}
