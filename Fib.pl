

print "Idrees: Enter a number > 3\n";

$num = <> ;

chop ($num);

print "$num=\n";

$prev=0;     
$pre_prev=1 ;
print "$prev ";

for ($i=0;$i<$num-1;$i++) {

        $New = $prev + $pre_prev ;
	print "$New " ;

	$pre_prev = $prev;
        $prev = $New ;

}

