type node =
  { uid : int;
    longitude : float;
    latitude : float;
    nature : string
  }


let get_uid node =
  node.uid

let get_longitude node =
  node.longitude

let get_latitude node =
  node.latitude

let get_nature node =
  node.nature

let read_node_file city =
  let filename = "city_maps/" ^ city ^ "_nodes.txt" in
  try
    let channel = open_in filename in
    try
      while true do
        let line = input_line channel in
        Printf.printf "%s" line
      done
    with
    |End_of_file -> close_in channel
  with
  |Sys_error err -> Printf.eprintf "%s" err


let node_of_line city =
  Scanf.sscanf city "{ %d, %f, %f, %S }" (fun uid longitude latitude nature -> {uid; longitude; latitude; nature})


let print_node node =
  Printf.printf "#%d = longitude : %f, latitude : %f, nature : %s\n" (
    get_uid node) ( get_longitude node) ( get_latitude node) ( get_nature node)

let print_node_list nl =
  List.iter (fun node -> print_node node )nl

let rec load_node_list city =
  let filename = "city_maps/" ^ city ^ "_nodes.txt" in
  try
    let channel = open_in filename in
    let rec aux nl =
      try
        let line = input_line channel in
        let node = node_of_line line in
        aux (node :: nl)
      with
      |End_of_file -> close_in channel; nl
    in
    List.rev (aux [])
  with
  |Sys_error err -> Printf.eprintf "%s\n" err; []


let get_min_longitude nl =
  match nl with
  | [] -> failwith "Liste vide"
  | n :: tl ->
      let rec aux acc = function
      | [] -> acc
      | n :: tl ->
          aux (min acc (get_longitude n)) tl
      in
      aux (get_longitude n) tl


let get_max_longitude nl =
  match nl with
  | [] -> failwith "Liste vide"
  | n :: tl ->
      let rec aux acc = function
      | [] -> acc
      | n :: tl ->
          aux (max acc (get_longitude n)) tl
      in
      aux (get_longitude n) tl


let get_min_latitude nl =
  match nl with
  | [] -> failwith "Liste vide"
  | n :: tl ->
      let rec aux acc = function
      | [] -> acc
      | n :: tl ->
          aux (min acc (get_latitude n)) tl
      in
      aux (get_latitude n) tl


let get_max_latitude nl =
  match nl with
  | [] -> failwith "Liste vide"
  | n :: tl ->
      let rec aux acc = function
      | [] -> acc
      | n :: tl ->
          aux (max acc (get_latitude n)) tl
      in
      aux (get_latitude n) tl

let print_limits city =
  let nl = load_node_list city in

  Printf.printf "Longitude : [%f ; %f]\n"
    (get_min_longitude nl)
    (get_max_longitude nl);

  Printf.printf "Latitude : [%f ; %f]\n"
    (get_min_latitude nl)
    (get_max_latitude nl)

let find_node node_uid node_list =
  let found_node = List. filter (fun node -> ( get_uid node) = node_uid )
      node_list in
  match found_node with
  | [] -> failwith "pas trouver"
  | [node] -> node
  | _ -> failwith "trop"
