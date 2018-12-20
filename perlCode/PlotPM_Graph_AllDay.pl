#!/bin/perl


# Usage:  PlotPM_Graph_AllDay.pl    file_name.csv   Pattern 


# looks into the /tmp/JUNK directtory for files

use lib 'ChartDirector/lib';

use perlchartdir;



use GD::Graph::lines;
use GD::Graph::bars;
use GD::Graph::area;
use CGI qw(:standard);

use Image::Magick;


%New_Plottingdata = () ;
@Plotting_data = ([],[]) ; 
@legend = ();
@min =  ('00', '05', 10, 15, 20, 25, 30, 35, 40, 45, 50, 55,'00') ;



$hr=-1;
$FileName = $ARGV[0]   ;
$PM_Title = $ARGV[1]   ;
$DestDir  = $ARGV[2]   ;
$DataFound='' ;





open FILE, "$FileName";
while (<FILE>) {

	$line = $_ ;	
	chop($line);
	



	# #######   CST hr=0   Date=20110602     PM File Date = 20110602   UTC hr = 05;
	if ($line =~ /CST/) { 
		# Plot the prvious values
		if ($DataFound) { &Plot_PM($title,$PM_Title) ;  }
		%New_Plottingdata = () ;  
		# %New_Plottingdata = {} ;  
		@Plotting_data = ([],[]) ;
		@legend=();
		$indx=0;
		@{$Plotting_data[$indx]} = @min;
		$indx++ ;
		$hr++;
		$title = $line; 
	}
	
	# RRCConnEstabAttSum,,,,9,9,16,9,9,6,12,11,12,
	else {
		($key,@val) = split(/,/,$line);
		@{$New_Plottingdata{$key}} = @val ;
		push(@legend,$key) ;
		@{$Plotting_data[$indx]}= @val ;
		$DataFound = " " ;
		$indx++;
	}


}
close (FILE) ;
if ($DataFound) { &Plot_PM($title,$PM_Title) ;  }


&Merge_PM_Plots($PM_Title);  ;









sub Merge_PM_Plots
{

        ($Pm_Name) = @_ ;


	print " starting Merge_PM_Plots. Pm_Name=$Pm_Name= \n";

   	my $image = Image::Magick->new;
   	my $montage = Image::Magick->new;

	@Files_to_Read = ();
	for ($i=0;$i<24;$i++) {
		# # RRCCon_10.png
		$FileName = $Pm_Name. "_$i" .".png";
		push(@Files_to_Read, $FileName);
	}

   	my $status = $image -> Read(@Files_to_Read);
	print STDERR $status;

	$out_file= "jpg:Allday_$Pm_Name" . '.jpg';

   	$montage = $image -> Montage(mode=>Concatenate, tile=>1);
   	$montage -> Write($out_file);

   	system("chmod 777 *.jpg; rm *.png; mv *.jpg $DestDir ");

	print " exiting Merge_PM_Plots \n";

}



sub Plot_PM
{


        ($title,$Pm_Name) = @_ ;

	# Find the y-axis units
        if    ($Pm_Name =~ /RRC_Conn/)                  { $y_labl="Active UE"; }
        elsif ($Pm_Name =~ /ThroughputD|ThroughputU/)   { $y_labl="Kbps"; }
        elsif ($Pm_Name =~ /ProcessorUsageBCU3/)        { $y_labl="%"; }
        elsif ($Pm_Name =~ /RRUPrbDlSum|RRUPrbUlSum/)   { $y_labl="% "; }
        elsif ($Pm_Name =~ /RRUPrbDlSum|RRUPrbUlSum/)   { $y_labl="% "; }
        elsif ($Pm_Name =~ /BHLKBytesDropped/)     	{ $y_labl="% "; }


	print " staring Plot_PM . title=$title= Pm_Name=$Pm_Name= \n";




#The data for the line chart
# my $data  = [50, 55, 47, 34, 42, 49, 63, 62, 73, 59, 56, 50 ];
# my $data2 = [150, 5, 57, 34, 42, 49, 63, 62, 73, 59, 56, 50 ];
@line_Colors = (0x000000, 0x53c613, 0xc61253, 0xA00404, 0x000088, 0x800080, 0xcc9966 );
#The labels for the line chart
# my $labels = ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"];
my $labels = ["05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "00"];


#Create a XYChart object of size 500 x 320 pixels, with a pale purpule
#(0xffccff) background, a black border, and 1 pixel 3D border effect.
my $c = new XYChart(800, 420, 0xffccff, 0x0, 1);

#Set the plotarea at (55, 45) and of size 420 x 210 pixels, with white
#background. Turn on both horizontal and vertical grid lines with light grey
#color (0xc0c0c0)
$c->setPlotArea(55, 45, 700, 350, 0xffffff, -1, -1, 0xc0c0c0, -1);

#Add a legend box at (55, 25) (top of the chart) with horizontal layout. Use 8
#pts Arial font. Set the background and border color to Transparent.
$c->addLegend(55, 45, 0, "", 8)->setBackground($perlchartdir::Transparent);

#Add a title box to the chart using 13 pts Times Bold Italic font. The text is
#white (0xffffff) on a purple (0x800080) background, with a 1 pixel 3D border.
$c->addTitle("$title $Pm_Name", "timesbi.ttf", 13, 0xffffff
    )->setBackground(0x800080, -1, 1);

#Add a title to the y axis
$c->yAxis()->setTitle($y_labl);

#Set the labels on the x axis. Rotate the font by 90 degrees.
# $c->xAxis()->setLabels($labels)->setFontAngle(90);
$c->xAxis()->setLabels($labels);

#Add a line layer to the chart
my $layer = $c->addLineLayer();

#Add the data to the line layer using light brown color (0xcc9966) with a 7
#pixel square symbol
foreach $key (keys %New_Plottingdata) {
	$layer->addDataSet($New_Plottingdata{$key}, pop(@line_Colors), "$key")->setDataSymbol( $perlchartdir::SquareSymbol, 5);
}

# $layer->addDataSet($data, 0xcc9966, "Server Utilization")->setDataSymbol( $perlchartdir::SquareSymbol, 5);
# $layer->addDataSet($data2, 0x800080, "Client util")->setDataSymbol( $perlchartdir::SquareSymbol, 5);




#Set the line width to 2 pixels
$layer->setLineWidth(2);

# RRCCon_10.png
$file_name = $Pm_Name . "_$hr" . '.png' ;

#output the chart
# $c->makeChart("trendline.png")
$c->makeChart($file_name) ;

        print " exiting Plot_PM \n";

}

