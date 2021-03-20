#[allow(dead_code)]
fn task_1(k: f32, t: f32) -> f32 {
    k.log2() / t
}

#[allow(dead_code)]
fn coeffize_binom(a: f32, b: f32, n: u32) -> Vec<f32> {
    fn factorial(num: u32) -> u32 {
        match num {
            0 => 1,
            1 => 1,
            _ => factorial(num - 1) * num,
        }
    }
    let combination = |n: u32, k: u32| factorial(n) / (factorial(k) * factorial(n - k));

    let mut coeffs = vec![];
    for k in 0..n + 1 {
        coeffs.push(
            combination(a as u32, b as u32) as f32 * a.powf((n - k) as f32) * b.powf(k as f32),
        );
    }

    coeffs
}

#[allow(dead_code)]
fn task_2(i: f32, c0: f32, c1: f32, q: f32, bits: u32, n: u32) -> (f32, f32, f32, f32, f32, f32) {
    let p = 1. - q;
    let vu = bits as f32 / n as f32;

    let coeffized = coeffize_binom(p, q, n);
    let a: f32 = (&coeffized[..coeffized.len() / 2]).iter().sum();
    let b: f32 = (&coeffized[coeffized.len() / 2..]).iter().sum();

    let v1 = vu as f32 * a;
    let v0 = vu as f32 * b;

    let s1 = v1 / i * c1;
    let s0 = v0 * c0;
    let s = s1 - s0;

    (vu, v0, v1, s0, s1, s)
}

#[allow(dead_code)]
fn task_2a(
    i: f32,
    c0: f32,
    c1: f32,
    q: f32,
    bits: u32,
    parity_bit: u32,
) -> (f32, f32, f32, f32, f32, f32, f32) {
    let p = 1. - q;
    let coeff = parity_bit as f32 / (parity_bit as f32 + 1.);
    let vu = bits as f32 * coeff;

    let coeffized = coeffize_binom(p, q, 5); // HARD CODE
    let v1 = vu as f32 * coeffized[0];
    let v2 = vu as f32 * coeffized[1];
    let v0 = vu as f32 * coeffized[2];

    let s1 = v1 / i * c1;
    let s0 = v0 * c0;
    let s = s1 - s0;

    (vu, v0, v1, v2, s0, s1, s)
}

#[allow(dead_code)]
fn main() {
    // task 1
    let r1 = task_1(6., 3.);
    println!("C: {} baud", r1);

    println!("============================================================");

    // task 2
    let r2: (f32, f32, f32, f32, f32, f32) = task_2(3.4, 2., 0.02, 0.0001, 1000000, 1);
    println!("Amount of all data: {}", r2.0);
    println!("Amount of all wrong data: {}", r2.1);
    println!("Amount of all correct data: {}", r2.2);
    println!("Penalty: {}", r2.3);
    println!("Payment: {}", r2.4);
    println!("Profit: {}", r2.5);

    println!("============================================================");

    // task 2a
    let r3: (f32, f32, f32, f32, f32, f32, f32) = task_2a(3.4, 2., 0.02, 0.0001, 1000000, 4);
    println!("Amount of all data: {}", r3.0);
    println!("Amount of all wrong missed data: {}", r3.1);
    println!("Amount of all correct data: {}", r3.2);
    println!("Amount of all wrong found data: {}", r3.3);
    println!("Penalty: {}", r3.4);
    println!("Payment: {}", r3.5);
    println!("Profit: {}", r3.6);
}
