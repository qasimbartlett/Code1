#!/bin/perl

# Find out common numbers and different numbers

@ArrayX = (1,2,3,4,5,6,7,8,9);
@ArrayY = (3,1,33,14,6,44,2,45);

%Union = ();

# Common

print "Idrees arrayyx=@ArrayX=\n";
print "Idrees arrayyx=@ArrayY=\n";


foreach $i (@ArrayX){$Union{$i}++; }
foreach $i (@ArrayY){$Union{$i}++; }

foreach $key (keys %Union) {
	if ($Union{$key} > 1) { print "Idrees this element is key=$key= commpon=$Union{$key}=\n";}
	# print "Idrees this element is commpon=$Union{$key}=\n";
}