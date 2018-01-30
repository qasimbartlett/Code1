#!/bin/perl


@Array = (2,4,6,8,10,12,14,16);
$Pattern = 18 ;
$Start=0;
$End=$#Array;


$Pos=&Exists($Start, $End) ;

print "Idrees Position of =$Pattern= is =$Pos=\n";

sub Exists
{
	local ($StartIndex, $EndIndex) = @_;
	if ($StartIndex <= $EndIndex) { 

		local $mid_index = int (($StartIndex + $EndIndex ) / 2) ;
		local $mid_value = $Array[$mid_index] ;

		print "Exists: StartIndex=$StartIndex= EndIndex=$EndIndex= Pattern=$Pattern= midIndex=$mid_index= mid_val=$mid_value=\n";		
		if    ($Pattern == $mid_value){ return $mid_index; }
		elsif ($Pattern < $mid_value) { &Exists ($StartIndex,$mid_index-1) ; }
		else                          { &Exists ($mid_index+1,$EndIndex); }
	}

}

 
