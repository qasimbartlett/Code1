#!/bin/perl


# Generate new word thats a concatenation of other words.
# Repeat 100K times


@AllWords = ();
$Orig_word_Count = 0 ;

# Read all words
while (<>) {

	$line = $_;
	chop ($line);
	if (length($line) > 2) { push (@AllWords,$line); }
}
$Orig_word_Count = 1+$#AllWords ; 


# Create New words
for ($i=0;$i< 200000;$i++) {
	&Generate_Concatenated_Word();
}






sub Generate_Concatenated_Word
{

	# Num of words to be concatenated
	$NumWords = 1 + int (rand (10)) ;
	# print "Generate_Concatenated_Word:: $NumWords=  $Orig_word_Count\n";
	
	for ($j=0;$j<$NumWords;$j++) {
		print "$AllWords[1 + rand($Orig_word_Count)]";
	}
	print "\n";


}



