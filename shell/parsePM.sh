#!/bin/bash

# Usage ParsePM_AllDay.pl    date  
# hour is UTC  ie UTC = CST - 5

# The PM is for all INS sectors in the eNB.

ORIGINAL_DATE=$1
ORIGINAL_EPOCH=$(date -d "${ORIGINAL_DATE}" "+%s")
PREV_EPOCH=$((${ORIGINAL_EPOCH} - $((60 * 60 * 24))))
PREV_DATE=$(date -d "1970-01-01 ${PREV_EPOCH} sec" "+%Y%m%d")

# This is eNB specific info
Sniffer_PC=TECHpc061.org.company.com
eNB_IP=27.132.68.73



mkdir /tmp/JUNK
chmod 777 /tmp/*  /tmp/JUNK/*
rm -f /tmp/JUNK/*
cp $1/*/*PM*/*MGR* /tmp/JUNK
cp $1/*/*PM*/From_ENB/*MGR* /tmp/JUNK
cp $1/*/*PM*/From_TECHMGR/*MGR* /tmp/JUNK
cp $PREV_DATE/*/*PM*/From_TECHMGR/*MGR* /tmp/JUNK


#  Creatinh All day PM
perl ParsePM_AllDay.pl    $1 > $1/ParsePM_AllDay_$1.csv



# Create Managers report
egrep "RRCConnMean|RRUAvgPhyThroughputDl|RRUAvgPhyThroughputUl|EQPTMeanProcessorUsageBCU3|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_ManagerView_$1.csv



i=RRC_Conn;
egrep "RRCConnEstabAttSum|RRCConnEstabSuccSum|RRCConnMean|RRCConnReleaseSum|RRCConnReEstabAttSum|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_View_"$i"_$1.csv
# perl PlotPM_Graph_AllDay.pl   PmData.csv                          PM_Pattern    date 
perl PlotPM_Graph_AllDay.pl   $1/ParsePM_AllDay_View_"$i"_$1.csv    $i    $1



i=RRC_Conn_Times;
egrep "RRCConnUsageTime|RRCConnEstabTimeMeanSum|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_View_"$i"_$1.csv
perl PlotPM_Graph_AllDay.pl   $1/ParsePM_AllDay_View_"$i"_$1.csv    $i    $1


i=ThroughputD ;


i=ThroughputD ;
egrep "DRBPdcpSduBitrateDlSum|ThroughputD|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_View_"$i"_$1.csv 
perl PlotPM_Graph_AllDay.pl   $1/ParsePM_AllDay_View_"$i"_$1.csv    $i   $1



i=ThroughputU ;
egrep "DRBPdcpSduBitrateUlSum|ThroughputU|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_View_"$i"_$1.csv 
perl PlotPM_Graph_AllDay.pl   $1/ParsePM_AllDay_View_"$i"_$1.csv    $i   $1


i=ProcessorUsageBCU3;
egrep "ProcessorUsageBCU3|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_View_"$i"_$1.csv 
perl PlotPM_Graph_AllDay.pl   $1/ParsePM_AllDay_View_"$i"_$1.csv    $i   $1


i=RRUPrbUsage;
egrep "RRUPrbDlSum|RRUPrbUlSum|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_View_"$i"_$1.csv
perl PlotPM_Graph_AllDay.pl   $1/ParsePM_AllDay_View_"$i"_$1.csv    $i   $1


i=BHLKBytesDropped;
egrep "BHLKBytesDLDropped|BHLKBytesULDropped|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_View_"$i"_$1.csv
perl PlotPM_Graph_AllDay.pl   $1/ParsePM_AllDay_View_"$i"_$1.csv    $i   $1 



i=RRUAvgUsrScheduled
egrep "RRUAvgUsrScheduledDl|RRUAvgUsrScheduledUl|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_View_"$i"_$1.csv
perl PlotPM_Graph_AllDay.pl   $1/ParsePM_AllDay_View_"$i"_$1.csv    $i   $1


i=IntraENBHO
egrep "HOIntraEnbOutAttSum|HOIntraEnbOutSuccSum|CST"  $1/ParsePM_AllDay_$1.csv  > $1/ParsePM_AllDay_View_"$i"_$1.csv
perl PlotPM_Graph_AllDay.pl   $1/ParsePM_AllDay_View_"$i"_$1.csv    $i   $1








# Parse the SDL

rm -rf $1/All*SDL*.txt  /tmp/junk_sdl
for hr in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 
do
        echo -e   "########   Date=$1     CST Hr = $hr"   >> $1/All_Day_SDL_Stats.txt
        echo -e   "########   Date=$1     CST Hr = $hr"   >> $1/All_Day_SDL_Detailed.txt


	for i in `ls $1/$hr*/*SDL*/*TECHMGR*/*.txt`
	do
 		perl Parse_SDL.pl  $i > /tmp/junk_sdl 

		echo -e "\n  "                              >> $1/All_Day_SDL_Stats.txt
		echo -e "\n  "                              >> $1/All_Day_SDL_Detailed.txt

 		cat /tmp/junk_sdl  | egrep "File=|Total|%"  >> $1/All_Day_SDL_Stats.txt
 		cat /tmp/junk_sdl  | egrep  "File=|SDL::"   >> $1/All_Day_SDL_Detailed.txt
	done
	echo -e "\n\n\n"                                    >> $1/All_Day_SDL_Stats.txt
	echo -e "\n\n\n"                                    >> $1/All_Day_SDL_Detailed.txt
done



# Create eNB Dash board
perl eNB_Dash_Board.pl $1  $Sniffer_PC    $eNB_IP

chmod 777 $1/*

