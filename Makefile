.PHONY: fromsrc clean

fromso:
	make install -C src/c_src
	idris2 --install src/idrisGL.ipkg

fromsrc:
	make build -C src/c_src
	make install -C src/c_src
	idris2 --install src/idrisGL.ipkg

prebuild:
	make build -C src/c_src

clean:
	make clean -C src/c_src
	idris2 --clean src/idrisGL.ipkg