// RUN: llvm-mc -filetype=obj -triple x86_64-pc-linux-gnu %s -o - | llvm-readobj -r -t | FileCheck %s

// Test that the relocations point to the correct symbols. We used to get the
// symbol index wrong for weakrefs when creating _GLOBAL_OFFSET_TABLE_.

	.weakref bar,foo
        call    zed@PLT
     call	bar

// CHECK:      Relocations [
// CHECK-NEXT:   Section ({{[0-9]+}}) {{[^ ]+}} {
// CHECK-NEXT:     0x1 R_X86_64_PLT32 zed 0xFFFFFFFFFFFFFFFC
// CHECK-NEXT:     0x6 R_X86_64_PC32 foo 0xFFFFFFFFFFFFFFFC
// CHECK-NEXT:   }
// CHECK-NEXT: ]

// CHECK:      Symbols [
// CHECK:        Symbol {
// CHECK:          Name: _GLOBAL_OFFSET_TABLE_ (9)
// CHECK-NEXT:     Value: 0x0
// CHECK-NEXT:     Size: 0
// CHECK-NEXT:     Binding: Global
// CHECK-NEXT:     Type: None
// CHECK-NEXT:     Other: 0
// CHECK-NEXT:     Section: Undefined (0x0)
// CHECK-NEXT:   }
// CHECK-NEXT:   Symbol {
// CHECK-NEXT:     Name: foo (1)
// CHECK-NEXT:     Value: 0x0
// CHECK-NEXT:     Size: 0
// CHECK-NEXT:     Binding: Weak
// CHECK-NEXT:     Type: None
// CHECK-NEXT:     Other: 0
// CHECK-NEXT:     Section: Undefined (0x0)
// CHECK-NEXT:   }
// CHECK-NEXT:   Symbol {
// CHECK-NEXT:     Name: zed (5)
// CHECK-NEXT:     Value: 0x0
// CHECK-NEXT:     Size: 0
// CHECK-NEXT:     Binding: Global
// CHECK-NEXT:     Type: None
// CHECK-NEXT:     Other: 0
// CHECK-NEXT:     Section: Undefined (0x0)
// CHECK-NEXT:   }
