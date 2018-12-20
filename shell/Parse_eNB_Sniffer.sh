#!/bin/bash

# Usage Parse_eNB_Sniffer.sh   
#       Parse_eNB_Sniffer.sh  


#        eNB IPs 
#        enb-009           enb-011

dte=`date +%Y%m%d`

hr=`date +%-H`
prev_hr=$[$hr - 1]

# Padding with leading 0s.
hr=$(printf %02d $hr)
prev_hr=$(printf %02d $prev_hr)


echo "date=$dte   hr=$hr= prev_hr=$prev_hr=  "

rm -rf $dte/All_Hr_Sniffer_Summary_$hr*

# Convert pcap for 1 hr to text fle ;  log saved in /tmp/date_hr_min.txt
# echo "Convert pcap to text for HR=$hr=   "
# perl Convert_To_Text_eNB_Sniffer_1_Hr.pl    $1    $hr 

# for enb_ip   in 27.132.68.73      27.132.68.74  
for enb_ip   in `grep eNB_IP /test/log/lab/logs/CONFIG.txt | cut -c10-`
do	
	# Analyze the siffer logs
	echo "Analyze sniffer log for eNB=$enb_ip=   HR=$hr="
	perl  Analyze_eNB_Sniffer_1_Hr.pl           $dte    $hr      $enb_ip  > $dte/All_Hr_Sniffer_Summary_"$hr"_$enb_ip.txt 

	echo "Analyze sniffer log for eNB=$enb_ip=   HR=$prev_hr="
	perl  Analyze_eNB_Sniffer_1_Hr.pl           $dte    $prev_hr $enb_ip  > $dte/All_Hr_Sniffer_Summary_"$prev_hr"_$enb_ip.txt 

	echo "Concatenate all hourly summary into daily"
	cat $dte/All_Hr_Sniffer_Summary*$enb_ip.txt > $dte/All_Day_Sniffer_Summary_$enb_ip.txt

	echo "Extract C1 stats"
	perl Sniffer_c1.pl $dte/All_Day_Sniffer_Summary_$enb_ip.txt > $dte/All_Day_Sniffer_C1_CallModel_$enb_ip.txt


done


chmod 777 $dte/All*

