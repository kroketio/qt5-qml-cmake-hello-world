CMAKEFLAGS = \
	-DCMAKE_CXX_STANDARD=11 \
	-DCMAKE_VERBOSE_MAKEFILE=On \
	$(CMAKEFLAGS_EXTRA)

windows:
	mkdir -p build/$(target)/release
	cd build/$(target)/release && cmake -D STATIC=ON -DZLIB_ROOT=/usr/x86_64-w64-mingw32/ -D CMAKE_BUILD_TYPE=Release -D CMAKE_TOOLCHAIN_FILE=$(root)/$(target)/share/toolchain.cmake ../../.. && $(MAKE)
