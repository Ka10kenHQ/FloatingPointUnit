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

    # def test_add_f64(self):
    #     computed_file_path = "/home/achir/FloatingPointUnit/test/add_sub_output_results.txt"
    #     correct_file_path = "correct_add_f64.txt"
    #
    #     with open(computed_file_path, 'r') as computed_file, open(correct_file_path, 'r') as correct_file:
    #          computed_lines = computed_file.readlines()
    #          correct_lines = correct_file.readlines()
    #
    #          for i, (computed_line, correct_line) in enumerate(zip(computed_lines, correct_lines)):
    #              self.assertEqual(
    #                 computed_line.strip(), correct_line.strip(),
    #                 f"Mismatch at line {i + 1}:\nComputed: {computed_line.strip()}\nExpected: {correct_line.strip()}"
    #                 )

    # def test_sub_f64(self):
    #     computed_file_path = "/home/achir/FloatingPointUnit/test/add_sub_output_results_sub.txt"
    #     correct_file_path = "correct_sub_f64.txt"
    #
    #
    #     with open(computed_file_path, 'r') as computed_file, open(correct_file_path, 'r') as correct_file:
    #         computed_lines = computed_file.readlines()
    #         correct_lines = correct_file.readlines()
    #
    #         for i, (computed_line, correct_line) in enumerate(zip(computed_lines, correct_lines)):
    #             self.assertEqual(
    #                 computed_line.strip(), correct_line.strip(),
    #                 f"Mismatch at line {i + 1}:\nComputed: {computed_line.strip()}\nExpected: {correct_line.strip()}"
    #             )

    def test_add_f32(self):
        computed_file_path = "/home/achir/FloatingPointUnit/test/add_sub_output_results_32.txt"
        correct_file_path = "correct_add_f32.txt"

        with open(computed_file_path, 'r') as computed_file, open(correct_file_path, 'r') as correct_file:
             computed_lines = computed_file.readlines()
             correct_lines = correct_file.readlines()

             for i, (computed_line, correct_line) in enumerate(zip(computed_lines, correct_lines)):
                 self.assertEqual(
                    computed_line.strip(), correct_line.strip(),
                    f"Mismatch at line {i + 1}:\nComputed: {computed_line.strip()}\nExpected: {correct_line.strip()}"
                    )




if __name__ == '__main__':
    unittest.main()

