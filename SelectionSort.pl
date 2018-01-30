

print "Idfrees enter the Numbers =\n\n";

$In_Nums = <> ;

chop ($In_Nums) ;

@Nums = split (/\s+/,$In_Nums);

$Big_Num=9999;
$j=0 ;

foreach ($k=0;$k<$#Nums+1;$k++) {

	$LowestNumIndex=0;
	foreach ($i=0;$i<$#Nums+1;$i++) {

		if ($Nums[$i] < $Nums[$LowestNumIndex]) { $LowestNumIndex=$i; }

	}
	$SortedList[$j++] = $Nums[$LowestNumIndex] ;
	$Nums[$LowestNumIndex]=$Big_Num;
}



print "Idrees Sorted=@SortedList=\n\n";


