# Problem Shift Sisop Module 1 2021

#### Members name:
* Gilbert Kurniawan Hariyanto	05111942000025
* Salma Izzatul Islam	05111942000028
* Hashfi Putraza Hikmat	05111942000021

## Question 1:

### 1. Ryujin has just been accepted as an IT support at Bukapedia. He was given the task of making daily reports for the company's internal application, ticky. There are 2 reports that he has to make, namely the report on the list of most error message ratings made by Ticky and user usage reports on the Ticky application. In order to make this report, Ryujin had to do the following:

#### a). Collects information from application logs contained in the syslog.log file. The information required includes: log type (ERROR / INFO), log messages, and the username on each log line. Since Ryujin finds it difficult to check one line at a time manually, he uses regex to make his job easier. Help Ryujin create the regex.

		#(a)
		p_error=$(cat syslog.log | grep -Po '(?<=: )(.*)(?<=\))' | sort -u)
		echo -e "$p_error \n"

##### (a) The code above explains about grouping log types and displaying them according to log type (ERROR / INFO), log messages, and username.
		• The cat command is used to read the syslog.log file
		• Grep command to search for predefined pattern files
		• -P translates patterns as Perl-compatible regular expressions (PCREs)
		• -o option to display only the part that matches the pattern
		• (? <=) (. *) (? <= \)) Using lookbehind. ?<=\() to match the pattern after the opening brackets ( and .* retrieves all strings that follow. 
		(? = \)) to constrain the fetched strings, i.e. up to before the closing brackets)
		• Sort -u to sort the output
		• Echo to display each variable content
##### Problem encountered
• at first we don't use a REGEX
#### Result Image:
![](/images/soal1/soal1a.png)

#### b). Then, Ryujin must display all error messages that appear along with the number of occurrences.
	
	#(b)
	grep -oE 'ERROR.*' syslog.log
	echo c_err=$(grep -cE 'ERROR' syslog.log) 
	
##### (b) The code above shows how we display data with the ERROR log type and sum it up
	o grep -oE 'ERROR. *' syslog.log command which will run first, and will display the message ERROR
		• Grep command to search for given pattern files
		• -o option to display only the part that matches the pattern
		• -E translate patterns as extended regular expressions (EREs)
		• 'ERROR. *' The asterisk * in ERROR. * Is a quantifier for matching patterns starting from zero onwards
		• -c counts the number of lines that match the pattern
	o echo c_err=$(grep -cE 'ERROR' syslog.log) command will display the sum of message ERROR
##### Problem encountered
• the output of sum is 0
#### Result Image:
![](/images/soal1/soal1b.png)

#### c). Ryujin must also be able to display the number of occurrences of the ERROR and INFO logs for each user.
	
	#(c)
	c_user=$(grep -Po '(?<=\()(.*)(?=\))' syslog.log | sort | uniq -c)
	echo -e "\n$c_user\n"

##### (c) The code above shows how we display data in the form of a username and the number of occurrences of the ERROR and INFO logs
	• Grep command to search for predefined pattern files
	• -P translates patterns as Perl-compatible regular expressions (PCREs)
	• -o option to display only the part that matches the pattern
	• (?<=\()(.*)(?=\)) Using lookbehind. ?<=\() to match the pattern after the opening brackets ( and .* retrieves all strings that follow. 
		(? = \)) to constrain the fetched strings, i.e. up to before the closing brackets)
	• Sort to sort the output
	• Uniq -c to filter usernames so there are no duplicates
	• Echo to display each variable content
##### Problem encountered
• displays the number of occurrences for each user

After all the necessary information has been prepared, now is the time for Ryujin to write all the information into a report in the csv file format.

#### d). All information obtained in point b is written into the error_message.csv file with the Error, Count header, which is then followed by a list of error messages and the number of occurrences is ordered based on the number of occurrence of error messages from the most.
Example:
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2
	
	#(d)
	count_err=$( cat syslog.log | grep 'ERROR' | grep -Po '(?<=ERROR\s)(.*)(?=\s)' | sort | uniq -c)
	echo 'Error,Count' > error_message.csv
	echo "$count_err" | while read row;
	do
	error=$(echo $row | cut -d ' ' -f 2-) to cut 2 coloumn
	count=$(echo $row | cut -d ' ' -f 1) to cut 1 coloumn 
	print="$error,$count"
	echo $print >> error_message.csv
	done
	
##### (d) The code above shows the ERROR log type information and is written in the form error_message.csv file

	• The cat command is used to read the syslog.log file
	• Grep command to search for given pattern files
	• -P translates patterns as Perl-compatible regular expressions (PCREs)
	• -o option to display only the part that matches the pattern
	• (? <= ERROR \ s) (. *) (? = \ S) Using lookbehind. ?<=\() to match the pattern after the opening brackets ( and .* retrieves all strings that follow. 
		(? = \)) to constrain the fetched strings, i.e. up to before the closing brackets)
	• Sort to sort the output
	• Uniq -c to filter usernames so there are no duplicates
	• echo 'Error, Count'> error_message.csv to enter the requested data into a file named error_message.csv
	• while read row reads $ count_err as row
	• error = $ (echo $ row | cut -d '' -f 2-) 
	• Count = $ (echo $ row | cut -d '' -f 1)
	• print to display each variable content
	• echo $ print >> error_message.csv to display each variable content into the error_message.csv file
##### Problem encountered
• there are double data occurs in the file 
#### Result Image:
![](/images/soal1/soal1d.png)

#### e). All information obtained in point c is written into the user_statistic.csv file with the header Username, INFO, ERROR sorted by username in ascending order.
Example:
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
	
	#(e)
	echo 'Username,INFO,ERROR' > user_statistic.csv
	for i in $c_user
	do
	err_c=$(cat syslog.log | grep 'ERROR' | grep -c $i)
	info_c=$(cat syslog.log | grep 'INFO' | grep -c $i)
	echo "$i,$info_c,$err_c" >> user_statistic.csv
	done

##### (e) The code above shows creating a file called user_statistic.csv which contains the username and the number of occurrences of the ERROR and INFO logs.
	• echo 'Username, INFO, ERROR'> user_statistic.csv to enter the requested data into a file named user_statistic.csv
	• for i in $ c_user is a for loop with $ c_user as i
	• The cat command is used to read the syslog.log file
	• grep ERROR command to search for error files
	• grep INFO command to find file info
	• -c counts the number of lines that match the pattern
	• Echo "$ i, $ info_c, $ err_c" >> user_statistic.csv to display each variable content into the user_statistic.csv file
##### Problem encountered
• the sum of the type log (INFO\ERROR)
#### Result Image (For 1c & 1e):
![](/images/soal1/soal1e.png)	
	
## Question 2:

### 2. Steven and Manis founded a startup called “TokoShiSop”, While you and Clemong are the first employees of TokoShiShop. After three years of work, Clemong was appointed to be TokoShiSop’s sales manager, while you became the head of the warehouse who supervised entry and exit of goods. Every year, TokoShiSop holds a meeting that discusses how sales results and future strategies will be implemented. You’ve been very prepared for this year’s meeting. But suddenly, Steven, Manis, and Clemong ask you to look for some conclusions from the “Laporan-TokoShiSop.tsv” sales data.

#### a). Steven wants to appreciate the performance of his employees so far by knowing Row ID and the largest profit percentage (if the largest profit percentage is more than 1, take the largest Row ID). To make your work easier, Clemong provides the definition of profit percentage, i.e.:( Profit Percentage = (Profit-Cost Price)*100 )

	#2a
	awk -F '\t' 'NR>1 {price=$18-$21; percent=($21/price)*100; print $1, percent}' Laporan-TokoShiSop.tsv > filter.txt

##### (a) The code above looking for the conclusion of the sales data-TokoShop.tsv Reports.
	• -F "\ t" to change the separator field to tabs per column
	• price variable represent Profit-Cost Price
	• percent variable represent formula for the Profit Percentage in the end
	• We then print the result for each row on the table 
	• For easier navigation, we saved the result on filter.txt	

#### b). Cost Price is obtained from the reduction of Sales with Profit. (Quantity ignored). Clemong has a promotional plan in Albuquerque using the MLM method. Therefore, Clemong needs a list of customer names on the 2017 transaction in Albuquerque.

	#(b)
	list_name=$(awk 'match($3, "-17") && /Albuquerque/ {print $8 " "$9}' Laporan-TokoShiSop.tsv | sort | uniq )

##### (b) The code above will filter the sales data on TokoShop.tsv Reports.	
	
	• The first thing to do is we use awk to filter the year on column 3 & pick only the data which is on Albuquerque
	• We then print the column 8 & 9 which represent the name of the customer
	• We use sort to sort the result & uniq to filter the duplicate data
	

#### c). TokoShiSop focuses on three customer segments, among others: Home Offices, Customers, and Corporates. Clemong wants to increase sales in the customer segment that has the least sales. Therefore, Clemong needs a customer segment and the number of transactions with the least amount of transactions.

	#(c)
	least_sale=$(cut -f 8 Laporan-TokoShiSop.tsv | sort | uniq -c | head -n -1 | tail -n -1 | awk '{print "The type of customer segment with the least sales is " $2 " " $3" with "$1" transactions."}')

##### (c) The code above will filter the sales data on TokoShop.tsv Reports.	
	
	• The first thing we do is we cut the 8 column in the report and find & count each of the uniq value using unic -c
	• We then proceed take the lowest data using head -n -1 & tail -n -1
	• The awk function just to print according to the question


#### d). TokoShiSop divides the sales region into four parts: Central, East, South, and West. Manis wants to find the region that has the least total profit and the total profit of that region.

	#(d)
	max_profit=$(cut -f 13,21 Laporan-TokoShiSop.tsv | sort -s | uniq -c | awk 'NR>=2 && p!=$2 {print "The region which has the least total profit is " p " with total profit " s;s=0} {s+=$3*$1} {p=$2}' | head -n 1)
	
##### (d) The code above will filter the sales data on TokoShop.tsv Reports.	
	
	• The first thing to do is we use cut the column 13 which is the region of the sales & coulmn 21 which is the profit column & also sort & count it 
	• The awk fucntion used to calculate the profit on each region
	• The head function then take the region with the highest profit

#### e). To make it easy for Manis, Clemong, and Steven to read, (e) you are expected to be able to create a script that will produce a file “Hasil.txt” 
	
	#(e)
	#this print 2a
	awk 'BEGIN {max=0;num=0}{if($2>max) max=$2}{if($2==max) num=$1} END {print "The last transaction with the largest Transaction ID is ",num," with a percentage of ",max,"%."}' filter.txt > hasil.txt
 	
 	#this print
	echo -e "\nThe list of customer names in Albuquerque in 2017 includes: \n$list_name\n \n$least_sale\n \n$max_profit\n" >> hasil.txt
	
##### (e) The code above will print the rest of the variable that has stored the data for each of the sub question.	
	
	• The first line that use awk represent the 2a question that calculate the largest transaction ID
	• The second line and so on represent the number 2b - 2d
	
#### Result Image (each enter represent the next sub number answer):
![](/images/soal2/soal2.png)	
	
##### Problem encountered when doing number 2:
	1.initially didn't think of using variable to store the result 
	2.having hard time to calculate the 2a because of there's 0 multiplication that resulting in error
	3.The lack of knowledge of various function that then take time to learn during the progress

## Question 3:

### 3. Kuuhaku is a person who really likes to collect digital photos, but Kuuhaku is also a lazy person so he doesn't want to bother looking for photos, besides that he is also shy, so he doesn't want anyone to see his collection, unfortunately, he has a friend named Steven who made being nosy his primary responsibility. Kuuhaku then had an idea, a way so that Steven won't be able to see his collection. To make his life easier, he is asking for your help. The idea is:

#### a). Make a script to download 23 images from "https://loremflickr.com/320/240/kitten" and save the logs to the file "Foto.log". Since the downloaded images are random, it is possible that the same image is downloaded more than once, therefore you have to delete the same image (no need to download new images to replace them). Then save the images with the name "Kumpulan_XX" with consecutive numbers without missing any number (example: Koleksi_01, Koleksi_02, ...)
	
	#3a
	dirloc=/home/xyncz/Downloads/soal3

	for ((a=1; a<=23; a=+1))
    	do
    		if [ $a -lt 10 ]
    		then 
        		wget -a "$dirloc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$dirloc"/Koleksi_0"$a".jpg
   		else 
    			wget -a "$dirloc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$dirloc"/Koleksi_"$a".jpg
    		fi
	done
	
#### Result Image 
![](/images/soal3/soal3a.png)	
	
#### b). Because Kuuhaku is too lazy to run the script manually, he also asks you to run the script once a day at 8 o'clock in the evening for some specific dates every month, namely starting the 1st every seven days (1,8, ...), as well as from the 2nd once every four days (2,6, ...). To tidy it up, the downloaded images and logs are moved to a folder named the download date with the format "DD-MM-YYYY" (example: "13-03-2023").
	
	#3b
	0 20 1-31/7,2-31/4 * * bash /home/Downloads/soal3/soal3b.sh

	
#### d). To secure his Photo collection from Steven, Kuuhaku asked you to create a script that will move the entire folder to zip which is named "Koleksi.zip" and lock the zip with a password in the form of the current date with the format "MMDDYYYY" (example: "03032003").

	#3d
	passw=`date +'%m%d%Y'`
	zip -P $passw '/home/xyncz/Downloads/Koleksi.zip' . -x *.sh* -x *.log* -x *.tab*

#### Result Image
![](/images/soal3/soal3d.png)	
	
#### e). Because kuuhaku only met Steven during college, which is every day except Saturday and Sunday, from 7 am to 6 pm, he asks you to zip the collection during college, apart from the time mentioned, he wants the collection unzipped. and no other zip files exist.

	#3e
	#zip
	0 7 * * 1-5 bash /home/xyncz/Desktop/soal3d.sh

	#unzip
	0 18 * * 1-5 passw=$(date +'%m%d%Y'); unzip -P "$passw" Koleksi.zip; rm Koleksi.zip
	
##### Problem encountered when doing number 2:
	1.The lack of knowledge of various function that then take time to learn during the progress
	2.Can't find the solution why the cron won't run
	3.for 3a, can't find the logic to compare & delet the duplicate automatically
	
