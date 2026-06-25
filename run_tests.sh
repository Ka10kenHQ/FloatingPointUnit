#!/bin/bash
set -e

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_ROOT"

WORK="$PROJECT_ROOT/work"
LIBRARY="work"
DEFINES="+define+ADD_SV+THREE2ADD_SV+ORTREE_SV+HDECJ_SV+LEADINGZERO_SV+CLS_SV"

PASS=0
FAIL=0

cleanup() {
    rm -rf "$WORK" transcript *.vstf *.wlf
}

# Clean and create work library
cleanup
vlib "$WORK"
vmap "$LIBRARY" "$WORK"

echo "=== Step 1: Compile guarded utility modules ==="
vlog -quiet -work "$LIBRARY" \
    utils/add.sv \
    utils/three2add.sv \
    utils/ortree.sv \
    utils/HDecJ.sv \
    components/unpacker/leadingzero.sv \
    components/unpacker/cls.sv

echo ""
echo "=== Step 2: Compile all sub-module components ==="
vlog -quiet -work "$LIBRARY" "$DEFINES" \
    components/adder/abs.sv \
    components/adder/alignment.sv \
    components/adder/exceptions.sv \
    components/adder/exp_sub.sv \
    components/adder/limit.sv \
    components/adder/lrs.sv \
    components/adder/sigadd.sv \
    components/adder/sign_select.sv \
    components/adder/spec.sv \
    components/adder/sticky.sv \
    components/adder/swap.sv \
    components/multiplier/div_logic.sv \
    components/multiplier/ftadd.sv \
    components/multiplier/ftaddrec.sv \
    components/multiplier/mul_logic.sv \
    components/multiplier/multree.sv \
    components/multiplier/multree_div.sv \
    components/multiplier/rom256X8.sv \
    components/multiplier/select_fd.sv \
    components/multiplier/sigfmd.sv \
    components/multiplier/signexpmd.sv \
    components/multiplier/specmd.sv \
    components/rounder/adjexp.sv \
    components/rounder/andtree.sv \
    components/rounder/expnorm.sv \
    components/rounder/exprnd.sv \
    components/rounder/flags.sv \
    components/rounder/mask.sv \
    components/rounder/normshift.sv \
    components/rounder/postnorm.sv \
    components/rounder/rept.sv \
    components/rounder/rndexpections.sv \
    components/rounder/roundingdecision.sv \
    components/rounder/shiftdist.sv \
    components/rounder/signormshift.sv \
    components/rounder/sigrnd.sv \
    components/rounder/specfprnd.sv \
    components/rounder/specselect.sv \
    components/unpacker/exceptions.sv \
    components/unpacker/exponent.sv \
    components/unpacker/HDec.sv \
    components/unpacker/nanselect.sv \
    components/unpacker/significant.sv \
    components/unpacker/unpacker.sv

echo ""
echo "=== Step 3: Compile master.sv ==="
vlog -quiet -work "$LIBRARY" master.sv

echo ""
echo "=== Step 4: Run test benches ==="

TOTAL_TBS=24
i=0

for tb in \
    normal/tb_add_32 normal/tb_add_64 normal/tb_sub_32 normal/tb_sub_64 \
    normal/tb_mul_32 normal/tb_mul_64 normal/tb_div_32 normal/tb_div_64 \
    normal/tb_master \
    edge/tb_add_32_edge edge/tb_add_64_edge edge/tb_sub_32_edge edge/tb_sub_64_edge \
    edge/tb_mul_32_edge edge/tb_mul_64_edge edge/tb_div_32_edge edge/tb_div_64_edge \
    denormal/tb_add_32_denormal denormal/tb_add_64_denormal \
    denormal/tb_sub_32_denormal denormal/tb_sub_64_denormal \
    denormal/tb_mul_32_denormal denormal/tb_mul_64_denormal \
    denormal/tb_div_32_denormal denormal/tb_div_64_denormal; do

    sv_file="test/${tb}.sv"
    mod_name="$(basename "$tb")"

    i=$((i + 1))
    echo ""
    echo "--- [$i/$TOTAL_TBS] Running $mod_name ---"

    if vlog -quiet -work "$LIBRARY" "$sv_file" 2>/dev/null && \
       vsim -c -work "$LIBRARY" "$mod_name" -do "run -all; quit" -quiet -suppress 8681,8683 2>/dev/null; then
        echo "--- $mod_name: PASS ---"
        PASS=$((PASS + 1))
    else
        echo "--- $mod_name: FAIL ---"
        FAIL=$((FAIL + 1))
    fi
done

echo ""
echo "========================================"
echo "  Results: $PASS passed, $FAIL failed   "
echo "========================================"


echo ""
echo "========================================"
echo "         Running Rust Tests             "
echo "========================================"

cd ieee754_test_suite && cargo nextest run

[ "$FAIL" -eq 0 ]
