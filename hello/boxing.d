/++
 + Module to test boxing and unboxing.
 +/
import std.boxer;
import std.stdio;

unittest {
	Box bstr = box("hi");
	Box bint = box(5);
	writefln("bstr=%s", bstr);
	writefln("bint=%s", bint);
	auto i = unbox!(int)(bint);
	writefln("i=%s", i);
}
