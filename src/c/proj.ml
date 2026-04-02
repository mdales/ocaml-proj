open Ctypes 

module Types = C.Functions.T
module Funs = C.Functions

type ctx = Types.context structure ptr

let null_ctx = Ctypes.coerce (ptr void) (ptr Types.pj_ctx) null 

let ctx = Funs.proj_context_create 

module Transformation = struct 
  type t = Types.obj structure ptr

  let normalize_for_visualization ?(ctx=null_ctx) t =
    Funs.proj_normalize_for_visualization ctx t
end

type area = Types.area structure ptr

let check_and_raise_error ctx =
  let res = Funs.proj_context_errno ctx in
  let s = Funs.proj_context_errno_string ctx res in
  failwith s

let finalize_proj_objects o =
  Gc.finalise (fun obj ->
    ignore (Funs.proj_destroy obj)) o;
  o

module Coord = struct
  type t = Types.coord union

  let make ~x ~y ~z ~t =
    Funs.proj_coord x y z t

  let v coord = Types.v coord |> CArray.to_list |> Array.of_list 

  let x coord = Array.get (v coord) 0
  let y coord = Array.get (v coord) 1
end

let crs_to_crs ?area ?(ctx=null_ctx) ~src tgt =
  let area = match area with Some area -> area | None -> Ctypes.coerce (ptr void) (ptr Types.pj_area) null in
  let crs = Funs.proj_create_crs_to_crs ctx src tgt area in
  if Ctypes.is_null crs then check_and_raise_error ctx
  else
    finalize_proj_objects crs

type direction = Types.direction = Forward | Inverse | Ident

let transform ?(direction=Types.Forward) t c =
  Funs.proj_trans t direction c
