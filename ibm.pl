#!/bin/perl

%AllWords = () ;
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

}

sub All_SubStrings
{

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
	
	
	# in each iteration; remove the substring if it is found
	while ($SubStringFound) {
	
		$SubStringFound = '';
		
		foreach $keyx (reverse sort { length $a <=> length $b }  keys %AllWords) {
		
			# skip the substring thats the original string
			if ($keyx eq $AnotherCOpy) {  next ;}
			
			# if substring exists in the word; remove it from the word
			if ($BigWord =~ /$keyx/) { 
					$BigWord =~ s/$keyx// ;
					# print "     BigWord=$BigWord=      keyx=$keyx=\n";
					$SubStringFound =  " ";
					last ;
			}	
		}
	
	}
	
	# if the word length < 1; it means this word was made of substrings from the file
	if (length ($BigWord) < 1) { 
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