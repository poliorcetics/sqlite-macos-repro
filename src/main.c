#include <stdio.h>
#include <unistd.h>
#include "sqlite3.h"

// Changing this to use `build` instead of `/tmp` make it work
//
// Probably related: https://www.sqlite.org/releaselog/3_39_0.html
//
// > The unix os interface resolves all symbolic links in database filenames to create a canonical
//   name for the database before the file is opened.
#define DB_NAME ("/tmp/repro-sqlite-" SQLITE_VERSION ".db3")

int main() {
  printf("SQLite version: %s\n", SQLITE_VERSION);

  if (access(DB_NAME, F_OK) == 0) {
    printf("[INFO] File '%s' exists, removing\n", DB_NAME);
    if (remove(DB_NAME) == 0) {
      printf("[ OK ] File removed successfully\n");
    } else {
      printf("[FAIL] Removal failed\n");
    }
  }
  
  sqlite3 *db = 0;

  int open_result = sqlite3_open_v2(
    DB_NAME,
    &db,
    SQLITE_OPEN_READWRITE | SQLITE_OPEN_NOFOLLOW | SQLITE_OPEN_FULLMUTEX | SQLITE_OPEN_CREATE,
    NULL
  );

  if (open_result == 0) {
    printf("[ OK ] managed to OPEN_CREATE database '%s'\n", DB_NAME);
  } else {
    printf("[FAIL] could not OPEN_CREATE database '%s': %d\n", DB_NAME, open_result);
  }

  return 0;
}