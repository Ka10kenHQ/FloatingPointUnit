import unittest
import struct
from ieee754 import single, double

def decompose_f32(fp: float):
    fact = single(str(fp))
    s = int(fact.sign)
    e = int(fact.exponent)
    f = int(fact.mantissa)
    return s, e, f

def decompose_f64(fp: float):
    fact = double(str(fp))
    s = int(fact.sign)
    e = int(fact.exponent)
    f = int(fact.mantissa)
    return s, e, f

class TestFloatingPointDecomposition(unittest.TestCase):

    def test_add_f64(self):
        computed_file_path = "/home/achir/FloatingPointUnit/test/add_sub_output_results.txt"
        correct_file_path = "computed"

        with open(computed_file_path, 'r') as computed_file, open(decomposed_file_path, 'r') as decomposed_file:
            computed_lines = computed_file.readlines()
            decomposed_lines = decomposed_file.readlines()

            for i, (computed_line, expected_line) in enumerate(zip(computed_lines, decomposed_lines)):
                parts = expected_line.split(';')
                self.assertEqual(len(parts), 2, f"Invalid format at line {i + 1}")

                a = struct.unpack('!d', struct.pack('!Q', int(parts[0], 2)))[0]
                b = struct.unpack('!d', struct.pack('!Q', int(parts[1], 2)))[0]
                result = a + b

                s_exp, e_exp, f_exp = decompose_f64(result)
                expected_output = f"{s_exp:b}{e_exp:011b}{f_exp:052b}"

                self.assertEqual(computed_line.strip(), expected_output,
                                 f"Mismatch at line {i + 1}:\nComputed: {computed_line.strip()}\nCorrect: {expected_output}\nInputs: a = {a}, b = {b}, output = {result}")

    def test_sub_f64(self):
        computed_file_path = "/home/achir/FloatingPointUnit/test/add_sub_output_results_sub.txt"
        decomposed_file_path = "decomposed_f64.txt"

        with open(computed_file_path, 'r') as computed_file, open(decomposed_file_path, 'r') as decomposed_file:
            computed_lines = computed_file.readlines()
            decomposed_lines = decomposed_file.readlines()

            for i, (computed_line, expected_line) in enumerate(zip(computed_lines, decomposed_lines)):
                parts = expected_line.split(';')
                self.assertEqual(len(parts), 2, f"Invalid format at line {i + 1}")

                a = struct.unpack('!d', struct.pack('!Q', int(parts[0], 2)))[0]
                b = struct.unpack('!d', struct.pack('!Q', int(parts[1], 2)))[0]
                result = a - b

                s_exp, e_exp, f_exp = decompose_f64(result)
                expected_output = f"{s_exp:b}{e_exp:011b}{f_exp:052b}"

                self.assertEqual(computed_line.strip(), expected_output,
                                 f"Mismatch at line {i + 1}:\nComputed: {computed_line.strip()}\nCorrect: {expected_output}")

    def test_add_f32(self):
        computed_file_path = "/home/achir/FloatingPointUnit/test/add_sub_output_results_32.txt"
        decomposed_file_path = "decomposed_f32.txt"

        with open(computed_file_path, 'r') as computed_file, open(decomposed_file_path, 'r') as decomposed_file:
            computed_lines = computed_file.readlines()
            decomposed_lines = decomposed_file.readlines()

            for i, (computed_line, expected_line) in enumerate(zip(computed_lines, decomposed_lines)):
                parts = expected_line.split(';')
                self.assertEqual(len(parts), 2, f"Invalid format at line {i + 1}")

                a32 = int(parts[0][:32], 2)
                b32 = int(parts[1][:32], 2)

                a = struct.unpack('!f', struct.pack('!I', a32))[0]
                b = struct.unpack('!f', struct.pack('!I', b32))[0]
                result = a + b

                s_exp, e_exp, f_exp = decompose_f32(result)
                expected_output = f"{s_exp:b}{e_exp:08b}{f_exp:023b}"

                self.assertEqual(computed_line.strip(), expected_output,
                                 f"Mismatch at line {i + 1}:\nComputed: {computed_line.strip()}\nCorrect: {expected_output}\nInputs: a = {a}, b = {b}, output = {result}")

    def test_sub_f32(self):
        computed_file_path = "/home/achir/FloatingPointUnit/test/add_sub_output_results_32_sub.txt"
        decomposed_file_path = "decomposed_f32.txt"

        with open(computed_file_path, 'r') as computed_file, open(decomposed_file_path, 'r') as decomposed_file:
            computed_lines = computed_file.readlines()
            decomposed_lines = decomposed_file.readlines()

            for i, (computed_line, expected_line) in enumerate(zip(computed_lines, decomposed_lines)):
                parts = expected_line.split(';')
                self.assertEqual(len(parts), 2, f"Invalid format at line {i + 1}")

                a32 = int(parts[0][:32], 2)
                b32 = int(parts[1][:32], 2)

                a = struct.unpack('!f', struct.pack('!I', a32))[0]
                b = struct.unpack('!f', struct.pack('!I', b32))[0]
                result = a - b

                s_exp, e_exp, f_exp = decompose_f32(result)
                expected_output = f"{s_exp:b}{e_exp:08b}{f_exp:023b}"

                self.assertEqual(computed_line.strip(), expected_output,
                                 f"Mismatch at line {i + 1}:\nComputed: {computed_line.strip()}\nCorrect: {expected_output}")

if __name__ == '__main__':
    unittest.main()

