/++
 + Module to test associative-arrays.
 +/
module aa;

import std.boxer;
import std.stdio;
import std.format;
import std.string;

char[] toString(V,K)(V[K] aa) {
	char[] retval;
	retval ~= "[";
	bit first = true;
	foreach(key, value; aa) {
		if(first) {
			first = false;
		} else {
			retval ~=  ", ";
		}
		retval ~= std.string.toString(key) ~ ":" ~ std.string.toString(value);
	}
	retval ~= "]";
	return retval;
}

unittest {
	int[char[]] a;
	assert(a.length == 0);
	a["one"] = 1;
	assert(a.length == 1);
	a["two"] = 2;
	assert(a.length == 2);
	assert("[two:2, one:1]" == toString!(int,char[])(a));
	a.remove("one");
	assert(a.length == 1);
	a.remove("two");
	assert(a.length == 0);
	char[][int] b;
	assert(b.length == 0);
	b[1] = "one";
	assert(b.length == 1);
	b[2] = "two";
	assert(b.length == 2);
	assert("[1:one, 2:two]" == toString!(char[],int)(b));
	b.remove(1);
	assert(b.length == 1);
	b.remove(2);
	assert(b.length == 0);
}
