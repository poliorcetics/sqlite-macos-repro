all: repro39 repro38 repro-fossil-with-bug repro-fossil-no-bug

repro39: build/repro39
	./$^
	
repro38: build/repro38
	./$^
	
repro-fossil-with-bug: build/repro-fossil-with-bug
	./$^
	
repro-fossil-no-bug: build/repro-fossil-no-bug
	./$^

build/repro39: src/main.c sqlite-source/sqlite3.39.2/sqlite3.c
	mkdir -p build
	clang $^ -std=c11 -Isqlite-source/sqlite3.39.2 -o $@

build/repro38: src/main.c sqlite-source/sqlite3.38.5/sqlite3.c
	mkdir -p build
	clang $^ -std=c11 -Isqlite-source/sqlite3.38.5 -o $@

build/repro-fossil-with-bug: src/main.c sqlite-source/fossil-d55273e36e312336b8fc77dc771657d3b2c3437fbbd79f3be37701982560d634/sqlite3.c
	mkdir -p build
	clang $^ -std=c11 -Isqlite-source/fossil-d55273e36e312336b8fc77dc771657d3b2c3437fbbd79f3be37701982560d634 -o $@

build/repro-fossil-no-bug: src/main.c sqlite-source/fossil-764b71267e0b31ff7eaf2a0def7526a1a02dce4d5b456dea060d97ed342efdd1/sqlite3.c
	mkdir -p build
	clang $^ -std=c11 -Isqlite-source/fossil-764b71267e0b31ff7eaf2a0def7526a1a02dce4d5b456dea060d97ed342efdd1 -o $@

clean:
	rm -rf build
