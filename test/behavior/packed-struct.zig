const std = @import("std");
const builtin = @import("builtin");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const native_endian = builtin.cpu.arch.endian();

test "correct size of packed structs" {
    if (builtin.zig_backend == .stage2_llvm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_c) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_wasm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_arm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86_64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_aarch64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_riscv64) return error.SkipZigTest;

    const T1 = packed struct { one: u8, three: [3]u8 };

    try expectEqual(4, @sizeOf(T1));
    try expectEqual(4 * 8, @bitSizeOf(T1));

    const T2 = packed struct { three: [3]u8, one: u8 };

    try expectEqual(4, @sizeOf(T2));
    try expectEqual(4 * 8, @bitSizeOf(T2));

    const T3 = packed struct { _1: u1, x: u7, _: u24 };

    try expectEqual(4, @sizeOf(T3));
    try expectEqual(4 * 8, @bitSizeOf(T3));

    const T4 = packed struct { _1: u1, x: u7, _2: u8, _3: u16 };

    try expectEqual(4, @sizeOf(T4));
    try expectEqual(4 * 8, @bitSizeOf(T4));

    const T5 = packed struct { _1: u1, x: u7, _2: u16, _3: u8 };

    try expectEqual(4, @sizeOf(T5));
    try expectEqual(4 * 8, @bitSizeOf(T5));
}

test "flags in packed structs" {
    if (builtin.zig_backend == .stage2_llvm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_c) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_wasm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_arm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86_64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_aarch64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_riscv64) return error.SkipZigTest;

    const Flags1 = packed struct {
        // byte 0
        b0_0: u1,
        b0_1: u1,
        b0_2: u1,
        b0_3: u1,
        b0_4: u1,
        b0_5: u1,
        b0_6: u1,
        b0_7: u1,

        // partial byte 1 (but not 8 bits)
        b1_0: u1,
        b1_1: u1,
        b1_2: u1,
        b1_3: u1,
        b1_4: u1,
        b1_5: u1,
        b1_6: u1,

        // some padding to fill to size 3
        _: u9,
    };

    try expectEqual(3, @sizeOf(Flags1));
    try expectEqual(3 * 8, @bitSizeOf(Flags1));

    const Flags2 = packed struct {
        // byte 0
        b0_0: u1,
        b0_1: u1,
        b0_2: u1,
        b0_3: u1,
        b0_4: u1,
        b0_5: u1,
        b0_6: u1,
        b0_7: u1,

        // partial byte 1 (but not 8 bits)
        b1_0: u1,
        b1_1: u1,
        b1_2: u1,
        b1_3: u1,
        b1_4: u1,
        b1_5: u1,
        b1_6: u1,

        // some padding that should yield @sizeOf(Flags2) == 4
        _: u10,
    };

    try expectEqual(4, @sizeOf(Flags2));
    try expectEqual(8 + 7 + 10, @bitSizeOf(Flags2));

    const Flags3 = packed struct {
        // byte 0
        b0_0: u1,
        b0_1: u1,
        b0_2: u1,
        b0_3: u1,
        b0_4: u1,
        b0_5: u1,
        b0_6: u1,
        b0_7: u1,

        // byte 1
        b1_0: u1,
        b1_1: u1,
        b1_2: u1,
        b1_3: u1,
        b1_4: u1,
        b1_5: u1,
        b1_6: u1,
        b1_7: u1,

        // some padding that should yield @sizeOf(Flags2) == 4
        _: u16, // it works, if the padding is 8-based
    };

    try expectEqual(4, @sizeOf(Flags3));
    try expectEqual(4 * 8, @bitSizeOf(Flags3));
}

test "arrays in packed structs" {
    if (builtin.zig_backend == .stage2_llvm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_c) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_wasm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_arm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86_64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_aarch64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_riscv64) return error.SkipZigTest;

    const T1 = packed struct { array: [3][3]u8 };
    const T2 = packed struct { array: [9]u8 };

    try expectEqual(9, @sizeOf(T1));
    try expectEqual(9 * 8, @bitSizeOf(T1));
    try expectEqual(9, @sizeOf(T2));
    try expectEqual(9 * 8, @bitSizeOf(T2));
}

test "consistent size of packed structs" {
    if (builtin.zig_backend == .stage2_llvm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_c) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_wasm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_arm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86_64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_aarch64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_riscv64) return error.SkipZigTest;

    const TxData1 = packed struct { data: u8, _23: u23, full: bool = false };
    const TxData2 = packed struct { data: u9, _22: u22, full: bool = false };

    const register_size_bits = 32;
    const register_size_bytes = register_size_bits / 8;

    try expectEqual(register_size_bits, @bitSizeOf(TxData1));
    try expectEqual(register_size_bytes, @sizeOf(TxData1));

    try expectEqual(register_size_bits, @bitSizeOf(TxData2));
    try expectEqual(register_size_bytes, @sizeOf(TxData2));

    const TxData3 = packed struct { a: u32, b: [3]u8 };
    const TxData4 = packed struct { a: u32, b: u24 };
    const TxData5 = packed struct { a: [3]u8, b: u32 };
    const TxData6 = packed struct { a: u24, b: u32 };

    const expectedBitSize = 56;
    const expectedByteSize = expectedBitSize / 8;

    try expectEqual(expectedBitSize, @bitSizeOf(TxData3));
    try expectEqual(expectedByteSize, @sizeOf(TxData3));

    try expectEqual(expectedBitSize, @bitSizeOf(TxData4));
    try expectEqual(expectedByteSize, @sizeOf(TxData4));

    try expectEqual(expectedBitSize, @bitSizeOf(TxData5));
    try expectEqual(expectedByteSize, @sizeOf(TxData5));

    try expectEqual(expectedBitSize, @bitSizeOf(TxData6));
    try expectEqual(expectedByteSize, @sizeOf(TxData6));
}

test "correct sizeOf and offsets in packed structs" {
    if (builtin.zig_backend == .stage2_llvm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_c) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_wasm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_arm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86_64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_aarch64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_riscv64) return error.SkipZigTest;

    const PStruct = packed struct {
        bool_a: bool,
        bool_b: bool,
        bool_c: bool,
        bool_d: bool,
        bool_e: bool,
        bool_f: bool,
        u1_a: u1,
        bool_g: bool,
        u1_b: u1,
        u3_a: u3,
        u10_a: u10,
        u10_b: u10,
    };
    try expectEqual(0, @offsetOf(PStruct, "bool_a"));
    try expectEqual(0, @bitOffsetOf(PStruct, "bool_a"));
    try expectEqual(0, @offsetOf(PStruct, "bool_b"));
    try expectEqual(1, @bitOffsetOf(PStruct, "bool_b"));
    try expectEqual(0, @offsetOf(PStruct, "bool_c"));
    try expectEqual(2, @bitOffsetOf(PStruct, "bool_c"));
    try expectEqual(0, @offsetOf(PStruct, "bool_d"));
    try expectEqual(3, @bitOffsetOf(PStruct, "bool_d"));
    try expectEqual(0, @offsetOf(PStruct, "bool_e"));
    try expectEqual(4, @bitOffsetOf(PStruct, "bool_e"));
    try expectEqual(0, @offsetOf(PStruct, "bool_f"));
    try expectEqual(5, @bitOffsetOf(PStruct, "bool_f"));
    try expectEqual(0, @offsetOf(PStruct, "u1_a"));
    try expectEqual(6, @bitOffsetOf(PStruct, "u1_a"));
    try expectEqual(0, @offsetOf(PStruct, "bool_g"));
    try expectEqual(7, @bitOffsetOf(PStruct, "bool_g"));
    try expectEqual(1, @offsetOf(PStruct, "u1_b"));
    try expectEqual(8, @bitOffsetOf(PStruct, "u1_b"));
    try expectEqual(1, @offsetOf(PStruct, "u3_a"));
    try expectEqual(9, @bitOffsetOf(PStruct, "u3_a"));
    try expectEqual(1, @offsetOf(PStruct, "u10_a"));
    try expectEqual(12, @bitOffsetOf(PStruct, "u10_a"));
    try expectEqual(2, @offsetOf(PStruct, "u10_b"));
    try expectEqual(22, @bitOffsetOf(PStruct, "u10_b"));
    try expectEqual(4, @sizeOf(PStruct));

    if (native_endian == .Little) {
        const s1 = @bitCast(PStruct, @as(u32, 0x12345678));
        try expectEqual(false, s1.bool_a);
        try expectEqual(false, s1.bool_b);
        try expectEqual(false, s1.bool_c);
        try expectEqual(true, s1.bool_d);
        try expectEqual(true, s1.bool_e);
        try expectEqual(true, s1.bool_f);
        try expectEqual(@as(u1, 1), s1.u1_a);
        try expectEqual(false, s1.bool_g);
        try expectEqual(@as(u1, 0), s1.u1_b);
        try expectEqual(@as(u3, 3), s1.u3_a);
        try expectEqual(@as(u10, 0b1101000101), s1.u10_a);
        try expectEqual(@as(u10, 0b0001001000), s1.u10_b);

        const s2 = @bitCast(packed struct { x: u1, y: u7, z: u24 }, @as(u32, 0xd5c71ff4));
        try expectEqual(@as(u1, 0), s2.x);
        try expectEqual(@as(u7, 0b1111010), s2.y);
        try expectEqual(@as(u24, 0xd5c71f), s2.z);
    }

    const S = packed struct { a: u32, pad: [3]u32, b: u32 };

    try expectEqual(16, @offsetOf(S, "b"));
    try expectEqual(128, @bitOffsetOf(S, "b"));
    try expectEqual(20, @sizeOf(S));
}

test "nested packed structs" {
    if (builtin.zig_backend == .stage2_llvm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_c) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_wasm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_arm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86_64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_aarch64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_riscv64) return error.SkipZigTest;

    const S1 = packed struct { a: u8, b: u8, c: u8 };

    const S2 = packed struct { d: u8, e: u8, f: u8 };

    const S3 = packed struct { x: S1, y: S2 };
    const S3Padded = packed struct { s3: S3, pad: u16 };

    try expectEqual(48, @bitSizeOf(S3));
    try expectEqual(6, @sizeOf(S3));

    try expectEqual(3, @offsetOf(S3, "y"));
    try expectEqual(24, @bitOffsetOf(S3, "y"));

    if (native_endian == .Little) {
        const s3 = @bitCast(S3Padded, @as(u64, 0xe952d5c71ff4)).s3;
        try expectEqual(@as(u8, 0xf4), s3.x.a);
        try expectEqual(@as(u8, 0x1f), s3.x.b);
        try expectEqual(@as(u8, 0xc7), s3.x.c);
        try expectEqual(@as(u8, 0xd5), s3.y.d);
        try expectEqual(@as(u8, 0x52), s3.y.e);
        try expectEqual(@as(u8, 0xe9), s3.y.f);
    }

    const S4 = packed struct { a: i32, b: i8 };
    const S5 = packed struct { a: i32, b: i8, c: S4 };
    const S6 = packed struct { a: i32, b: S4, c: i8 };

    const expectedBitSize = 80;
    const expectedByteSize = expectedBitSize / 8;
    try expectEqual(expectedBitSize, @bitSizeOf(S5));
    try expectEqual(expectedByteSize, @sizeOf(S5));
    try expectEqual(expectedBitSize, @bitSizeOf(S6));
    try expectEqual(expectedByteSize, @sizeOf(S6));

    try expectEqual(5, @offsetOf(S5, "c"));
    try expectEqual(40, @bitOffsetOf(S5, "c"));
    try expectEqual(9, @offsetOf(S6, "c"));
    try expectEqual(72, @bitOffsetOf(S6, "c"));
}
