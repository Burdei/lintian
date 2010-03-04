# Copyright (C) 2009 Raphael Geissert <atomo64@gmail.com>
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 2 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.

package Lintian::PDepMap;

use strict;
use warnings;
use base 'Lintian::DepMap';

my ($properties);

=head1 NAME

Lintian::PDepMap - Dependencies with properties map/tree creator

=head1 SYNOPSIS

    use Lintian::PDepMap;

    my $map = Lintian::DepMap->new();


=head1 DESCRIPTION

Lintian::PDepMap is a simple layer between Lintian::DepMap and the
application allowing nodes to have application-defined properties.


=over 4

=item new()

Creates a new Lintian::PDepMap object and returns a reference to it.

=cut

sub new {
    my ($class, $pkg) = @_;
    my $self = {};
    bless($self, $class);
    return $self;
}

=item add(node, [dependencies], [ref to property])

Adds a node with possibly one or more dependencies and sets the C<node>'s
property to the ref, if defined.  The property must be a reference (it
can be to a hash, an array, a function, an object, etc) and must be the
last argument given to the method.

E.g.

    $map->add('foo', {name => 'John Doe', age => 20});

=cut
#'

sub add {
    my $self = shift;
    my $ref = pop;
    if (not defined $ref) {
	# do nothing if not defined
    } elsif (not ref($ref)) {
	push @_, $ref;
    } else {
	$self->{'properties'}->{$_[0]} = $ref;
    }
    return $self->SUPER::add(@_);
}

sub addp {
    my $self = shift;
    my $ref = pop;
    if (not defined $ref) {
	# do nothing if not defined
    } elsif (not ref($ref)) {
	push @_, $ref;
    } else {
	$self->{'properties'}->{$_[0]} = $ref;
    }
    return $self->SUPER::addp(@_);
}

=item getProp(node)

Returns the reference to the given C<node>'s properties.

E.g.

    # prints John Doe
    print $map->getProp('foo')->{'name'};
    # changes the value of 'name'
    $map->getProp('foo')->{'name'} = 'Jane Doe';
    # prints Jane Doe
    print $map->getProp('foo')->{'name'};

=cut
#'

sub getProp {
    my $self = shift;
    my $node = shift;
    return $self->{'properties'}->{$node};
}

1;

__END__

=back

=head1 AUTHOR

Originally written by Raphael Geissert <atomo64@gmail.com> for Lintian.

=cut