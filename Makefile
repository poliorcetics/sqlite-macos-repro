all: repro39 repro38

repro39: build/repro39
	./$^
	
repro38: build/repro38
	./$^

build/repro39: src/main.c sqlite-source/sqlite3.39.2/sqlite3.c
	mkdir -p build
	clang $^ -std=c11 -Isqlite-source/sqlite3.39.2 -o $@

build/repro38: src/main.c sqlite-source/sqlite3.38.5/sqlite3.c
	mkdir -p build
	clang $^ -std=c11 -Isqlite-source/sqlite3.38.5 -o $@

clean:
	rm -rf build
