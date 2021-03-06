(* This file is part of ppx_cstubs (https://github.com/fdopen/ppx_cstubs)
 * Copyright (c) 2018-2019 fdopen
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, with linking exception;
 * either version 2.1 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *)

type extract_info

val prologue : string

type extract_int =
  [ `Unchecked_U8
  | `Unchecked_U32
  | `Any_int
  | `Int_type of string
  ]

val prepare_extract_int :
  loc:Mparsetree.Ast_cur.Ast_helper.loc ->
  extract_int ->
  string ->
  extract_info * string * string

val prepare_extract_string :
  loc:Mparsetree.Ast_cur.Ast_helper.loc ->
  string ->
  extract_info * string * string

type obj

val compile : ebuf:Buffer.t -> string -> (obj, string) CCResult.t

type extract_error =
  | Info_not_found
  | Overflow of string
  | Underflow of string
  | Not_an_integer

val extract : extract_info -> obj -> (string, extract_error) CCResult.t
