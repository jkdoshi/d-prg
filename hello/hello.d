import std.stdio;

import testclass;
import testtemplate;
import property;

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
