/++
 + module to test class mechanics.
 +/
module testclass;

import std.stdio;

/++
 + Sample class to test class mechanics.
 +/
class Test1
{
	static
	{
		/++
		 + Number of instances of this class.
		 +/
		int count()
		{
			return _count;
		}
		/++
		 + Default name of instances of this class, if none supplied in the constructor.
		 +/
		const auto DEFAULT_NAME = "NoName";
	}

	/++
	 + Constructor. Second sentence. Third sentence.
	 +
	 + First sentence of the second paragraph. And then the second.
	 +
	 + Params: name = name of this object
	 +
	 + See_Also: DEFAULT_NAME
	 +/
	this(char[] name = DEFAULT_NAME)
	{
		++_count;
		_name = name;
	}

	/++
	 + Destructor.
	 +/
	~this()
	{
		_count--;
	}

	/++
	 + Name of this object.
	 +/
	char[] name() { return _name; }

	/// ditto
	char[] name(char[] newVal) { return _name = newVal; }

private:
	static int _count; // counter of number of current instances
	char[] _name;

	unittest
	{
		assert(count == 0);
		// this one gets GC'd in the very end
		Test1 t1 = new Test1("t1");
		assert(count == 1);
		// this one gets deleted at the end of this block
		{
			scope auto t2 = new Test1("t2");
			assert(count == 2); // t2 is alive
		}
		assert(count == 1); // t2 is deleted
		t1.name = "t1a";
		assert(count == 1); // t1 is still alive
	}
	unittest {
		auto x = new Test1();
		assert(x.name == DEFAULT_NAME);
	}
}
