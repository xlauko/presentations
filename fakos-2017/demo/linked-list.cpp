#include <cassert>
#include <limits>
#include <array>

#define __sym__ __attribute__((__annotate__("lart.abstract.sym")))

struct Node {
    Node( int val ) : val( val ) {}

    int val;
    Node * next = nullptr;
};

template< typename Array >
struct List {
    List( Array & ns ) {
        for ( auto& n : ns ) {
            n.next = head;
            head = &n;
        }
    }

    Node * head = nullptr;

    Node * at( size_t i ) {
        return at_impl( head, i );
    }

    Node * at_impl( Node * node, size_t i ) {
        if ( i == 0 )
            return node;
        if ( node == nullptr )
            return nullptr;
        return at_impl( node->next, i - 1 );
    }
};

template< typename Array >
List< Array > make_list( Array & arr ) {
    return List< Array >( arr );
}

int main() {
    std::array< Node, 3 > ns = { 1, 2, 3 };
    auto list = make_list( ns ); // 3 -> 2 -> 1 -> nullptr

    assert( list.at( 0 )->val == 3 );

    __sym__ unsigned int i;
    auto n = list.at( i );

    assert( n == nullptr || ( n->val == 1 || n->val == 3 ) );
}
