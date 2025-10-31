(*---------------------------------------------------------------------------
   Copyright (c) 2024 The ocaml-proj programmers. All rights reserved.
   SPDX-License-Identifier: ISC
  ---------------------------------------------------------------------------*)
type ctx 

val ctx : unit -> ctx 
(** Create a new PROJ context. Note that unless multiple threads are
    involved, you shouldn't need to pass in this context. *)

module Transformation : sig
  type t
  (** A transformation object *)

  val normalize_for_visualization : ?ctx:ctx -> t -> t
  (** This will change the given {! t} into one whose axis order is the one
      expected for visualization purposes. *)
end

type area
(** A Proj area *)

val crs_to_crs : ?area:area -> ?ctx:ctx -> src:string -> string -> Transformation.t
(** Create a transformation object from [src] to [tgt] *)

module Coord : sig
  type t
  (** A proj coordinate object *)

  val make : x:float -> y:float -> z:float -> t:float -> t 
  (** Make a new coordinate using [xyzt] *)

  val v : t -> float Ctypes.carray
  (** The values of the coordinate as a Ctypes array *)

  val x : t -> float
  (** [x t] is [CArray.get (v t) 0] *)

  val y : t -> float
  (** [y t] is [CArray.get (v t) 1] *)
end

type direction = Forward | Inverse | Ident
(** The direction to apply a {! transform} *)

val transform : ?direction:direction -> Transformation.t -> Coord.t -> Coord.t
(** [transform ?direction trans c] uses [trans] to transform [c]. You can optionally
    use the [direction] argument to invert the transformation. *)
