# SQLite bug reproducer

On macOS Monterey (12.4), with an Apple M1 Pro CPU, SQLite 3.39.x fails to create a database,
whereas 3.38.5 manages it.

SQLite forum thread: https://www.sqlite.org/forum/forumpost/61cd3aa835ff3315

- Version **without** the bug: [GitHub](https://github.com/sqlite/sqlite/commit/cc212e4450e5a3f38b88508f1e3d90045deb8fd1) / [Fossil](https://sqlite.org/src/info/764b71267e0b31ff7eaf2a0def7526a1a02dce4d5b456dea060d97ed342efdd1)
- Version **with** the bug: [GitHub](https://github.com/sqlite/sqlite/commit/6868bca6c5fae2c93f961313efc41f9330e8f8f2) / [Fossil](https://sqlite.org/src/info/d55273e36e312336b8fc77dc771657d3b2c3437fbbd79f3be37701982560d634)

## Observed results:

Clone the repository and run `make`. I used `clang` in the Makefile but you can replace it by
`gcc` and it should give the same results.

```text
mkdir -p build
clang src/main.c sqlite-source/sqlite3.39.2/sqlite3.c -std=c11 -Isqlite-source/sqlite3.39.2 -o build/repro39 -DSQLITE_OMIT_LOAD_EXTENSION
./build/repro39

SQLite version: 3.39.2
[FAIL] could not OPEN_CREATE database '/tmp/repro-sqlite-3.39.2.db3': 14

mkdir -p build
clang src/main.c sqlite-source/sqlite3.38.5/sqlite3.c -std=c11 -Isqlite-source/sqlite3.38.5 -o build/repro38 -DSQLITE_OMIT_LOAD_EXTENSION
./build/repro38

SQLite version: 3.38.5
[ OK ] managed to OPEN_CREATE database '/tmp/repro-sqlite-3.38.5.db3'
```

(line breaks inserted for clarity)
