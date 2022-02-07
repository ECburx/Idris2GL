.PHONY: install prebuild clean

quickInstall:
	sudo apt update
	sudo apt-get install libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl2-image-dev libsdl2-ttf-dev libsdl2-gfx-dev libsdl2-mixer-dev

	make build -C src/c_src
	make install -C src/c_src
	idris2 --install idrisGL.ipkg

install:
	make build -C src/c_src
	make install -C src/c_src
	idris2 --install idrisGL.ipkg

prebuild:
	make build -C src/c_src

clean:
	make clean -C src/c_src
	idris2 --clean idrisGL.ipkg