open Node
open Edge
open Graphics


let draw_edge edge node_list x_scale y_scale min_longitude min_latitude search =
  let start_node = find_node (get_uid_start_node edge) node_list in
  let end_node = find_node (get_uid_end_node edge) node_list in

  let x_s =
    int_of_float
      ((get_longitude start_node -. min_longitude) *. x_scale)
  in

  let y_s =
    int_of_float
      ((get_latitude start_node -. min_latitude) *. y_scale)
  in

  let x_e =
    int_of_float
      ((get_longitude end_node -. min_longitude) *. x_scale)
  in

  let y_e =
    int_of_float
      ((get_latitude end_node -. min_latitude) *. y_scale)
  in

  (* Couleur des routes *)
  if search <> "" && str_contains (get_name edge) search then
    set_color (rgb 255 0 150)
  else
    begin
      match get_nature edge with
      | "footway" ->
          set_color (rgb 50 255 120)

      | "motorway" ->
          set_color (rgb 255 50 50)

      | "primary" ->
          set_color (rgb 255 140 0)

      | "secondary" ->
          set_color (rgb 255 220 0)

      | "tertiary" ->
          set_color (rgb 190 80 255)

      | "residential" ->
          set_color (rgb 220 220 220)

      | "service" ->
          set_color (rgb 80 180 255)

      | _ ->
          set_color (rgb 100 140 255)
    end;

  moveto x_s y_s;
  lineto x_e y_e


let draw_edges node_list edge_list x_size y_size search =
  let min_longitude = get_min_longitude node_list in
  let max_longitude = get_max_longitude node_list in
  let min_latitude = get_min_latitude node_list in
  let max_latitude = get_max_latitude node_list in

  let x_scale =
    (float_of_int x_size) /. (max_longitude -. min_longitude)
  in

  let y_scale =
    (float_of_int y_size) /. (max_latitude -. min_latitude)
  in

  List.iter
    (fun edge ->
      draw_edge
        edge
        node_list
        x_scale
        y_scale
        min_longitude
        min_latitude
        search)
    edge_list


let open_map city node_list edge_list search =
  let x_size = 1000 in
  let y_size = 700 in

  open_graph " 1000x700";
  resize_window x_size y_size;
  set_window_title ("Carte de " ^ city);

  (* Fond noir *)
  set_color (rgb 5 5 5);
  fill_rect 0 0 x_size y_size;

  (* Dessin des routes *)
  draw_edges node_list edge_list x_size y_size search;

  ignore (wait_next_event [Key_pressed]);

  close_graph ()


let () =
  if Array.length Sys.argv < 2 then
    Printf.eprintf
      "Il faut utiliser : %s <city> [name]\n"
      Sys.argv.(0)
  else
    let city = Sys.argv.(1) in

    let search =
      if Array.length Sys.argv >= 3 then
        Sys.argv.(2)
      else
        ""
    in

    let node_list = load_node_list city in
    let edge_list = load_edge_list city in

    open_map city node_list edge_list search
