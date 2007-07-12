/++
 + Memory managment test module.
 +/
module mem;

import std.stdio;

class A
{
	public:
	this(char[] name = "noname") {
		_name = name;
		writefln("A.this(%s)", _name);
	}
	~this() {
		writefln("A.~this(%s)", _name);
	}
	char[] toString() {
		return _name;
	}
	int opCmp(A other) {
		if(_name > other._name) {
			return 1;
		} else if(_name < other._name) {
			return -1;
		} else {
			return 0;
		}
	}
	private	char[] _name;
}

class B : public A {
	public:
	this(char[] name = "noname") {
		super(name);
		writefln("B.this(%s)", this._name);
	}
	~this() {
		writefln("B.~this(%s)", this._name);
	}
	char[] toString() {
		return "B::" ~ super.toString();
	}
}

unittest
{
	scope A foo = new A;
	writefln("foo=%s", foo);
	auto bar = new A("bar");
	auto lum = new B("lum");
	writefln("%s wins", bar > lum ? bar : lum);
}
