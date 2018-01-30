#!/bin/perl

%AllWords = () ;
%AllWords_Sorted = () ;
@AnswerWords = ();


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

	foreach $key (reverse sort { length $a <=> length $b }  keys %AllWords) {
		local $Word = $key ;
		local $FirstChar = substr($Word,0,1) ;
		
		
		
		push(@{$AllWords_Sorted{$FirstChar}},$key);
	}

	# Test code
	#foreach $i (@{$AllWords_Sorted{a}}) {
	#	print "Idrees =$i=\n";
	#}
	#die;
	
}


sub All_SubStrings
{
	
	
	# 97107  is correct
	foreach $key (reverse sort { length $a <=> length $b }  keys %AllWords) {
		$Word = $key ;
		&CanThisBeMadeOfOtherWords($Word);
	}

}



sub CanThisBeMadeOfOtherWords
{

	local ($BigWord) = @_;
	
	local $AnotherCOpy = $BigWord;
	local $SubStringFound = " ";
	local @Subwords = () ;
	
	# in each iteration; remove the substring if it is found
	while ($SubStringFound) {
	
		$SubStringFound = '';
		
		local $FirstXhar = substr($BigWord,0,1) ;
		
		foreach $wordx (@{$AllWords_Sorted{$FirstXhar}}) {
		
			# skip the substring thats the original string
			if ($wordx eq $AnotherCOpy) {  next ;}
			
			# If the BigWord is smaller than the substrings, no point in comparing
			if (length($BigWord) < length ($wordx)) { next ;}
			
			# if substring exists in the word; remove it from the word
			if ($BigWord =~ /$wordx/) { 
					$BigWord =~ s/$wordx// ;
					push (@Subwords,$wordx);
					# print "     BigWord=$BigWord=      keyx=$wordx=\n";
					$SubStringFound =  " ";
					last ;
			}	
		}
	
	}  # climactically
	# ethylenediaminetetraacetate
	# 012345678901234567890123456
	
	# if the word length < 1; it means this word was made of substrings from the file
	if (length ($BigWord) < 1) { 
		print "Idrees:: Found BigWord =$AnotherCOpy=  Subwords=@Subwords= \n";
		push (@AnswerWords,$AnotherCOpy);
	}

}



# Prints the answer words
sub Print_AnswerWords
{



	print ("1st Biggest word =$AnswerWords[0]=\n");
	print ("2nd Biggest word =$AnswerWords[1]=\n");
	
	local $ArrSize = @AnswerWords;
	print ("Total Words that can be build=$ArrSize= \n");

}