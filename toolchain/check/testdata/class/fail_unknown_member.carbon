// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

class Class {
  var n: i32;
}

fn G(c: Class) -> i32 {
  // TODO: Mention the scope in which we looked for the name.
  // CHECK:STDERR: fail_unknown_member.carbon:[[@LINE+3]]:10: ERROR: Name `something` not found.
  // CHECK:STDERR:   return c.something;
  // CHECK:STDERR:          ^~~~~~~~~~~
  return c.something;
}

// CHECK:STDOUT: --- fail_unknown_member.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Class: type = class_type @Class [template]
// CHECK:STDOUT:   %.1: type = unbound_element_type Class, i32 [template]
// CHECK:STDOUT:   %.2: type = struct_type {.n: i32} [template]
// CHECK:STDOUT:   %.3: type = ptr_type {.n: i32} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Class = %Class.decl
// CHECK:STDOUT:     .G = %G
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Class.decl: type = class_decl @Class [template = constants.%Class] {}
// CHECK:STDOUT:   %G: <function> = fn_decl @G [template] {
// CHECK:STDOUT:     %Class.ref: type = name_ref Class, %Class.decl [template = constants.%Class]
// CHECK:STDOUT:     %c.loc11_6.1: Class = param c
// CHECK:STDOUT:     @G.%c: Class = bind_name c, %c.loc11_6.1
// CHECK:STDOUT:     %return.var: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Class {
// CHECK:STDOUT:   %.loc8: <unbound element of class Class> = field_decl n, element0 [template]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%Class
// CHECK:STDOUT:   .n = %.loc8
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G(%c: Class) -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %c.ref: Class = name_ref c, %c
// CHECK:STDOUT:   %something.ref: <error> = name_ref something, <error> [template = <error>]
// CHECK:STDOUT:   return <error>
// CHECK:STDOUT: }
// CHECK:STDOUT:
