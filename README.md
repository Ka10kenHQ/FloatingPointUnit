# Floating-Point Unit (IEEE 754 Compliant)

This project implements a fully pipelined IEEE 754 compliant floating-point unit in synthesizable SystemVerilog. It supports addition, subtraction, multiplication, and division for both single-precision (binary32) and double-precision (binary64) floating-point numbers.

## Features

- Supports normal numbers, denormal (subnormal) numbers, and all IEEE 754 special values (NaN, infinity, zero)
- Four rounding modes: round-to-nearest/ties-to-even, toward-zero, toward-plus-infinity, toward-minus-infinity
- Five IEEE exception flags: invalid operation, division by zero, overflow, underflow, inexact
- Single-cycle addition, subtraction, and multiplication; multi-cycle division (approx 9 cycles)
- Dual-precision operation: the same datapath handles both f32 and f64, controlled by a precision-select signal

## Architecture

The design is modular and organized into three main pipeline stages following operand unpacking.

**Unpacker stage** extracts the sign, exponent, and significand from each operand, classifies special values (NaN, infinity, zero), and normalizes denormal operands by counting leading zeros.

**Arithmetic stage** has two parallel datapaths selected at runtime. The adder path handles addition and subtraction using exponent alignment, significand addition via ripple-carry, and sticky-bit computation. The multiplier-divider path handles multiplication with a combinational 58x58-bit partial-product tree using 4:2 compressor reduction, and division with a multi-cycle Newton-Raphson algorithm that reuses the same multiplier hardware. Division starts with a 256-entry reciprocal lookup table stored in an inferred ROM and iteratively refines the quotient.

**Rounder stage** is shared by both datapaths. It normalizes the result significand, applies the selected IEEE rounding mode to compute guard/round/sticky bits, adjusts the exponent for overflow or underflow, assembles the final floating-point format, and generates the IEEE exception flags.

The precision-select signal controls how fields are extracted from the 64-bit operand registers. For single-precision operations, the same 32-bit value is replicated in both halves of the 64-bit container.

## Supported Operations

| Operation | md | sub | fdiv |
|-----------|----|-----|------|
| Addition | 0 | 0 | X |
| Subtraction | 0 | 1 | X |
| Multiplication | 1 | X | 0 |
| Division | 1 | X | 1 |

Control signals: md selects the arithmetic datapath (add/sub vs mul/div), sub selects subtraction (XORed with operand B sign), and fdiv selects division over multiplication.

## Test and Verification

Testing uses a two-tier approach.

SystemVerilog testbenches drive the hardware simulation with binary test vectors read from text files and write the results to output files. Test cases are organized into three groups: normal numbers, edge cases (NaN, infinity, zero, min/max), and denormal (subnormal) numbers. Each group contains eight testbenches covering all combinations of operation (add, sub, mul, div) and precision (32, 64).

A Rust test suite generates the test vectors by enumerating floating-point values and decomposing them into binary sign/exponent/significand representations. Integration tests then read the simulation output files back, parse the results into native f32 and f64 values, compute the expected result using the corresponding Rust operation, and compare bit-for-bit against the hardware output. This provides fully automated end-to-end verification across all three test categories.

A single shell script orchestrates the entire flow: compilation of all SystemVerilog sources with ModelSim, execution of all 24 testbenches, and then running the Rust integration tests.

## Getting Started

Make sure ModelSim (from Intel Quartus Prime) and Rust with Cargo are installed.

Run all tests with:

```
./run_tests.sh
```

The script compiles the RTL sources, runs all hardware simulations, and then invokes the Rust test suite to verify correctness.

## Acknowledgments

This project was developed as part of a thesis on floating-point arithmetic hardware design.
