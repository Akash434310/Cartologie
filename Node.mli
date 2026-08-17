type node

val get_uid : node -> int

val get_longitude : node -> float

val get_latitude : node -> float

val get_nature : node -> string

val read_node_file : string -> unit


val node_of_line : string -> node

val print_node : node -> unit

val print_node_list : node list -> unit

val load_node_list : string -> node list

val get_min_longitude : node list -> float

val get_max_longitude : node list -> float

val get_min_latitude : node list -> float

val get_max_latitude : node list -> float

val find_node : int -> node list -> node
