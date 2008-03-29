module winhello;

import std.c.windows.windows;

extern (C) void gc_init();
extern (C) void gc_term();
extern (C) void _minit();
extern (C) void _moduleCtor();
extern (C) void _moduleDtor();
extern (C) void _moduleUnitTests();

extern (Windows) int WinMain(
    HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPSTR lpCmdLine, // this is the ENTIRE commandline (un-tokenized)
    int nCmdShow)
{
    int result;
    gc_init(); // initialize garbage collector
    _minit(); // initialize module constructor table
    try
    {
        _moduleCtor(); // call module constructors
        _moduleUnitTests(); // run unit tests (optional)
        result = myWinMain(hInstance, hPrevInstance, lpCmdLine, nCmdShow);
        _moduleDtor(); // call module destructors
    }
    catch(Object e)
    {
        MessageBoxA(null, cast(char*)e.toString(), "Error", MB_OK | MB_ICONEXCLAMATION);
        result = 0; // failed
    }
    gc_term();
    return result;
}

int myWinMain(
    HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPSTR lpCmdLine,
    int nCmdShow)
{
    MessageBoxA(null, "Hello World!", lpCmdLine, MB_OK);
    return 1;
}
