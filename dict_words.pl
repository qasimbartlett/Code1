

#!/bin/perl

$InLine = "WhosewoodstheseareIthinkIknow.Hishouseisinthevillagethough;HewillnotseemestoppinghereTowatchhiswoodsfillupwithsnow.MylittlehorsemustthinkitqueerTostopwithoutafarmhousenearBetweenthewoodsandfrozenlakeThedarkesteveningoftheyear.";




open(DATA, "<dictionary.txt") or die "Couldn't open file dictionary.txt, $!";

while(<DATA>){
	$line = $_ ;
	chop ($line) ;
    print ("$line=\n");
   
   push(@Dict,$line) ;
}



close (DATA);

foreach $word (@Dict) {
		print "=$word=   ";
		$InLine =~ s/$word/ $word /g ;
}

print "=\n\n\n$InLine=\n\n" ;

