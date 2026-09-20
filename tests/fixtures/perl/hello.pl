package Hello::World;
use strict;
use warnings;

sub hello {
    my ($name) = @_;
    return "Hello, $name!";
}

print hello("world"), "\n";
