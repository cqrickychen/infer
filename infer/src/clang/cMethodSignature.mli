(*
 * Copyright (c) 2013 - present Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *)

open! IStd

(** Define the signature of a method consisting of its name, its arguments, return type, location
   and whether its an instance method. *)

type t =
  { name: Typ.Procname.t
  ; access: Clang_ast_t.access_specifier
  ; args: (Mangled.t * Clang_ast_t.qual_type) list
  ; ret_type: Clang_ast_t.qual_type
  ; attributes: Clang_ast_t.attribute list
  ; loc: Clang_ast_t.source_range
  ; method_kind: ProcAttributes.clang_method_kind
  ; is_cpp_virtual: bool
  ; is_cpp_nothrow: bool
  ; lang: CFrontend_config.clang_lang
  ; pointer_to_parent: Clang_ast_t.pointer option
  ; pointer_to_property_opt: Clang_ast_t.pointer option
  ; (* If set then method is a getter/setter *)
    return_param_typ: Typ.t option }

val is_getter : t -> bool

val is_setter : t -> bool

val mk :
  Typ.Procname.t -> (Mangled.t * Clang_ast_t.qual_type) list -> Clang_ast_t.qual_type
  -> Clang_ast_t.attribute list -> Clang_ast_t.source_range -> ProcAttributes.clang_method_kind
  -> ?is_cpp_virtual:bool -> ?is_cpp_nothrow:bool -> CFrontend_config.clang_lang
  -> Clang_ast_t.pointer option -> Clang_ast_t.pointer option -> Typ.t option
  -> Clang_ast_t.access_specifier -> t

val pp : Format.formatter -> t -> unit
