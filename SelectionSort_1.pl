

#!/bin/perl


@InArray = (70, 64 ,2 ,10, 25, 75, 69, 79, 22, 34);
@OutArray=();
$MAX_VAL = 99999 ;


print "Idrees InArray=@InArray=\n\n";


for ($i=0;$i<=$#InArray;$i++) {
	
	$MinIndex=0 ;

	print "Idrees OutArray=@OutArray=\n\n";
	for ($j=0;$j<=$#InArray;$j++) {
	
		if ($InArray[$j] < $InArray[$MinIndex]) { $MinIndex = $j;}
	
	}
	
	# Insert a big NUm
	
	$OutArray[$i] = $InArray[$MinIndex];
	$InArray[$MinIndex] = $MAX_VAL ;

}