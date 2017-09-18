enum Domain { Zero, Nonzero, Unknown };

Domain __zero_add( Domain a, Domain b ) {
    if ( a == Domain::Zero )
        return b;
    if ( b == Domain::Zero )
        return a;
    return Domain::Unknown;
}

Domain  __zero_lift( int i )  {
    if ( i == 0 )
        return Domain::Zero;
    else
        return Domain::Nonzero;
}
