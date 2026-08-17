type edge =
  { uid_start_node : int;
    uid_end_node : int;
    name : string;
    nature : string;
    speed_limit : int;   (* -1 si non applicable *)
    one_way : bool
  }

let get_uid_start_node edge =
  edge.uid_start_node

let get_uid_end_node edge =
  edge.uid_end_node

let get_name edge =
  edge.name

let get_nature edge =
  edge.nature

let get_speed_limit edge =
  edge.speed_limit

let get_one_way edge =
  edge.one_way

let read_edge_file city =
  try
    let channel = open_in city in
    try
      while true do
        let line = input_line channel in
        Printf.printf "%s" line
      done
    with
    |End_of_file -> close_in channel
  with
  |Sys_error err -> Printf.eprintf "%s" err



let edge_of_line line =
  Scanf.sscanf line "{ %d, %d, %S, %S, %d, %B }"
    (fun uid_start_node uid_end_node name nature speed_limit one_way ->
      {
        uid_start_node;
        uid_end_node;
        name;
        nature;
        speed_limit;
        one_way
      })

let print_edge edge =
  let speed =
    if get_speed_limit edge = -1 then "N/A"
    else Printf.sprintf "%d km/h" (get_speed_limit edge)
  in
  Printf.printf "#%d->#%d %s=%s,%s,%b\n"
    (get_uid_start_node edge) (get_uid_end_node edge)
    (get_name edge) (get_nature edge) speed (get_one_way edge)



let print_edge_list el =
  List.iter (fun edge -> print_edge edge) el



let rec load_edge_list city =
  let filename = "city_maps/" ^ city ^ "_edges.txt" in
  try
    let channel = open_in filename in
    let rec aux el =
      try
        let line = input_line channel in
        let edge = edge_of_line line in
        aux (edge :: el)
      with
      |End_of_file -> close_in channel;el
    in
    List.rev (aux [])
  with
  |Sys_error err -> Printf.eprintf "%s\n" err;[]

let str_contains str sub =
  let str = String.lowercase_ascii str in
  let sub = String.lowercase_ascii sub in
  let str_length = String.length str in
  let sub_length = String.length sub in

  if str_length = 0 || sub_length = 0 || str_length < sub_length then
    false
  else
    let rec check i =
      if i + sub_length > str_length then
        false
      else if String.sub str i sub_length = sub then
        true
      else
        check (i + 1)
    in
    check 0


let find_edges name edge_list =
  let lower_name = String.lowercase_ascii name in
  let rec aux edge_list new_list =
    match edge_list with
    | [] -> new_list
    | h :: t ->
        if str_contains (get_name h) lower_name then
          h :: aux t (h :: new_list)
        else
          aux t new_list
  in
  aux edge_list []
