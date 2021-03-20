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
    print(f"\nЄмність каналу С = {c} бод, при k = {k}, τ = {t}\n")


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
        "vu": round(vu, 8),         # загальний обсяг переданої інформації
        "v0": round(v0, 8),         # кількість отриманої спотвореної інформації
        "v1": round(v1, 8),         # кількість правильно переданої інформації
        "s0": round(s0, 2),         # штраф
        "s1": round(s1, 2),         # отримана оплата
        "sdelta": round(sdelta, 2)  # дохід
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
        "vu": round(vu, 8),         # загальний обсяг переданої інформації
        "v0": round(v0, 8),         # кількість отриманої спотвореної інформації (з пропуском помилок)
        "v1": round(v1, 8),         # кількість правильно переданої інформації
        "v2": round(v2, 8),         # кількість отриманої спотвореної інформації (з виявленням помилок)
        "s0": round(s0, 2),         # штраф
        "s1": round(s1, 2),         # отримана оплата
        "sdelta": round(sdelta, 2)  # дохід
    }


def main():
    q = 10 ** (-4)  # ймовірність помилки передачі 1 біта в каналі  
    p = 1 - q       # ймовірність правильної передачі біта
    i = 3.4           # середня ентропія переданих повідомлень
    c0 = 12        # штраф, що сплачується замовнику за одну допущену помилку
    c1 = 0.02     # сума, що стягується з замовника за передачу / прийом 1 текстового символу
    bits = 10 ** 6  # кількість переданих даних
    parity_bit = 4  # кількість кратних повторень переданої інформації

    res_1 = task_2(p, i, c0, c1, q, bits, n=1)
    res_3 = task_2(p, i, c0, c1, q, bits, n=3)
    res_5 = task_2(p, i, c0, c1, q, bits, n=5)
    res_bit = task_2_bit(p, i, c0, c1, q, bits, parity_bit)
    
    print("-"*101)
    print(f"| {'Параметр':10}| {'При одноразовому':20}| {'При триразовому':20}| {'При п`ятикратному':20}| {'При біті парності':20}|")
    print("-"*101)
    print(
        f"| {'Vu біт':10}| {res_1['vu']:20}| {res_3['vu']:20}| {res_5['vu']:20}| {res_bit['vu']:20}|")
    print(
        f"| {'V0 біт':10}| {res_1['v0']:20}| {res_3['v0']:20}| {res_5['v0']:20}| {res_bit['v0']:20}|")
    print(
        f"| {'V1 біт':10}| {res_1['v1']:20}| {res_3['v1']:20}| {res_5['v1']:20}| {res_bit['v1']:20}|")
    print(f"| {'V2 біт':10}| {'':20}| {'':20}| {'':20}| {res_bit['v2']:20}|")
    print(
        f"| {'S0 грн.':10}| {res_1['s0']:20}| {res_3['s0']:20}| {res_5['s0']:20}| {res_bit['s0']:20}|")
    print(
        f"| {'S1 грн.':10}| {res_1['s1']:20}| {res_3['s1']:20}| {res_5['s1']:20}| {res_bit['s1']:20}|")
    print(
        f"| {'SΔ грн.':10}| {res_1['sdelta']:20}| {res_3['sdelta']:20}| {res_5['sdelta']:20}| {res_bit['sdelta']:20}|")
    print("-"*101)
    print('Максимальний дохід: ', max(res_1['sdelta'],res_3['sdelta'],res_5['sdelta'],res_bit['sdelta']))


if __name__ == '__main__':
    main()
