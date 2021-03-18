import math


def get_c(n, k):
    return math.factorial(n)/(math.factorial(k) * math.factorial(n-k))


def binom_halfs(a, b, n=3):
    results = []
    for k in range(n+1):
        results.append(get_c(n, k) * a ** (n-k) * b ** (k))
    return results


def task_1(k, t):
    c = math.log2(k)/t
    print(c, "бод")


def task_2(p, i, c0, c1, q, bits, n=1):
    vu = bits / n
    results = binom_halfs(p, q, n)
    a, b = sum(results[:len(results)//2]), sum(results[len(results)//2:])
    v1 = vu * a
    v0 = vu * b
    s1 = v1 / i * c1
    s0 = v0 * c0
    sdelta = s1 - s0
    return {
        "vu": round(vu, 8),
        "v0": round(v0, 8),
        "v1": round(v1, 8),
        "s0": round(s0, 2),
        "s1": round(s1, 2),
        "sdelta": round(sdelta, 2)
    }


def task_2_bit(p, i, c0, c1, q, bits, parity_bit):
    coeff = parity_bit/(parity_bit+1)
    vu = bits * coeff
    r = binom_halfs(p, q, 5)
    v1 = vu * r[0]
    v2 = vu * r[1]
    v0 = vu * r[2]
    s1 = v1 / i * c1
    s0 = v0*c0
    sdelta = s1 - s0
    return {
        "vu": round(vu, 8),
        "v0": round(v0, 8),
        "v1": round(v1, 8),
        "v2": round(v2, 8),
        "s0": round(s0, 2),
        "s1": round(s1, 2),
        "sdelta": round(sdelta, 2)
    }


def main():
    q = 10 ** (-4)
    p = 1 - q
    i = 3.4
    c1 = 0.02
    c0 = 2
    bits = 10 ** 9
    parity_bit = 4
    res_1 = task_2(p, i, c0, c1, q, bits, n=1)
    res_3 = task_2(p, i, c0, c1, q, bits, n=3)
    res_5 = task_2(p, i, c0, c1, q, bits, n=5)
    res_bit = task_2_bit(p, i, c1, c0, q, bits, parity_bit)
    print("-"*101)
    print(f"| {'Параметр':10}| {'При однократном':20}| {'При трехкратном':20}| {'При пятикратном':20}| {'При бите четности':20}|")
    print("-"*101)
    print(
        f"| {'Vu бит':10}| {res_1['vu']:20}| {res_3['vu']:20}| {res_5['vu']:20}| {res_bit['vu']:20}|")
    print(
        f"| {'V0 бит':10}| {res_1['v0']:20}| {res_3['v0']:20}| {res_5['v0']:20}| {res_bit['v0']:20}|")
    print(
        f"| {'V1 бит':10}| {res_1['v1']:20}| {res_3['v1']:20}| {res_5['v1']:20}| {res_bit['v1']:20}|")
    print(f"| {'V2 бит':10}| {'':20}| {'':20}| {'':20}| {res_bit['v2']:20}|")
    print(
        f"| {'S0 грн.':10}| {res_1['s0']:20}| {res_3['s0']:20}| {res_5['s0']:20}| {res_bit['s0']:20}|")
    print(
        f"| {'S1 грн.':10}| {res_1['s1']:20}| {res_3['s1']:20}| {res_5['s1']:20}| {res_bit['s1']:20}|")
    print(
        f"| {'SΔ грн.':10}| {res_1['sdelta']:20}| {res_3['sdelta']:20}| {res_5['sdelta']:20}| {res_bit['sdelta']:20}|")


if __name__ == '__main__':
    main()
