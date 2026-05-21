(lang dune 3.19)
(using ctypes 0.3)

(name proj)

(generate_opam_files true)

(source
 (github geocaml/ocaml-proj))

(authors "Patrick Ferris <patrick@sirref.org>")

(maintainers "Patrick Ferris <patrick@sirref.org>")

(license ISC)

(package
 (name proj)
 (synopsis "Bindings to PROJ4")
 (description "C OCaml bindings to the geospatial projection library PROJ4")
 (depends
   ocaml
   ctypes
   (alcotest :with-test)
 )
 (tags
  ("org:geocaml" "geospatial" "projections")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
