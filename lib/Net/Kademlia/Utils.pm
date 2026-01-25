use v5.40;
package Net::Kademlia::Utils;

use Exporter 'import';
our @EXPORT_OK = qw(xor_distance xor_bucket_index);

sub xor_distance ($id1_bin, $id2_bin) {
    # Using string bitwise XOR operator
    return $id1_bin ^. $id2_bin;
}

sub xor_bucket_index ($id1_bin, $id2_bin) {
    my $dist = $id1_bin ^. $id2_bin;
    my @bytes = unpack("C*", $dist);
    
    for (my $i = 0; $i < @bytes; $i++) {
        next if $bytes[$i] == 0;
        my $byte = $bytes[$i];
        # Find highest bit set in this byte
        for (my $j = 7; $j >= 0; $j--) {
            if ($byte & (1 << $j)) {
                # Kademlia bucket index is usually 0 for the furthest 
                # or closest. Standard is: index = bit position of MSB diff.
                return ($i * 8) + (7 - $j);
            }
        }
    }
    return 255;
}

1;

__END__

=pod

=head1 NAME

Net::Kademlia::Utils - XOR-distance and bit manipulation utilities

=head1 SYNOPSIS

    use Net::Kademlia::Utils qw(xor_distance xor_bucket_index);

    my $d = xor_distance($id1, $id2);
    my $idx = xor_bucket_index($id1, $id2);

=head1 DESCRIPTION

Provides the core bitwise logic for the Kademlia XOR metric.

=head1 FUNCTIONS

=head2 xor_distance($id1, $id2)

Returns the bitwise XOR of two binary strings.

=head2 xor_bucket_index($id1, $id2)

Calculates the index of the k-bucket (0-255) that $id2 would fall into 
relative to $id1.

=cut

