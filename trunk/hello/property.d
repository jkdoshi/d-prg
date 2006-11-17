module property;

import std.stdio;
import std.boxer;

static this() {
	writefln("module entry property");
}

static ~this() {
	writefln("module exit property");
}

interface IProperty {
	Box val(Box newVal);
	//void initialize(IProperty[char[]] table);
}

/++
 + Template that, when used as mixin, can be used to create a mapped property.
 + Params: T = type of the property value
 +         _name = string name of the property
 +/
class Property(T, char[] _name) : IProperty {
	char[] name;
	this(T val, out IProperty[char[]] table) {
		_val = box(val);
		name = _name.dup;
		writefln("name=%s", name);
		table[name] = this;
		assert(name == "name" || name == "age");
		writefln("len=%s", table.length);
	}
	/// Value of the property
	T val() { return unbox!(T)(_val); }
	/// ditto
	Box val(Box newVal) { return _val = newVal; }
	/+
	override void initialize(IProperty[char[]] table) {
		table[_name] = this;
		writefln("%s", table);
	}
	+/
private:
	Box _val;
}

unittest {
	class PropTest {
		Property!(char[], "name") name;
		Property!(int, "age") age;
		this() {
			writefln("len=%s", table.length);
			name = new Property!(char[], "name")("MyName", table);
			age = new Property!(int, "age")(22, table);
			writefln("len=%s", table.length);
			writefln("%s", table);
		}
	private:
		IProperty[char[]] table;
	}
	PropTest pt = new PropTest();
}

/++
 + This is added just to satisfy the linker against the bug in phobos.
 +/
private extern (C) void assert_3std5boxer() {}
