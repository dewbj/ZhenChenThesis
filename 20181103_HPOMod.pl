# use diagnostics;
# use strict;

my $import = 'C:/Users/dewbj/.Neo4jDesktop/neo4jDatabases/database-00bf3035-556e-44e6-aec2-d324a90669bf/installation-3.4.8/import';
my ($file, $output);

print "\nPlease select the input file:\n\n\t1.hpo.obo\n\t2.doid.obo\n\t3.go.obo\n\nMy Choice is:";

chomp(my $choice = <STDIN>);

my @obo = ('hp.obo','doid.obo','go.obo');
my %hash = map {$_ => $_} @obo;

if (exists $hash{$obo[$choice-1]}){
	$file = "$import/$obo[$choice-1]";
	$output = ">$import/$obo[$choice-1].json";
}
else {die;}

my (@hpo, @map, $switch, $i);

open INFILE, $file;

while (my $line = <INFILE>){
	
	# $line =~ s/[^[:ascii:]]+//g;
	# $line =~ s/[\x80-\xFF]//g;
	$line =~ s/\[url\:.+\]//g;
	$line =~ s/\{\w+\=.+\}//g;
	$line =~ s/\t//g;
	
	if ($line =~ /^\[Term\]/){
		$switch = 1;
	}
	elsif ($line =~ /^\n/ and @map != ()){
		$switch = 0;
		
		my (@alt_id, @synonym, @xref, @is_a, @property_value, @subset, @consider, @relationship, @intersection_of, @disjoint_from, $value);

		foreach my $pro (@map){
			
			# $pro =~ s/\{.+\}//;
			# $pro =~ s/\[.+\]//;
			# $pro =~ s/\"(.+)\"/$1/;
			
			if ($pro =~ /^(created_by|creation_date|property_value|comment)/){
				$pro = '';
			}
			# elsif ($pro =~ /^(comment):\s(.+)/){
				# $pro = "\"$1\":\"$2\",\n";
			# }			
			elsif ($pro =~ /^\n/){
				chomp;
			}
			elsif ($pro =~ /^(def):\s(".+").*/){
				$pro = "\"$1\":$2,\n";
			}
			elsif ($pro =~ /^(synonym):\s(".+?").*/){
				if (@synonym == ()){
					push @synonym, "\"$1\":\[";
				}
				$pro = '';
				$value = "$2,";
				push (@synonym, $value);
			}
			elsif ($pro =~ /^(is_a):\s(\w+:\d+)\s.+/){
				if (@is_a == ()){
					push @is_a, "\"$1\":\[";
				}
				$pro = '';
				$value = "\"$2\",";
				push (@is_a, $value);
			}
=pod
			# elsif ($pro =~ /^(alt_id):\s(.+)/){
				# my $array = \@$1;
				# $value = "\"$2\",";
				# if (@$array == ()){
					# push @alt_id, "\"$1\":\[";
				# }
				# $pro = '';
				# push (@alt_id, $value);
			# }
			# elsif ($pro =~ /^(alt_id|xref):\s(.+)/){
				# if (@$1 == ()){
					# push @$1, "\"$1\":\[";
				# }
				# $pro = '';
				# $value = "\"$2\",";
				# push (@$1, $value);
			# }
			elsif ($pro =~ /^(alt_id):\s(.+)/){
				if (@{$1} == ()){
					push @{$1}, "\"$1\":\[";
				}
				$pro = '';
				$value = "\"$2\",";
				push (@{$1}, $value);
			}
=cut
			elsif ($pro =~ /^(alt_id):\s(.+)/){
				if (@alt_id == ()){
					push @alt_id, "\"$1\":\[";
				}
				$pro = '';
				$value = "\"$2\",";
				push (@alt_id, $value);
			}
			elsif ($pro =~ /^(xref):\s(\S+)/){
				if (@xref == ()){
					push @xref, "\"$1\":\[";
				}
				$pro = '';
				$value = "\"$2\",";
				push (@xref, $value);
			}
			# elsif ($pro =~ /^(property_value):\s(.+)/){
				# if (@property_value == ()){
					# push @property_value, "\"$1\":\[";
				# }
				# $pro = '';
				# $value = "\"$2\",";
				# push (@property_value, $value);
			# }
			elsif ($pro =~ /^(subset):\s(.+)/){
				if (@subset == ()){
					push @subset, "\"$1\":\[";
				}
				$pro = '';
				$value = "\"$2\",";
				push (@subset, $value);
			}
			elsif ($pro =~ /^(consider):\s(.+)/){
				if (@consider == ()){
					push @consider, "\"$1\":\[";
				}
				$pro = '';
				$value = "\"$2\",";
				push (@consider, $value);
			}
			elsif ($pro =~ /^(relationship):\s(.+)/){
				if (@relationship == ()){
					push @relationship, "\"$1\":\[";
				}
				$pro = '';
				$value = "\"$2\",";
				push (@relationship, $value);
			}	
			elsif ($pro =~ /^(intersection_of):\s(.+)/){
				if (@intersection_of == ()){
					push @intersection_of, "\"$1\":\[";
				}
				$pro = '';
				$value = "\"$2\",";
				push (@intersection_of, $value);
			}	
			elsif ($pro =~ /^(disjoint_from):\s(\w+:\d+)\s.+/){
				if (@disjoint_from == ()){
					push @disjoint_from, "\"$1\":\[";
				}
				$pro = '';
				$value = "\"$2\",";
				push (@disjoint_from, $value);
			}			
			elsif ($pro =~ /(\w+):\s(.+)/){
				$pro = "\"$1\":\"$2\",\n";
			}
			# 1. push multi-line values to array @key
			# 2. set the line $pro as ''
			# 3. push $key:[@key] to array @map
		}
		$map[0] = "\{\n";
		my @list = (\@alt_id, \@synonym, \@xref, \@is_a, \@property_value, \@subset, \@consider, \@relationship, \@intersection_of, \@disjoint_from);
		foreach(@list){
			if (@$_ != ()){
				chop($$_[$#$_]);
				push @$_, "\],\n";
				push @map, join('',@$_);
			}
		}
		while ($map[$#map] !~ /^\"/){
			pop @map;
		}
		# $map[$#map] = substr($map[$#map],0,-2)."\n";
		$map[$#map] =~ s/,\n/\n/;
		push @map , "},\n";
		foreach my $j (0..$#map){
			$hpo[$i][$j] = $map[$j];
		}
		@map = ();
		$i += 1;
	}
	if ($switch == 1){
		push(@map, $line);
	}
}

close INFILE;

open OUTFILE, $output;

unshift @{$hpo[0]}, "\[\n";
$hpo[$#hpo][-1] = "\}\n";
push @{$hpo[$#hpo]}, "\]";

foreach (@hpo){
	print OUTFILE @$_;
}

close OUTFILE;
#
#	parse each [Term] sections, push them into an @map
#	add quotes: { } to each element in @map
#	remove properties: created_by, creation_date
#	remove redundant comments after values
#	add quotes: " " to keys and values if necessary
#	add comma: , in the end of each property value
#	add quotes: [ ] to first and last element in @map
#
