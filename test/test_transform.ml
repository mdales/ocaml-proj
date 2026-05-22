let test_create_from_string () =
    ignore(Proj.Transformation.of_string ~src:"epsg:4326" "epsg:3006")


let test_create_from_string_invalid_src () =
    Alcotest.check_raises "Garbage wkt" (Failure "Invalid PROJ string syntax") (fun () ->
        let _ = Proj.Transformation.of_string ~src:"Hello, world!" "epsg:3006" in ()
    )


let test_create_from_string_invalid_target () =
    Alcotest.check_raises "Garbage wkt" (Failure "Invalid PROJ string syntax") (fun () ->
        let _ = Proj.Transformation.of_string ~src:"Hello, world!" "epsg:3006" in ()
    )

let test_create_from_crs () =
    let src = Proj.CRS.v "epsg:4326"
    and tgt = Proj.CRS.v "epsg:3006" in
    ignore (Proj.Transformation.of_crs ~src tgt)

let () =
    Alcotest.run " PROJ Transform tests"
    [
        ("Transformation object tests", [
        Alcotest.test_case "simple create from string" `Quick test_create_from_string;
        Alcotest.test_case "create from string but invalid src" `Quick test_create_from_string_invalid_src;
        Alcotest.test_case "create from string but invalid target" `Quick test_create_from_string_invalid_target;
        Alcotest.test_case "simple create from CRS.t" `Quick test_create_from_crs;
        ])
    ]
