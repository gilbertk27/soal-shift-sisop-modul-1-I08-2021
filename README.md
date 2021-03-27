# Soal Shift Sisop Modul 1 2021

#### Anggota Kelompok:
* Gilbert Kurniawan Hariyanto	05111942000025
* Salma Izzatul Islam	05111942000028
* Hashfi Putraza Hikmat	05111942000021

## Soal 1:
1 a) Collects information from application logs contained in the syslog.log file. The information required includes: log type (ERROR / INFO), log messages, and the username on each log line. Since Ryujin finds it difficult to check one line at a time manually, he uses regex to make his job easier. Help Ryujin create the regex.

	#1a
	grep -oE "(INFO.*)|(ERROR.*)" syslog.log
	
1 b) Then, Ryujin must display all error messages that appear along with the number of occurrences.
	
	#1b
	grep -oE 'ERROR.*' syslog.log
echo c_err=$(grep -cE 'ERROR' syslog.log) 

1 c) Ryujin must also be able to display the number of occurrences of the ERROR and INFO logs for each user.
	
	#1c
	c_user=$(grep -Po '(?<=\()(.*)(?=\))' syslog.log | sort -u)
echo -e "\n$c_user\n"

## Soal 2:

2 a) Steven wants to appreciate the performance of his employees so far by knowing Row ID and the largest profit percentage (if the largest profit percentage is more than 1, take the largest Row ID). To make your work easier, Clemong provides the definition of profit percentage, i.e.:

Profit Percentage = (Profit Cost Price) 100

	#2a

2 b) Cost Price is obtained from the reduction of Sales with Profit. (Quantity ignored). Clemong has a promotional plan in Albuquerque using the MLM method. Therefore, Clemong needs a list of customer names on the 2017 transaction in Albuquerque.

	#2b
	list_name=$(awk '/Albuquerque/ && $3>="01-01-17" {print $8 " "$9}' Laporan- TokoShiSop.tsv | sort | uniq )


2 c) TokoShiSop focuses on three customer segments, among others: Home Offices, Customers, and Corporates. Clemong wants to increase sales in the customer segment that has the least sales. Therefore, Clemong needs a customer segment and the number of transactions with the least amount of transactions.

	#2c
	least_sale=$(cut -f 8 Laporan-TokoShiSop.tsv | sort | uniq -c | head -n -1 | tail -n -1 | awk '{print "The type of customer segment with the least sales is " $2 " " $3" with "$1" transactions."}')


2 d) TokoShiSop divides the sales region into four parts: Central, East, South, and West. Manis wants to find the region that has the least total profit and the total profit of that region.

	#2d
	max_profit=$(cut -f 13,21 Laporan-TokoShiSop.tsv | sort -s | uniq -c | awk 'NR>=2 && p!=$2 {print "The region which has the least total profit is " p " with total profit " s;s=0} {s+=$3*$1} {p=$2}' | head -n 1)

2 e) To make it easy for Manis, Clemong, and Steven to read, (e) you are expected to be able to create a script that will produce a file “Hasil.txt” 
	
	#2e
	echo -e "The list of customer names in Albuquerque in 2017 includes: \n$list_name\n \n$least_sale\n \n$max_profit\n" > hasil.txt
