#! usr/bin/perl
print STDOUT "Enter a sequence of numbers to be sorted";
$Numbers = <>;
chop ($Numbers);
print "Hi: The Numbers are =$Numbers= \n\n";



@Nums = split(/\s+/, $Numbers);

for ($i=0;$i<=$#Nums;$i++) {

	# Bubble up;
	$Max_Array_Size = $#Nums +1 - $i ;
	# print "i=$i= Max_Array_size=$Max_Array_Size=  i=$i= tot=$#Nums=\n";
	&BubbleUp($Max_Array_Size) ;

}

print "Idrees sorted list is @Nums\n\n";



#Given an array of size N; make array[N-1] have the max

sub BubbleUp 
{

   local ($ArraySize) = @_;

    print "Idrees BubbleUp:: ArraySize=$ArraySize=\n";

    $PostnOfMax = $ArraySize-1;

    for ($k=0;$k<$ArraySize;$k++) {

	if ($Nums[$k] > $Nums[$PostnOfMax]) { 
		$temp = $Nums[$PostnOfMax] ;

		# Swap
		$Nums[$PostnOfMax] = $Nums[$k] ; 
		$Nums[$k] = $temp ;

	}



    }



}
