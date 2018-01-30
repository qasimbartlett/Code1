
#!/bin/perl


print  "Idrees enter the  inmputs ";




print "Idfrees enter the Numbers =\n\n";

$In_Nums = <> ;

chop ($In_Nums) ;

@Nums = split (/\s+/,$In_Nums);


print "Idrees Sorted array = " &MergeSort(@Nums) ;


sub MergeSort
{

	local (@Array) = @_ ;

	local @Left  = ();
	local @Right = ();

	local $ArraySize = @Array ;	
	local $Mid       = int ($ArraySize/2) ;

	print "MergeSort::Array=@Array= size=$ArraySize= Mid=$Mid=\n\n";

	if ($ArraySize < 2) { return @Array ; }

	local $i=0;
	for ($i=0;    $i<$Mid;      $i++) { $Left [$i]      = $Array[$i]; }
	for ($i=$Mid; $i<$ArraySize;$i++) { $Right[$i-$Mid] = $Array[$i]; }


	@Left  = &MergeSort(@Left);
	@Right = &MergeSort(@Right) ;

	# Merge teh 2 arrays

	local $L=0;
	local $R=0;
	local $i=0;

	print "Idrees merging; L=@Left=  R=@Right= ArraySize=$ArraySize\n";
	for ($i=0;$i<$ArraySize;$i++) {

		print "Idrees Merging; i=$i; L=$L= R=$R= SOrted Array=@Array=\n";
		# Left pile is empty; take all from right pile & vice-versa; else compare top of both piles 
		if    ($L > $#Left)  { $Array[$i] = $Right[$R++]; }
		elsif ($R > $#Right) { $Array[$i] = $Left [$L++]; }

		else {
			# Pick the lesser of the 2 from the top of piles

			if ($Left[$L] < $Right[$R]) { $Array[$i] = $Left [$L++]; }
			else                        { $Array[$i] = $Right[$R++]; }
		}
	}

	print "Idrees Sorted Array is @Array\n";

	return @Array ;
	
}


