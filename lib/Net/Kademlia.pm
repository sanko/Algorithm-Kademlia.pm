use v5.40;
use feature 'class';
no warnings 'experimental::class';

class Net::Kademlia;

our $VERSION = '0.0.1';

use Net::Kademlia::Utils;
use Net::Kademlia::RoutingTable;

1;

__END__

=pod

=head1 NAME

Net::Kademlia - Pure Perl implementation of the Kademlia DHT algorithm

=head1 SYNOPSIS

    use Net::Kademlia::Utils qw(xor_distance);
    use Net::Kademlia::RoutingTable;

    my $local_id = pack("H*", "00" x 32); # 256-bit ID
    my $rt = Net::Kademlia::RoutingTable->new(local_id_bin => $local_id);

    # Add a peer
    my $peer_id = pack("H*", "ff" x 32);
    $rt->add_peer($peer_id, { addr => '127.0.0.1:4001' });

    # Find closest peers to a target
    my $target = pack("H*", "f0" x 32);
    my $closest = $rt->find_closest($target, 5);

=head1 DESCRIPTION

C<Net::Kademlia> provides the mathematical and structural foundations for a 
Kademlia Distributed Hash Table (DHT). It is designed to be protocol-agnostic, 
meaning it only handles the XOR-metric distance calculations and the k-bucket 
routing table logic.

This module is suitable for building BitTorrent-compatible DHTs, libp2p 
Kademlia implementations, or custom peer-to-peer storage systems.

=head1 COMPONENTS

=over 4

=item L<Net::Kademlia::RoutingTable>

The core data structure for tracking peers in k-buckets.

=item L<Net::Kademlia::Utils>

Low-level XOR distance and bit-manipulation utilities.

=back

=head1 SEE ALSO

L<InterPlanetary::Kademlia> (for the libp2p-specific protocol implementation)

=cut

