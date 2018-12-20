#!/usr/bin/perl	

# This has a Tk GUI


# @INC = ("/root/pak/MoCall_trace") ;
#push @INC,"/root/pak/MoCall_trace";




use Socket;


$DEBUG = " ";

$MsgCount = 0 ;
$TraceRef="";


%ManagedElements = (
	"MME-1", 	"01 02 03 04",
	"Cell-1", 	"a5 a6 a7 a8",
	"HSS-1",        "b1 b2 b3 b4",
	"SGW-1",	"c1 c2 c3 c4",
	"UE-1",         "d1 d2 d3 d4"

);



%AllRecords_in_this_Interval = ();
%AllRecords= ();




# ================ ================ GUI Stuff ====== ================ ================ ================


use Tk ;
use Cwd ;

use Tk::Label;
use Tk::Scrollbar ;
use Tk::Button ; 
use Tk::Text;
use Tk::TiedListbox;











if ($#ARGV  < 2) { die "Usage SessionTrace SessiontraceID\n"; }

# SessionTrace  786786786

$SesiontraceID  = $ARGV[0] ;



$CurrentDirectory = cwd() ;
$CurrentDirectory =~ s/\//\\/g ;

print " working dir=$CurrentDirectory=\n";
print " SesiontraceID=$SesiontraceID=\n";



$SessionTraceViewer_Main_Win = MainWindow->new;
$SessionTraceViewer_Main_Win->title ("Session Trace Viewer & Analyzer ");

$SessionTraceViewer_Main_Win->Frame->pack(-expand=>'yes',-fill=>'both');

			
			
$t_str = sprintf("%-30.30s %-25.25s %-25.25s %-25.25s %-25.25s %-25.25s %-25.25s %-25.25s %-25.25s %-25.25s",
		  "TimeStamp","UE","eNB","Tar_ENB", "MME","SGW","HSS","Tar_MME", "Tar_SGW", "Tar_HSS");			 



$SessionTraceViewerLine_List_Title =$SessionTraceViewer_Main_Win->ScrlListbox(
		-font => ' courier 8   bold' ,
		-height=> '0', 
		-scrollbars=>'se'		);




$SessionTraceViewerLine_List = $SessionTraceViewer_Main_Win->ScrlListbox(
		- font => ' courier 8   bold',
		- scrollbars=>'se'		);


$SessionTraceViewerLine_List_Title->insert('end', "$t_str");



$SessionTraceViewerLine_List_Title->pack(-expand =>'yes',-fill=>'both');
$SessionTraceViewerLine_List->pack(-expand =>'yes',-fill=>'both');




$SessionTraceViewerLine_List->bind('<Double-1>',\&Details);


$SessionTraceViewerLine_List->repeat(10000, \&ParseXML) ;


&ConnectTo_SCTP_Server;
&ConnectTo_TCP_Server ;
&ConnectTo_UDP_Server ;


# Clear out the All_messages file
$res = `>All_messages.txt`;




MainLoop() ;




# ==================================================================================================================


















sub Details
{


	$SelectedLine = $SessionTraceViewerLine_List->get('active');

	$SessionTraceViewer_Detailed_Win = MainWindow->new() ;
	$SessionTraceViewer_Detailed_Win->title ("Message Analyzer ");


	$SessionTraceViewer_DetailedInfo = $SessionTraceViewer_Detailed_Win ->Scrolled('Text',-width=>100,-scrollbars=>'se')->pack(-fill=>'both', -expand=>'both') ;

	$SessionTraceViewer_DetailedInfo->insert('end',"$SelectedLine");




	my $CurLine = $SessionTraceViewerLine_List->index('active'); 
	# print " cur_line=$CurLine=\n";
	&DecodeMsg($CurLine) ;
	# &PrintDetails("$SelectedLine");


	$PrintedLines = 0 ; 
	my $PrintTheseLines = 0 ;

	foreach $i (@AllDetailsOfSingleMsg_line) {

		if ($i =~ /S1 Application Protocol|Diameter Protocol|GPRS Tunneling Protocol/) {
			$SessionTraceViewer_DetailedInfo->insert('end',"======================================\n");
			$SessionTraceViewer_DetailedInfo->insert('end',"======================================\n");
			$SessionTraceViewer_DetailedInfo->insert('end',"======================================\n");
			$SessionTraceViewer_DetailedInfo->insert('end',"======================================\n");
			$SessionTraceViewer_DetailedInfo->insert('end',"======================================\n");
			$PrintTheseLines = 1 ;
		}
		elsif ($i =~ /0000  02 02/) { $PrintTheseLines=0; }
		elsif ($i =~ /----------/)   { $PrintTheseLines=1;}

		if ($PrintTheseLines) {
			$SessionTraceViewer_DetailedInfo->insert('end',"$i");
				
			$PrintedLines++ ;
				
			# Print 100 lines frm the timestamp
			if ($PrintedLines > 3000)  { last ; }
		}


	}

}






#  =====================================================================================================





sub PrintDebug
{


	my ($DebugStatement) = @_;
	
	if ($DEBUG) {
		print "$DebugStatement";
	}


}







sub ConnectTo_SCTP_Server
{

 	my $host = shift || 'localhost';
 	my $port = shift || 51000;
 	# print "HOST=$host\n";
  	$proto = getprotobyname('sctp');

   	# print "proto= $proto\n";

    	my $iaddr = inet_aton($host);
     	my $paddr = sockaddr_in($port, $iaddr); 

     	socket(SCTP_SOCKET, PF_INET, SOCK_STREAM, $proto) or die "socket: $!";
     	connect(SCTP_SOCKET, $paddr) or die "connect: $!";

	# for ($i=0;$i<30;$i++) {
		# print SOCKET "Hi there\n";
	# }

}




sub ConnectTo_TCP_Server
{


	my $host = shift || 'localhost';
	my $port = shift || 3868 ;
	# print "HOST=$host\n";
 	$proto = getprotobyname('tcp');

  	# print "proto= $proto\n";

   	my $iaddr = inet_aton($host);
    	my $paddr = sockaddr_in($port, $iaddr); 

    	socket(TCP_SOCKET, PF_INET, SOCK_STREAM, $proto) or die "socket: $!";
     	connect(TCP_SOCKET, $paddr) or die "connect: $!";

}



sub ConnectTo_UDP_Server
{


# Create a new socket
        my $host = shift || 'localhost';
        my $port = shift || 2123 ;
        # print "HOST=$host\n";
        $proto = getprotobyname('udp');

        # print "proto= $proto\n";

        my $iaddr = inet_aton($host);
        my $paddr = sockaddr_in($port, $iaddr);

        socket(UDP_SOCKET, PF_INET, SOCK_DGRAM, $proto) or die "socket: $!";
        connect(UDP_SOCKET, $paddr) or die "connect: $!";


# $UDP_SOCKET =new IO::Socket::INET->new(PeerAddr=>$Server,PeerPort=>2123,Proto=>'udp');

print "Connected to UDP Server \n";

}












sub CreateTime
{

	# Use the TraceStart time and Change time to create time
	my ($TraceSt_Time, $changeTim ) = @_ ;

	# For demo purposes
	$FinTime = "2009-09-25 10:44:2$changeTim";
	
}











sub Send_To_RealTime_Server
{

	
	$Dash = "-------------------";

	foreach $val (sort keys %AllRecords_in_this_Interval) {
		# print " key=$val=   value=$AllRecords_in_this_Interval{$val}[4]=\n";

		my $src 	= $AllRecords_in_this_Interval{$val}[0];
		my $dest 	= $AllRecords_in_this_Interval{$val}[1];
		my $TimeStamp 	= $AllRecords_in_this_Interval{$val}[2];
		my $Msg 	= $AllRecords_in_this_Interval{$val}[3];
		my $MsgNam 	= $AllRecords_in_this_Interval{$val}[4];
		my $TraceRef	= $AllRecords_in_this_Interval{$val}[5];
		my $Protocoly	= $AllRecords_in_this_Interval{$val}[6];


		my $MsgStr = "";
		my @MsgBytes = split(/\s+/,$Msg);
		foreach $Byte (@MsgBytes) {
			$MsgStr .= chr(hex($Byte));
		}



		if ($Protocoly =~ /s1ap/) {
			select SCTP_SOCKET ; $| = 1 ;
			print SCTP_SOCKET $MsgStr ;
			select STDOUT; $| = 1 ;
		}
		elsif ($Protocoly =~ /S6a/) {
			select TCP_SOCKET ; $| = 1 ;
			print TCP_SOCKET $MsgStr ;
			select STDOUT; $| = 1 ;
		}
		elsif ($Protocoly =~ /S11/) {
			select UDP_SOCKET ; $| = 1 ;
			print UDP_SOCKET $MsgStr ;
			select STDOUT; $| = 1 ;
		}


		

		my $PrintStr1 = sprintf ("%-3.3d %-30.30s %-6.6s ",$MsgCount ,$TimeStamp,$Protocoly) ;
		my $PrintStr  = sprintf ("%-3.3d %-30.30s %-6.6s ",$MsgCount ,$TimeStamp,$Protocoly) ;


		if    ($src =~ /UE/) 	{$PrintStr = sprintf ("-- %-20.20s -->\n",$MsgNam) ;}
		elsif ($dest =~ /UE/) 	{$PrintStr = sprintf ("<- %-20.20s ---\n",$MsgNam) ;}

		elsif ($src =~ /Cell/) 	{$PrintStr = sprintf ("%-26.26s -- %-20.20s -->\n"," ", $MsgNam) ;}
		elsif ($dest =~ /Cell/) {$PrintStr = sprintf ("%-26.26s <- %-20.20s ---\n"," ", $MsgNam) ;}

		elsif ($dest =~ /HSS/) 	{$PrintStr = sprintf ("%-52.52s -- %-20.20s -->\n"," ", $MsgNam) ;}
		elsif ($src  =~ /HSS/) 	{$PrintStr = sprintf ("%-52.52s <- %-20.20s ---\n"," ", $MsgNam) ;}

		elsif ($dest =~ /SGW/) 	{$PrintStr = sprintf ("%-52.52s --$Dash- %-20.20s -->\n"," ", $MsgNam) ;}
		elsif ($src  =~ /SGW/) 	{$PrintStr = sprintf ("%-52.52s <-$Dash- %-20.20s ---\n"," ", $MsgNam) ;}

		$SessionTraceViewerLine_List->insert('end', "$PrintStr1 $PrintStr");
	

		$AllRecords{$MsgCount} = $AllRecords_in_this_Interval{$val} ; 
		$MsgCount++ ;
	}

}








#&Store_The_Record($Initiator, $Target, $FinalTime, $rawMsg, $MsgName, $TraceRef, $protocol, $xml_msg);

sub Store_The_Record
{


	my ($src, $dest, $TimeStamp, $Msg, $MsgNam, $TraceNum, $protocolX, $xml_msg_x) = @_;
	
	$AllRecords_in_this_Interval {$TimeStamp} = [$src, $dest, $TimeStamp, $Msg, $MsgNam, $TraceNum,$protocolX, $xml_msg_x] ;

        &PrintDebug ("Store_The_Record  xml_msg=$xml_msg_x=\n");
	
}






sub VerboseMsgDecode
{
	my ($src, $dest, $TimeStamp, $Msg, $xml_msg_h) = @_;

	@AllDetailsOfSingleMsg_line = () ;

	# Convert the PCAP to text
	$res = `tshark   -r  step1.pcap -V -x > step2.txt`;


	# Open the step2.txt
	open STEP3i, "step2.txt" or die " VerboseMsgDecode::unable to open step2.txt\n";
	while (<STEP3i>) {
		my $lin = $_ ;
		push (@AllDetailsOfSingleMsg_line,$lin) ;
	}
	close (STEP3i);

	push (@AllDetailsOfSingleMsg_line,"---------------------------------------------------------------\n");
	push (@AllDetailsOfSingleMsg_line,"---------------------------------------------------------------\n");
	push (@AllDetailsOfSingleMsg_line,"---------------------------------------------------------------\n");
	push (@AllDetailsOfSingleMsg_line,"---------------------------------------------------------------\n");
	push (@AllDetailsOfSingleMsg_line,$xml_msg_h);

	system ("wireshark step1.pcap &");
}






sub Step2
{
	my ($src, $dest, $TimeStamp, $Msg) = @_;

	# Split the dest address into the 4 parts
	($d1, $d2, $d3, $d4) = split (/\s+/,$ManagedElements{$dest});
	&PrintDebug ("Step2   d1=$d1=  d2=$d2=   d3=$d3=   d4=$d4=\n");




	# Convert the PCAP to text
	$res = `tshark   -r  step1.pcap -x > step2.txt`;


	# Open the step2.txt and put the correct IP addresses
	open STEP3i, "step2.txt" or die " Step2 unable to open step2.txt\n";
	open STEP3o, ">step3o.txt" or die " Step2 unable to create or open step3o.txt\n";
	while (<STEP3i>) {
		$lin = $_ ;
		

		if    ($lin =~ /^0000 /) {print STEP3o   "$TimeStamp		";}

		elsif ($lin =~ /0010/) {	
			$srcLine = "$ManagedElements{$src} $d1 $d2 " ;
			$lin =~ s/01 01 01 01 02 02/$srcLine/;
		}

		elsif ($lin =~ /0020/) {
			$desLin = "0020  $d3 $d4";
			$lin  =~ s/0020  02 02/$desLin/;
		}

		elsif ($lin =~ /1\.1\.1\.1/) 	{ $lin = "" ; } 

		elsif ($lin =~ /Frame/)		{ $lin = ""; }

		elsif ($lin =~ /Unaligned OCTET STRING/) { last ;}

		
		print STEP3o "$lin" ;
	}
	close (STEP3i);
	close (STEP3o);

	# Append this to the running log
	$res = `cat step3o.txt   >> All_messages.txt`;


}









# Will create a line that looks like
# 2009-09-25 10:44:22.4900 	0000  00 0c 40 3b 00 00 04 00 08 00 04 80 6b a5 4c 00 1a 00 16 15 17 ff ff ff ff 00 07 45 01 0b f6 04 04 72 00 01 01 21 91 2c 9f 00 43 00 06 00 00 00 00 01 00 64 40 08 00 00 00 00 00 00 00 00 00        
# Save this in step1.txt


# text2pcap   -S 51000,51000,9  -t  "%Y-%m-%d %H:%M:%S."  -d junk.txt   junk1.pcap
# tshark   -r  junk1.pcap -x > junk2.txt
# text2pcap    -d   junk2.txt   junk3.pcap



sub Decode_S11_message 
{
	my ($src, $dest, $TimeStamp, $Msg, $xml_m) = @_;

	
	# Create a STEP1 file
	open STEP1, ">step1.txt" or die "Decode_S11_message  unable to create or open step1.txt\n";
	print STEP1 "$TimeStamp  0000    $Msg\n";
	close (STEP1);

	# run text2pcap
	$cmd = "text2pcap   -u 52010,2123  -t  ". '"%Y-%m-%d %H:%M:%S."' . "  -d    step1.txt   step1.pcap";
	&PrintDebug ("Decode_S11_message   cmd      =$cmd=\n");
	$res = `$cmd`;

	# &Step2($src, $dest, $TimeStamp, $Msg) ;
	&VerboseMsgDecode($src, $dest, $TimeStamp, $Msg, $xml_m) ;

}












# Will create a line that looks like
# 2009-09-25 10:44:22.4900 	0000  00 0c 40 3b 00 00 04 00 08 00 04 80 6b a5 4c 00 1a 00 16 15 17 ff ff ff ff 00 07 45 01 0b f6 04 04 72 00 01 01 21 91 2c 9f 00 43 00 06 00 00 00 00 01 00 64 40 08 00 00 00 00 00 00 00 00 00        
# Save this in step1.txt


# text2pcap   -S 51000,51000,9  -t  "%Y-%m-%d %H:%M:%S."  -d junk.txt   junk1.pcap
# tshark   -r  junk1.pcap -x > junk2.txt
# text2pcap    -d   junk2.txt   junk3.pcap



sub Decode_S6A_message 
{
	my ($src, $dest, $TimeStamp, $Msg, $xml_m) = @_;

	# Split the dest address into the 4 parts
	($d1, $d2, $d3, $d4) = split (/\s+/,$ManagedElements{$dest});
	&PrintDebug ("Decode_S6A_message  d1=$d1=  d2=$d2=   d3=$d3=   d4=$d4=\n");

	
	# Create a STEP1 file
	open STEP1, ">step1.txt" or die "Decode_S6A_message unable to create or open step1.txt\n";
	print STEP1 "$TimeStamp  0000    $Msg\n";
	close (STEP1);

	# run text2pcap
	$cmd = "text2pcap   -T 34872,3868  -t  ". '"%Y-%m-%d %H:%M:%S."' . "    -d  step1.txt   step1.pcap";
	&PrintDebug ("Decode_S6A_message  cmd      =$cmd=\n");
	$res = `$cmd`;
	

	# &Step2($src, $dest, $TimeStamp, $Msg) ;
	&VerboseMsgDecode($src, $dest, $TimeStamp, $Msg, $xml_m) ;


}











# Will create a line that looks like
# 2009-09-25 10:44:22.4900 	0000  00 0c 40 3b 00 00 04 00 08 00 04 80 6b a5 4c 00 1a 00 16 15 17 ff ff ff ff 00 07 45 01 0b f6 04 04 72 00 01 01 21 91 2c 9f 00 43 00 06 00 00 00 00 01 00 64 40 08 00 00 00 00 00 00 00 00 00        
# Save this in step1.txt


# text2pcap   -S 51000,51000,9  -t  "%Y-%m-%d %H:%M:%S."  -d junk.txt   junk1.pcap
# tshark   -r  junk1.pcap -x > junk2.txt
# text2pcap    -d   junk2.txt   junk3.pcap



sub Decode_S1AP_message 
{
	my ($src, $dest, $TimeStamp, $Msg, $xml_m) = @_;

	&PrintDebug ("Decode_S1AP_message src      =$src=\n");
	&PrintDebug ("Decode_S1AP_message dest     =$dest=\n");
	&PrintDebug ("Decode_S1AP_message TimeStamp=$TimeStamp=\n");
	&PrintDebug ("Decode_S1AP_message Msg      =$Msg=\n");


	# Split the dest address into the 4 parts
	($d1, $d2, $d3, $d4) = split (/\s+/,$ManagedElements{$dest});
	&PrintDebug ("Decode_S1AP_message d1=$d1=  d2=$d2=   d3=$d3=   d4=$d4=\n");

	
	# Create a STEP1 file
	open STEP1, ">step1.txt" or die "Decode_S1AP_message unable to create or open step1.txt\n";
	print STEP1 "$TimeStamp  0000    $Msg\n";
	close (STEP1);

	# run text2pcap
	$cmd = "text2pcap   -S 51000,51000,9  -t  ". '"%Y-%m-%d %H:%M:%S."' . "    -d   step1.txt   step1.pcap";
	&PrintDebug ("Decode_S1AP_message cmd      =$cmd=\n");
	$res = `$cmd`;
	
	

	# &Step2($src, $dest, $TimeStamp, $Msg) ;
	&VerboseMsgDecode($src, $dest, $TimeStamp, $Msg, $xml_m) ;


	
}









sub DecodeMsg
{

        my ($LinNum) = @_;

	&PrintDebug ("DecodeMsg LinNum=$LinNum= \n");

	
	my $srcx         = $AllRecords{$LinNum}[0];
	my $destx        = $AllRecords{$LinNum}[1];
	my $TimeStampx   = $AllRecords{$LinNum}[2];
	my $Msgx         = $AllRecords{$LinNum}[3];
	my $MsgNamx      = $AllRecords{$LinNum}[4];
	my $TraceRefx    = $AllRecords{$LinNum}[5];
	my $Protocolx    = $AllRecords{$LinNum}[6];
	my $xml_msg_y    = $AllRecords{$LinNum}[7];

	&PrintDebug ("DecodeMsg MsgNamx=$MsgNamx= Protocolx=$Protocolx= Msgx=$Msgx= \n");


	if    ($Protocolx =~ /s1ap/) { &Decode_S1AP_message($srcx, $destx, $TimeStampx,$Msgx,$xml_msg_y); }
	elsif ($Protocolx =~ /S6a/)  { &Decode_S6A_message ($srcx, $destx, $TimeStampx,$Msgx,$xml_msg_y); } 
	elsif ($Protocolx =~ /S11/)  { &Decode_S11_message ($srcx, $destx, $TimeStampx,$Msgx,$xml_msg_y); }
}











sub ParseXML {

	%AllRecords_in_this_Interval = () ;

	my $xml_msg  = "";

        # Create a STEP1 file
	$res = `>CallTrace.xml; cat MME_CallTrace.xml  eNB_CallTrace.xml > CallTrace.xml `;

        open XML, "CallTrace.xml" or die "ParseXML unable to create or open CallTrace.xml\n";

	while (<XML>) {
		$line = $_ ; chop ($line);

		# Get the Session Start Time
		if ($line =~/traceCollec beginTime/) {
			$TraceStartTime = $line;
			$TraceStartTime =~ s/.*=\"//; 
			$TraceStartTime =~ s/".*//; 
			&PrintDebug (" TraceStartTime =$TraceStartTime =\n");
		}


		# Get the Target
		if ($line =~ /target type=/) {
			$Target=$line;
			$Target=~ s/.*ManagedElement=//;
			$Target=~ s/<.*//;

			&PrintDebug (" Target=$Target=\n");
				
			$xml_msg .= "$line \n" ;
			&PrintDebug (" xml_msg=$xml_msg=\n");

		}

		# Get the initiator
		if ($line =~ /initiator type=/) {
			$Initiator=$line;
			$Initiator=~ s/.*ManagedElement=//;
			$Initiator=~ s/<.*//;

			&PrintDebug (" Initiator=$Initiator=\n");
			$xml_msg .= "$line \n" ;
			&PrintDebug (" xml_msg=$xml_msg=\n");

		}



		# Get the changeTime
		# Attribute specification that provides the time difference with attribute specification 
		# "traceCollec beginTime". It is expressed in number of seconds and milliseconds (nbsec.ms).

		if ($line =~ /changeTime/) {
			$changeTime = $line ;
			$changeTime =~ s/.*changeTime="//;
			$changeTime =~ s/".*//;
			

			&PrintDebug  (" changeTime=$changeTime=\n");


			$MsgName = $line ;
			$MsgName =~ s/.*name="//;
			$MsgName =~ s/".*//;
			&PrintDebug  (" MsgName=$MsgName=\n");

		}



		# Get the trace session ref ID
		if ($line =~ /traceRecSessionRef/) {
			$TraceRef = $line ;
			$TraceRef =~ s/.*traceRecSessionRef="//;
			$TraceRef =~ s/".*//;
			

			&PrintDebug  (" TraceRef=$TraceRef =\n");
		}




		# Get the raw Msg
		if ($line =~ /rawMsg/) {
			$rawMsg = $line ;
			$protocol = $line ;
			$xml_msg .= "$line \n" ;
			&PrintDebug (" xml_msg=$xml_msg=\n");

			$rawMsg =~ s/.*">//;
			$rawMsg =~ s/<.*//;
			$rawMsg =~ s/(\w\w)/$1 /g;

			&PrintDebug (" rawMsg =$rawMsg= \n");



			$protocol =~ s/.*protocol="//;
			$protocol =~ s/".*//;


			&PrintDebug (" protocol=$protocol=\n\n\n");

			$FinalTime =  &CreateTime($TraceStartTime, $changeTime ); 

			&PrintDebug (" FinalTime=$FinalTime=\n\n\n");

			if ($protocol =~ /s1ap/) {
				# &Decode_S1AP_message ($Initiator, $Target, $FinalTime, $rawMsg);

			}

			elsif ($protocol =~ /S6a/) {
				# &Decode_S6A_message ($Initiator, $Target, $FinalTime, $rawMsg);

			}

			elsif ($protocol =~ /S11/) {
				# &Decode_S11_message ($Initiator, $Target, $FinalTime, $rawMsg);

			}


			# Send the raw data for real time
			&Store_The_Record($Initiator, $Target, $FinalTime, $rawMsg, $MsgName, $TraceRef, $protocol, $xml_msg);
			&PrintDebug (" xml_msg=$xml_msg=\n\n");


			$TraceStartTime =""; $changeTime ="";$FinalTime="";
			$Initiator=""; $Target=""; $rawMsg=""; $MsgName="";
			$xml_msg = "";      

			
		}

	}
	close (XML);

	 $res = `>CallTrace.xml; mv *.xml ParsedFiles`;


	&Send_To_RealTime_Server();

}
