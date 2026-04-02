open Brr

let proj4 = Jv.get (Window.to_jv G.window) "proj4"

type ctx = unit

let ctx () = ()

module Transformation = struct
  type t = Jv.t 

  let normalize_for_visualization ?ctx:_ v = v
end

type area = unit

let crs_to_crs ?area:_ ?ctx:_ ~src dst =
  Jv.new' proj4 [| Jv.of_string src; Jv.of_string dst |]

module Coord = struct
  type t = Jv.t

  let make ~x ~y ~z ~t =
    let arr = Jv.Jarray.create 4 in
    Jv.Jarray.set arr 0 (Jv.of_float x);
    Jv.Jarray.set arr 1 (Jv.of_float y);
    Jv.Jarray.set arr 2 (Jv.of_float z);
    Jv.Jarray.set arr 3 (Jv.of_float t);
    Jv.call proj4 "toPoint" [| arr |] 

  let v jv =
    let x = Jv.Float.get jv "x" in
    let y = Jv.Float.get jv "y" in
    let z = Jv.Float.get jv "z" in
    let m = Jv.Float.get jv "m" in
    [| x; y; z; m |]

  let x jv = Jv.Float.get jv "x"
  let y jv = Jv.Float.get jv "y"
end

type direction = Forward | Inverse | Ident

let transform ?(direction=Forward) transform coord1 =
  let func = match direction with
    | Forward -> "forward"
    | Inverse -> "inverse"
    | Ident -> assert false
  in
  Jv.call transform func [| coord1 |]

