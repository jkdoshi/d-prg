module tango_thread;

import tango.io.Stdout;
import tango.core.Thread;

class Worker : Thread {
    public:
    this(char[] name) {
        super(&run);
        _name = name;
    }
    private:
    char[] _name;
    void run() {
        for(int i = 0; i < 10; i++) {
            Stdout(i)(":")(_name).newline();
            Thread.sleep(1);
        }
    }
}

void main(char[][] args)
{
    auto t1 = new Worker("t1");
    auto t2 = new Worker("t2");
    t1.start();
    t2.start();
    t1.join();
    t2.join();
}
