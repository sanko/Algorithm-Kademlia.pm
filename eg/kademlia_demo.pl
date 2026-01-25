use v5.40;
use Net::Kademlia::RoutingTable;

my $local_id = pack("H*", "00" x 32);
my $rt = Net::Kademlia::RoutingTable->new(local_id_bin => $local_id);

# Fill with some dummy peers
for (1..50) {
    my $pid = pack("C*", map { int(rand(256)) } 1..32);
    $rt->add_peer($pid, { index => $_ });
}

my $target = pack("H*", "ff" x 32);
my $closest = $rt->find_closest($target, 3);

say "Top 3 closest peers to FF...:";
foreach my $p (@$closest) {
    say " - ID: " . unpack("H*", $p->{id}) . " (Peer #$p->{data}{index})";
}

