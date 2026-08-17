SRC := Rasakumaran_Maps
SRC2 := Rasakumaran_Maps2
SRC3 := Rasakumaran_Maps3

NODE := Node
EDGE := Edge

EXE := create_map


.PHONY: all clean


all: $(EXE)


$(EXE): $(NODE).cmx $(EDGE).cmx $(SRC3).cmx
	ocamlfind ocamlopt -linkpkg -package graphics -o $@ $^


$(SRC3).cmx: $(SRC3).ml $(NODE).cmi $(EDGE).cmi
	ocamlfind ocamlopt -package graphics -c $<


$(SRC2).cmx: $(SRC2).ml $(NODE).cmi $(EDGE).cmi
	ocamlfind ocamlopt -package graphics -c $<


$(SRC).cmx: $(SRC).ml $(NODE).cmi $(EDGE).cmi
	ocamlopt -c $<


$(NODE).cmx: $(NODE).ml $(NODE).cmi
	ocamlopt -c $<


$(NODE).cmi: $(NODE).mli
	ocamlopt -c $<


$(EDGE).cmx: $(EDGE).ml $(EDGE).cmi
	ocamlopt -c $<


$(EDGE).cmi: $(EDGE).mli
	ocamlopt -c $<


clean:
	rm -f *.cmi *.cmx *.o *.cmo $(EXE)
