#!/bin/perl


#print  "Idrees enter the  inmputs ";


$In_line = "Whose woods these are I think I know. His house is in the village though;  He will not see me stopping here    To watch his woods fill up with snow. My little horse must think it queer To stop without a farmhouse near    Between the woods and frozen lake    The darkest evening of the year.  ";

chop ($In_line) ;

# print "Idrees instr=$In_line\n";


@Nums = split (/\s+/,$In_line);


$MAX_STRING_SIZE=70 ;
$StrSize = 0 ;
$line = "" ;
foreach $Pat (@Nums) {
	
	$StrSize += length($Pat) ;
	if ($StrSize < $MAX_STRING_SIZE) {
		$line .= "$Pat " ;	
	}
	else {
		print "$line\n"; 
		$StrSize = length($Pat) ;
		$line = $Pat ;
	}
}


#die ;

