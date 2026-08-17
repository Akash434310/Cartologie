type edge

val get_uid_start_node : edge -> int

val get_uid_end_node : edge -> int

val get_name : edge -> string

val get_nature : edge -> string

val get_speed_limit : edge -> int

val get_one_way : edge -> bool

val read_edge_file : string -> unit

val edge_of_line : string -> edge

val print_edge : edge -> unit

val print_edge_list : edge list -> unit

val load_edge_list : string -> edge list

val str_contains : string -> string -> bool

val find_edges : string -> edge list -> edge list
