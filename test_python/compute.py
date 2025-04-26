from ieee754 import double
from ieee754 import single
import struct


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


def normal_numbers():
    return [
        (69.0, 69.0),
        (3.14, 3.14),
        (1.0, 1.0),
        (2.718, 2.718),
        (1.5, 1.5),
        (12345.6789, 12345.6789),
        (1000000.0, 1000000.0),
        (42.0, 42.0),
        (123456.789, 123456.789),
        (987654321.0, 987654321.0),
        (1000000000.0, 1000000000.0),
        (1000000.0, 1000000.0),
        (100.01, 100.01),
        (123.45, 123.45),
        (54321.0, 54321.0),
        (2.0, 2.0),
        (1000000000.0, 1000000000.0),
        (1.123456, 1.123456),
        (111.0, 111.0),
        (987.0, 987.0),
        (3.1415926535, 3.1415926535),
        (1.414213562, 1.414213562),
        (2.2360679775, 2.2360679775),
        (10.0, 10.0),
        (5.0, 5.0),
        (7.89, 7.89),
        (4.56, 4.56),
        (9.99, 9.99),
        (11.11, 11.11),
        (1.0, 1.0),
        (1234567.0, 1234567.0),
        (222.0, 222.0),
        (123.0000001, 123.0000001),
        (9.81, 9.81),
        (144.0, 144.0),
        (0.001, 0.001),
        (9.876, 9.876),
        (1000.0, 1000.0),
        (250.0, 250.0),
        (500.0, 500.0),
        (50.0, 50.0),
        (7.0, 7.0),
        (3.5, 3.5),
        (15.0, 15.0),
        (99.0, 99.0),
        (22.0, 22.0),
        (1.75, 1.75),
        (12.0, 12.0),
        (30.0, 30.0),
        (11.0, 11.0),
        (77.0, 77.0),
        (9999.0, 9999.0),
        (105.0, 105.0),
        (11.5, 11.5),
        (6.25, 6.25),
        (1.6, 1.6),
        (1.25, 1.25),
        (5.5, 5.5),
        (7.5, 7.5),
        (99.99, 99.99),
        (1234.5, 1234.5),
        (333.3, 333.3),
        (4567.8, 4567.8),
        (8.9, 8.9),
    ]

def zero():
    return [(0.0, 0.0)]

def infinity():
    return [
        (float('inf'), float('inf')),
        (-float('inf'), -float('inf')),
    ]

def denormal_numbers():
    return [
        (struct.unpack('!f', struct.pack('!I', 0x00000001))[0],
         struct.unpack('!d', struct.pack('!Q', 0x0000000000000001))[0]),
        (struct.unpack('!f', struct.pack('!I', 0x80000001))[0],
         struct.unpack('!d', struct.pack('!Q', 0x8000000000000001))[0]),
        (-0.0, -0.0)
    ]

def min_max_values():
    return [
        (float('inf'), float('inf')),
        (-float('inf'), -float('inf')),
        (float('-inf'), float('-inf')),
    ]


def compute_add_64_32():
    test_cases = normal_numbers()
    test_cases.extend(zero())

    with open("correct_add_f32.txt", "w") as file_f32, open("correct_add_f64.txt", "w") as file_f64:
        for fp32a, fp64a in test_cases:
            for fp32b, fp64b in test_cases:
                s32a, e32a, f32a = decompose_f32(fp32a + fp32b)
                s64a, e64a, f64a = decompose_f64(fp64a + fp64b)

                file_f32.write(f"{s32a}{e32a}{f32a}{s32a}{e32a}{f32a}\n")
                file_f64.write(f"{s64a}{e64a}{f64a}\n")

    print("Correct written to 'correct_add_64.txt' and 'correct_add_f32'")

def compute_sub_64_32():
    test_cases = normal_numbers()
    test_cases.extend(zero())

    with open("correct_sub_f32.txt", "w") as file_f32, open("correct_sub_f64.txt", "w") as file_f64:
        for fp32a, fp64a in test_cases:
            for fp32b, fp64b in test_cases:
                s32a, e32a, f32a = decompose_f32(fp32a - fp32b)
                s64a, e64a, f64a = decompose_f64(fp64a - fp64b)

                file_f32.write(f"{s32a}{e32a}{f32a}{s32a}{e32a}{f32a}\n")
                file_f64.write(f"{s64a}{e64a}{f64a}\n")

    print("Correct written to 'correct_sub_64.txt' and 'correct_sub_f32'")


if __name__ == "__main__":
    compute_add_64_32()
    compute_sub_64_32()

