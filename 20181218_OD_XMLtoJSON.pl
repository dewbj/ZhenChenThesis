# use Encode;
# use Encode::Encoder;

my $input = '<C:\Users\dewbj\.Neo4jDesktop\neo4jDatabases\database-00bf3035-556e-44e6-aec2-d324a90669bf\installation-3.4.8\import\en_product4_HPO.xml';
# my $input = 'C:\Users\dewbj\.Neo4jDesktop\neo4jDatabases\database-00bf3035-556e-44e6-aec2-d324a90669bf\installation-3.4.8\import\test.xml';
my $output = '>C:\Users\dewbj\.Neo4jDesktop\neo4jDatabases\database-00bf3035-556e-44e6-aec2-d324a90669bf\installation-3.4.8\import\en_product4_HPO.json';

# $input = Encode::encode("UTF-8",Encode:decode("Latin1",$input));
# $input = decode("iso-8859-1",$input);
# $input = encode("utf-8",decode("iso-8859-1",$input));
# $output = encode("iso-8859-1",decode("utf-8",$input));

# print `chcp 28591`;

# open my $in, '<:encoding(latin1)', $input;
open INFILE, $input;

my (@disorderId, @orphaId, @disorderName, @hpoId, @hpoTerm, @freqID, @freqName, @hpoIds, @hpoTerms, @freqIDs, @freqNames, @maps);
my $n = 0;

# while (my $line = <$in>) {
while (my $line = <INFILE>) {
	my %chr = ("\xC0", "A", "\xC1", "A", "\xC2", "A", "\xC3", "A", "\xC4", "A", "\xC5", "A", 
			   "\xE0", "a", "\xE1", "a", "\xE2", "a", "\xE3", "a", "\xE4", "a", "\xE5", "a", 
			   "\xE7", "c", 
			   "\xE8", "e", "\xE9", "e", 
			   "\xEC", "i", "\xED", "i", "\xEE", "i", "\xEF", "i", 
			   "\xF2", "o", "\xF3", "o", "\xF4", "o", "\xF5", "o", "\xF6", "o", 
			   "\xFC", "u");
	foreach (keys %chr){
		$line =~ s/$_/$chr{$_}/g;
	}
	if ($line =~ /^\s{4}\<Disorder id\=\"(\d+)\"\>/){
		push @disorderId, $1;
	}
	elsif ($line =~ /^\s{6}\<OrphaNumber\>(\d+)/){
		push @orphaId, $1;
	}
	elsif ($line =~ /^\s{6}\<Name lang\=\"en\"\>(.+)\<\/Name\>/){
		push @disorderName, $1;
	}
	elsif ($line =~ /^\s{12}\<HPOId\>(HP:\d+)\<\/HPOId\>/){
		push @hpoId, $1;
	}
	elsif ($line =~ /^\s{12}\<HPOTerm\>(.+)\<\/HPOTerm\>/){
		# push @hpoTerm, encode("utf-8",decode("iso-8859-1",$1));
		push @hpoTerm, $1;
	}
	# elsif ($line =~ /^\s{12}\<OrphaNumber\>(\d+)\<\/OrphaNumber\>/){
		# push @freqId, $1;
	# }
	elsif ($line =~ /^\s{12}\<Name lang\=\"en\"\>(.+)\<\/Name\>/){
		push @freqName, $1;
	}
	elsif ($line =~ /^\s{4}\<\/Disorder\>/){
		for (0..$#hpoId){
			$hpoIds[$n][$_] = "\"".$hpoId[$_]."\",";
			$hpoTerms[$n][$_] = "\"".$hpoTerm[$_]."\",";
			# $freqIds[$n][$_] = "\"".$freqId[$_]."\",";
			$freqNames[$n][$_] = "\"".$freqName[$_]."\",";
		}
		unshift @{$hpoIds[$n]}, "\[";
		chop $hpoIds[$n][-1];
		push @{$hpoIds[$n]}, "\],";

		unshift @{$hpoTerms[$n]}, "\[";
		chop $hpoTerms[$n][-1];
		push @{$hpoTerms[$n]}, "\],";

		# unshift @{$freqIds[$n]}, "\[";
		# chop $freqIds[$n][-1];
		# push @{$freqIds[$n]}, "\],";

		unshift @{$freqNames[$n]}, "\[";
		chop $freqNames[$n][-1];
		push @{$freqNames[$n]}, "\]";		
		$n++;
		(@hpoId, @hpoTerm, @freqId, @freqName) = ((),(),(),());
	}	
}

# close $in;
close INFILE;

=pod:output testing

# for (0..$#orphaId){
	# print $disorderId[$_]."\t".$orphaId[$_]."\t".$disorderName[$_]."\n";
# }

# print scalar(@disorderId)."\t".scalar(@orphaId)."\t".scalar(@disorderName);

# for (0..$#hpoId){
	# print "\t".$hpoId[$_]."\t".$hpoTerm[$_]."\t".$freqId[$_]."\t".$freqName[$_]."\n";
# }

# print "\n".scalar(@hpoId)."\t".scalar(@hpoTerm)."\t".scalar(@freqId)."\t".scalar(@freqName)."\n";

=cut

for my $n (0..$#disorderId){
	my @disorder;
	push @disorder, "\t\{\n";
	push @disorder, "\t\t"."\"DisorderID\":"."\"$disorderId[$n]\","."\n";
	push @disorder, "\t\t"."\"OrphaID\":"."\"$orphaId[$n]\","."\n";
	push @disorder, "\t\t"."\"DisorderName\":"."\"$disorderName[$n]\","."\n";
	push @disorder, "\t\t"."\"HPO_ID\":".join('',@{$hpoIds[$n]})."\n";
	push @disorder, "\t\t"."\"HPO_Term\":".join('',@{$hpoTerms[$n]})."\n";
	push @disorder, "\t\t"."\"Frequency\":".join('',@{$freqNames[$n]})."\n";
	push @disorder, "\t\},\n";
	$maps[$n] = join('',@disorder);
}

$maps[-1] =~ s/\},\n$/\}\n/;
# print $maps[-1];

# open my $out, '>:encoding(UTF-8)', $output;
open OUTFILE, $output;

# print $out "\[\n";
print OUTFILE "\[\n";

for (@maps){
	# print $out $_;
	print OUTFILE $_;
}

# for my $i (0..$#hpoIds){
	# for (@{$hpoIds[$i]}){
		# print $_;
	# }
	# print "\n";
# }
# print $out "\]";
print OUTFILE "\]";

# close $out;
close OUTFILE;

# for (@{$hpoIds[0]}){
# for my $i (0..$#hpoIds){
	# for (@{$hpoIds[$i]}){
		# print $_."\n";
	# }
	# print "\n";
# }
# for (@{$hpoIds[1]}){
	# print $_."\n";
# }
# print @{$hpoIds[0]};

# use XML::Simple;

# my $data = XMLin($input);
# push @array, $data->{Disorder}{OrphaNumber};
# print $array[0];