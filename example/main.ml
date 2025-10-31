(* This example is from https://proj.org/en/stable/development/quickstart.html# *)
module Arr = Ctypes.CArray

let main () =
  let src = "EPSG:4326" in
  let tgt = "+proj=utm +zone=32 +datum=WGS84" in
  let crs = Proj.crs_to_crs ~src tgt |> Proj.Transformation.normalize_for_visualization in
  let copenhagen = Proj.Coord.make ~x:12. ~y:55. ~z:0. ~t:0. in
  let utm = Proj.transform crs copenhagen in
  let back = Proj.transform ~direction:Inverse crs utm in
  Printf.printf "Easting: %.3f, Northing: %.3f\n" (Proj.Coord.x utm) (Proj.Coord.y utm);
  Printf.printf "Longitude: %g, Latitude: %g\n" (Proj.Coord.x back) (Proj.Coord.y back)

  

let () = main ()

