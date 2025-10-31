open Ctypes

module Functions (F : Ctypes.FOREIGN) = struct
  open F
  module T = Types_generated

  (* Errors *)
  let proj_context_errno = foreign "proj_context_errno" (ptr T.pj_ctx @-> returning int)
  let proj_context_errno_string = foreign "proj_context_errno_string" (ptr T.pj_ctx @-> int @-> returning string)

  (* Context *)
  let proj_context_create = foreign "proj_context_create" (void @-> returning @@ ptr T.pj_ctx)

  (* Objects *)
  let proj_destroy = foreign "proj_destroy" (ptr T.pj_obj @-> returning @@ ptr T.pj_obj) 
  let proj_create_crs_to_crs = foreign "proj_create_crs_to_crs" (ptr T.pj_ctx @-> string @-> string @-> ptr T.pj_area @-> returning @@ ptr T.pj_obj)
  let proj_coord = foreign "proj_coord" (float @-> float @-> float @-> float @-> returning T.pj_coord)
  let proj_trans = foreign "proj_trans" (ptr T.pj_obj @-> T.pj_direction @-> T.pj_coord @-> returning T.pj_coord) 
  let proj_normalize_for_visualization = foreign "proj_normalize_for_visualization" (ptr T.pj_ctx @-> ptr T.pj_obj @-> returning @@ ptr T.pj_obj)
end
