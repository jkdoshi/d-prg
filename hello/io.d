/++
 + Module to test IO.
 +/
module io;

import std.stdio;
import std.file; // filesystem-related

unittest {
  int i = 0;

  auto dir = getcwd();
  writefln("cwd=", dir);
  auto files = listdir(dir);
  writefln("number of files=", files.length);
  foreach(idx, file; files) {
    writefln(idx+1, ": name=", file, ", size=", getSize(file));
  }
  listdir(dir, delegate bool(DirEntry *de) {
    writefln(i++, ": name=", de.name, ", size=", de.size);
    return 1;
  });
}
