(* -------------------------------------------------------------------- *)
module E = Engine

(* -------------------------------------------------------------------- *)
let main () =
  let _ast = E.Io.from_channel ~name:"<stdin>" stdin in
  ()

(* -------------------------------------------------------------------- *)
let () = main ()
