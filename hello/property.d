module property;

import std.stdio;
import std.boxer;

static this() {
	writefln("module entry property");
}

static ~this() {
	writefln("module exit property");
}

char[] strme(X)(X x) {
	if(is(X == interface)) {
		return (cast(Object)x).toString();
	} else if(is(X : Object)) {
		return x.toString();
	} else {
		return std.string.toString(x);
	}
}

char[] strme(V,K)(V[K] aa) {
	char[] retval;
	retval ~= "[";
	bit first = true;
	foreach(key, value; aa) {
		if(first) {
			first = false;
		} else {
			retval ~=  ", ";
		}
		retval ~= strme!(K)(key) ~ ":" ~ strme!(V)(value);
	}
	retval ~= "]";
	return retval;
}

interface IProperty {
	Box box();
	Box box(Box newVal);
	// I have no idea why this param has to be "inout"
	void reg(inout IProperty[char[]] table);
}

class Property(T) : IProperty {
	this(char[] name, T val) {
		_box = std.boxer.box(val);
		_name = name;
	}
	/// Value of the property
	T val() { return unbox!(T)(_box); }
	T val(T newVal) { _box = std.boxer.box(newVal); return newVal; }
	/// ditto
	override Box box() { return _box; }
	override Box box(Box newVal) { return _box = newVal; }
	override void reg(inout IProperty[char[]] table) {
		table[_name] = this;
	}
private:
	Box _box;
	char[] _name;
}

char[] toString(V,K)(V[K] aa) {
}

unittest {
	class PropTest {
		Property!(char[]) name;
		Property!(int) age;
		Property!(char) sex;
		this(char[] name, int age, char sex) {
			writefln("len=%s", table.length);
			//mixin prop!(char[], "name", "MyName", table) name;
			//mixin prop!(int, "age", 22/*, table*/) age;
			//table["name"] = this.name = new Property!(char[])("name", name);
			//table["age"] = this.age = new Property!(int)("age", age);
			this.name = new Property!(char[])("name", name); this.name.reg(table);
			this.age = new Property!(int)("age", age); this.age.reg(table);
			this.sex = new Property!(char)("sex", sex); this.sex.reg(table);
			writefln("len=%s", table.length);
		}
		char[] toString() {
			//return "name:" ~ name.box.toString ~ ", age:" ~ age.box.toString;
			char[] retval;
			retval ~= "[";
			bit first = true;
			foreach(key, value; table) {
				if(first) {
					first = false;
				} else {
					retval ~=  ", ";
				}
				retval ~= key ~ ":" ~ value.box.toString;
			}
			retval ~= "]";
			return retval;
		}
	private:
		IProperty[char[]] table;
	}
	PropTest p1 = new PropTest("Bob", 75, 'M');
	writefln("p1=%s", p1);
	PropTest p2 = new PropTest("Bob", 75, 'M');
	writefln("p1=%s", p1);
}
