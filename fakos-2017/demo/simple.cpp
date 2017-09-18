#include <assert.h>

#define __sym__ __attribute__((__annotate__("lart.abstract.sym")))

int main() {
    __sym__ int in;
    if ( in == 0 )
        return 0;
    assert( in != 0 );
}
