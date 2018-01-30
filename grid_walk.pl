
$Dest_x = 4 ;
$Dest_y = 4;
$count = 0 ;
@Path = () ;

&Move(0,0);


sub PrintPath()
{

	print "Path = ";
	foreach $Seg (@Path) {
		print "$Seg " ;
	}
	print "\n\n";
	
}


sub Move ()
{

	local ($x, $y) = @_ ;
	
	push (@Path, "$x,$y ") ;
	
	if (($x < 0) || ($y < 0) || ($x > $Dest_x) || ($y > $Dest_y)) { return ; }

	# print "$x,$y   ";
		
	
	if (($x == $Dest_x) && ($y == $Dest_y)) {&PrintPath() ; return ;}
	
	
	
	
	&Move ($x+1, $y);
	pop(@Path) ;
	
	&Move ($x, $y+1);
	pop(@Path) ;
	
	&Move ($x+1, $y+1);
	pop(@Path) ;
	
	
}

