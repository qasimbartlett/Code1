
#!/bin/perl



@Array = (0,6,3,8,3,56,3,82,84,12 ) ;


print "Idrees Uunsorted = @Array \n";

&QuickSort(0,$#Array, @Array);

print "Idrees    sorted = @Array \n";


sub QuickSort
{

	local ($Start, $End) = @_ ;

	print "\n\nQuickSort:: Start=$Start= End=$End= \n";

	if ($Start < $End ) {
		$Pindex = &Partition ($Start,$End) ;   
		&QuickSort($Start,   $Pindex - 1); 
		&QuickSort($Pindex+1,$End);
	}


}


sub  Partition
{

	local ($StartX, $EndX) = @_ ;

	# $PindexX= $StartX;
	$PindexX= 0 ;

	$Pivot = $Array[$EndX] ;

	print "Idrees Partition: Start=$StartX= End=$EndX= Pivot=$Pivot=   Pindex=$PindexX= \n";

	for ($i=0;$i<=$EndX-1;$i++) {

		if ($Array[$i] <= $Pivot) {  
			&swap($i,$PindexX) ; 
			$PindexX++;
		}
	}
	&swap($PindexX, $EndX) ; 
	print "Idrees Partition: Start=$StartX= End=$EndX= Arr=@Array=  Pindex=$PindexX=\n";


	return $PindexX ;

}




sub swap 
{


	local($Index1, $Index2) = @_;

	# print "Swap 0:: Index1=$Index1= Index2=$Index2= Arr=@ArrY=\n";	
	$temp = $Array[$Index1];
	$Array[$Index1] = $Array[$Index2];
 	$Array[$Index2] = $temp;




}



