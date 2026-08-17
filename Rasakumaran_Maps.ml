open Node
open Edge

let () = 
  if Array.length Sys.argv = 2 then
    let city = Sys.argv.(1) in
    Printf.printf "Le nom de la ville est : %s" city
  else
    Printf.eprintf "Il faut utiliser : %s <city >\n" Sys.argv .(0)
