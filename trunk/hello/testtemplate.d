/++
 + module to test template mechanics.
 +/
module testtemplate;

import std.stdio;

/++
 + Compile-time factorial.
 + Example:
 +--------------------------------------
 + const int y = 10;
 + int x = factorial!(y);
 +--------------------------------------
 +/
template factorial(int x)
{
	const factorial = x * factorial!(x-1);
}

/// ditto
template factorial(int x : 1)
{
	const factorial = 1;
}

unittest
{
	writefln("UnitTest: testtemplate");
	const int y = 10;
	auto x = factorial!(y);
}

static assert(factorial!(1) == 1);
static assert(factorial!(2) == 2);
static assert(factorial!(3) == 6);
static assert(factorial!(4) == 24);
static assert(factorial!(5) == 120);
