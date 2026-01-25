use v5.40;
use Test2::V0;
use Net::Kademlia::RoutingTable;

my $local = pack("H*", "00" x 32);
my $rt = Net::Kademlia::RoutingTable->new(local_id_bin => $local);

subtest 'Add Peer' => sub {
    my $peer = pack("H*", "ff" . ("00" x 31));
    $rt->add_peer($peer, { name => 'Alice' });
    my $closest = $rt->find_closest($peer);
    is($closest->[0]{data}{name}, 'Alice', "Stored and retrieved peer");
};

done_testing;

