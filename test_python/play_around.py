from ieee754 import double
from ieee754 import single


def decompose_f32(fp):
    fact = single(fp)
    s = fact.sign
    e = fact.exponent
    f = fact.mantissa
    return s, e, f

def decompose_f64(fp):
    fact = double(fp)
    s = fact.sign
    e = fact.exponent
    f = fact.mantissa
    return s, e, f



s, e, f = decompose_f32(69.)
sa, ea, fa = decompose_f32(3.14)
sb, eb, fb = decompose_f32(69. + 3.14)

print(f"s={s} e={e} f={f}")
print(f"f={sa} e={ea} s={fa}")
print(f"s={sb} e={eb} f={fb}")

