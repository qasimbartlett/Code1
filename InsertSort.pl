#!/bin/perl


print  "Idrees enter the  inmputs ";




print "Idfrees enter the Numbers =\n\n";

$In_Nums = <> ;

chop ($In_Nums) ;

@Nums = split (/\s+/,$In_Nums);




foreach ($i=1;$i<$#Nums+1;$i++) {


	$PulledIndex=$i;

	$PulledCardValue = $Nums[$PulledIndex] ;



	$j=$PulledIndex-1;
	while ($j>=0) {

		# print "Idrees j=$j=   PulledIndex=$PulledIndex;  PulledVal=$PulledCardValue=\n";

		if ($Nums[$j] > $PulledCardValue) { $Nums[$j+1]=$Nums[$j]; $j-- ; }
		else {  last ; }
	}

	 $Nums[$j+1] = $PulledCardValue ;
	# print "Idrees sorted=@Nums=\n\n";


}



print "\n\n\n\n";
print "Idrees sorted=@Nums=\n\n";

