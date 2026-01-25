use v5.40;
use Test2::V0;
use Net::Kademlia::Utils qw(xor_distance xor_bucket_index);

subtest 'XOR Distance' => sub {
    my $id1 = pack("H*", "00" x 32);
    my $id2 = pack("H*", "01" . ("00" x 31));
    my $dist = xor_distance($id1, $id2);
    is(unpack("H*", $dist), "01" . ("00" x 31), "Distance correct");
};

subtest 'Bucket Index' => sub {
    my $id1 = pack("H*", "00" x 32);
    # First bit differs (MSB)
    my $id2 = pack("H*", "80" . ("00" x 31));
    is(xor_bucket_index($id1, $id2), 0, "Bucket 0 for MSB diff");
    
    # 8th bit differs
    my $id3 = pack("H*", "01" . ("00" x 31));
    is(xor_bucket_index($id1, $id3), 7, "Bucket 7 for last bit of first byte");
};

done_testing;

