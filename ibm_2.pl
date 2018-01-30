#!/bin/perl

%AllWords = () ;
$Glo_Prefixes = "";
%Concatenated_Words = ();
$GloCount_ConcatWords = 0 ;

# Read teh input file and store it
&ReadFile_StoreWords();

# For each word find it is is made of other words 
&All_SubStrings() ;

# Print the Answer
&Print_AnswerWords();


# Read the test file containig all words. Store in an assosciative array.
# Duplicat words will get stored in same location
sub ReadFile_StoreWords
{

	while (<>) {
		$line = $_;
		chop ($line);
		if (length($line) > 0) { $AllWords{$line}++ ; }
	
	}

	# Test code
	# foreach $key (reverse sort { length $a <=> length $b }  keys %AllWords) {
	# print "Idrees key=$key=\n";
	#}

}


sub All_SubStrings
{
	
	# &CanThisBeMadeOfOtherWords("ethylenediaminetetraacetate");
	# die;
	
	foreach $key (reverse sort { length $a <=> length $b }  keys %AllWords) {

		$Word = $key ;
		# print "------------------------   All_SubStrings:: String=$Word=\n";
		$Glo_Prefixes = "";
		
		if (&CanThisBeMadeOfOtherWords($Word)) {
		
			# if made of 2 or more substrings there will be atleast 2 ;  in the Glo_Prefixes string 
			if ($Glo_Prefixes =~ /[a-z]*;[a-z]*;.*/) { 
				$Concatenated_Words{$Word} = $Glo_Prefixes; 
				$GloCount_ConcatWords++; 
			}
		}
	}
}



sub CanThisBeMadeOfOtherWords
{

	local ($BigWord) = @_;
	
	local $size = length($BigWord);
	local $i=0 ;

	# print "CanThisBeMadeOfOtherWords:: size=$size=  BigWord=$BigWord=\n";
	
	if ($size == 0)  { return 1 ; }
	
	for ($i=1;$i<=$size;$i++) {
		local $prefix = substr($BigWord, 0, $i) ;
		local $suffix = substr($BigWord, $i,$size-$i);
		# print "CanThisBeMadeOfOtherWords:: size=$size=  prefix=$prefix=  suffix=$suffix=  BigWord=$BigWord=\n";
		
		if ($AllWords{$prefix} && (&CanThisBeMadeOfOtherWords( $suffix))) {
			# Create a String that contains the substrings that can be concatenate to make the bigger string
			$Glo_Prefixes .= "$prefix;";
			return 1 ;
		}
	}

	return 0 ;
}



# Prints the answer words
sub Print_AnswerWords
{

   $Count = 0 ;

	
	print "Total Words that can be build=$GloCount_ConcatWords=\n";
	
	
	foreach $keyy (reverse sort { length $a <=> length $b } keys %Concatenated_Words) {
		
		print "$keyy   ===>   $Concatenated_Words{$keyy}=\n";
		
		$count++;
		if ($count > 2) { die ;}
	
	}

}