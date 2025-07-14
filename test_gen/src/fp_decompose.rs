use ieee754::Ieee754;

pub fn decompose_f32(fp: f32) -> (u8, u8, u32) {
    let (sign, exp, f) = fp.decompose();
    let s = if sign { 1 } else { 0 };
    let e = (exp + 127) as u8;
    (s, e, f)
}

pub fn decompose_f64(fp: f64) -> (u8, u16, u64) {
    let (sign, exp, sig) = fp.decompose();
    let s = if sign { 1 } else { 0 };
    let e = (exp + 1023) as u16;
    let f = sig;
    (s, e, f)
}
