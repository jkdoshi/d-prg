import std.stdio;

import testclass;
import testtemplate;
import property;
import aa;
//import boxing;

static this() {
	writefln("module entry hello");
}

static ~this() {
	writefln("module exit hello");
}

void main()
{
	writefln("main");
}

/++
 + This is added just to satisfy the linker against the bug in phobos.
 +/
private extern (C) void assert_3std5boxer() {}
