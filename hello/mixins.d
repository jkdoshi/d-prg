module mixins;

import std.stdio;

template X(T=int) {
	T x = 5;
}

class Student {
	public:
	char[] name() { return _name; }
	char[] name(char[] val) { writefln("setting name"); return _name = val; }
	int age() { return _age; }
	int age(int val) { return _age = val; }
	private:
	char[] _name;
	int _age;
}

class Persistent(T) : T {
	public:
	static this() {
		writefln("%s.this()", typeid(typeof(this)));
	}
	~this() {
		writefln("State: %s", _state);
	}
	private:
	enum State { TRANSIENT, CLEAN, DIRTY };
	State _state = State.TRANSIENT;
	void markDirty() {
		_state = State.DIRTY;
		writefln("%s: marking dirty", typeid(T));
	}
}

template PProperty(char[] propName, char[] T) {
	const char[] PProperty = T ~ " " ~ propName ~ "(" ~ T ~ " val) {
		markDirty();
		return super." ~ propName ~ "(val);
	}";
}

class PStudent : Persistent!(Student) {
	mixin(PProperty!("name", "char[]"));
	mixin(PProperty!("age", "int"));
}

/+
template WRAPPER(char[] returnType, char[] functionCall, delegate void pre(), delegate void post()) {
	const char[] WRAPPER = returnType ~ " " ~ functionCall
}
+/

void delegate() wrap(inout void delegate() target, inout void delegate() pre, inout void delegate() post) {
	auto _pre = pre;
	auto _post = post;
	auto _target = target;
	return delegate () {
		writefln("p1");
		_pre();
		writefln("p2");
		_target();
		writefln("p3");
		_post();
		writefln("p4");
	};
}

void wrapper(void delegate() target, void delegate() pre, void delegate() post) {
	pre();
	target();
	post();
}

unittest {
	wrapper({writefln("target");}, {writefln("pre");}, {writefln("post");});
}
