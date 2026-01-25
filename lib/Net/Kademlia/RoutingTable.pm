use v5.40;
use feature 'class';
no warnings 'experimental::class';

class Net::Kademlia::RoutingTable;

use Net::Kademlia::Utils qw(xor_bucket_index);

field $local_id_bin :param;
field $k :param = 20;
field @buckets;

ADJUST {
    $buckets[$_] = [] for 0 .. 255;
}

method add_peer ($peer_id_bin, $peer_data) {
    my $idx = xor_bucket_index($local_id_bin, $peer_id_bin);
    return if $idx == 255;

    my $bucket = $buckets[$idx];
    @$bucket = grep { $_->{id} ne $peer_id_bin } @$bucket;
    
    if (scalar @$bucket < $k) {
        push @$bucket, { id => $peer_id_bin, data => $peer_data };
    }
}

method find_closest ($target_id_bin, $count = undef) {
    $count //= $k;
    my @all_peers;
    push @all_peers, @$_ for @buckets;
    
    my @sorted = sort { 
        ($a->{id} ^. $target_id_bin) cmp ($b->{id} ^. $target_id_bin) 
    } @all_peers;
    
    return [ splice(@sorted, 0, $count) ];
}

method size () {
    my $count = 0;
    $count += scalar @$_ for @buckets;
    return $count;
}

1;

__END__

=pod

=head1 NAME

Net::Kademlia::RoutingTable - K-Bucket management for peer routing

=head1 SYNOPSIS

    my $rt = Net::Kademlia::RoutingTable->new(local_id_bin => $my_id);
    $rt->add_peer($peer_id, $metadata);
    my $peers = $rt->find_closest($target_id);

=head1 DESCRIPTION

Implements the 256 k-bucket structure described in the Kademlia paper. 
Peers are bucketed by the index of the first bit that differs from the 
local node ID.

=head1 METHODS

=head2 add_peer($id, $data)

Adds a peer to the appropriate bucket. If the peer is already present, 
it is moved to the "most recently seen" position.

=head2 find_closest($target_id, $count)

Returns up to C<$count> peers closest to the target ID according to the 
XOR metric.

=cut

