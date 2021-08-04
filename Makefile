.PHONY: install prebuild clean

install:
	sudo apt update
	
	sudo apt-get install libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev
	sudo apt-get install libsdl2-image-dev
	sudo apt-get install libsdl2-ttf-dev
	sudo apt-get install libsdl-gfx1.2-dev

	make build -C src/c_src
	make install -C src/c_src
	idris2 --install src/idrisGL.ipkg

withoutSDL:
	make build -C src/c_src
	make install -C src/c_src
	idris2 --install src/idrisGL.ipkg

prebuild:
	make build -C src/c_src

clean:
	make clean -C src/c_src
	idris2 --clean src/idrisGL.ipkg