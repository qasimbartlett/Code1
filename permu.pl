#1/bin/perl


# use strict ;

my $Str = "ABCD" ;
my $InStrx = $Str ;


my $Combo = " ";


sub Permu
{
	local ($InStr) = @_ ;
	local $i;
	local $x ;
	
	
	#  Clean InStr
	$InStr =~ s/ //g ;
	
	# print "Idrees Instr=$InStr= \n";
	
	
	if (length($InStr) ==1 ) { return ($InStr); }
	
	
	
	
	foreach ($i=0;$i< length($InStr); $i++) {
	
		my $temp = substr($InStr, $i, 1) ;
		substr($InStr, $i, 1, " ");
		
		
		# print "Idrees InStr=$InStr=\n";
		
		local (@Combos) = &Permu($InStr);
		foreach $x (@Combos) {
			print "$temp  $x \n";
		
		}
		
		
		
		
		substr($InStr, $i, 1, $temp);
		
		
	
	}


}


sub Perm_1
{

	local ($Pos) = @_;
	
	local $i ;
	local $len ;
	
	print "\n\n0. InStrx=$InStrx= pos=$Pos=\n";
	
	$len    = length ($InStrx);
	
	if  ($Pos == $len) { print "Permutation = $InStrx\n"; return ;}
	
	foreach ($i=$Pos;$i<$len; $i++) {
		
		local $temp_i, $temp_0 ;
		
		# swap ith entry at position 0
		
		$temp_i = substr ($InStrx,$i,  1);
		$temp_0 = substr ($InStrx,$Pos,1);
		
		
		substr ($InStrx,$i,   1,$temp_0);
		substr ($InStrx,$Pos, 1,$temp_i);
		print "1. i=$i= pos=$Pos= temp_i=$temp_i= temp_0=$temp_0= InStrx=$InStrx= pos=$Pos=\n";
		
		# Find permutations of the 1...N string
		&Perm_1($i+1) ;	
		
		
		# Swap back
		substr ($InStrx,$i,   1,$temp_i);
		print "2. i=$i= pos=$Pos= temp_i=$temp_i= temp_0=$temp_0= InStrx=$InStrx= pos=$Pos=\n";

		substr ($InStrx,$Pos, 1,$temp_0);
		print "3. i=$i= pos=$Pos= temp_i=$temp_i= temp_0=$temp_0= InStrx=$InStrx= pos=$Pos=\n";
		
	}



}


&Perm_1(0);
