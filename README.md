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
#### Result Image:
![](/images/soal1/soal1a.png)

##### (a) The code above explains about grouping log types and displaying them according to log type (ERROR / INFO), log messages, and username.
		• The cat command is used to read the syslog.log file
		• Grep command to search for predefined pattern files
		• -P translates patterns as Perl-compatible regular expressions (PCREs)
		• -o option to display only the part that matches the pattern
		• (? <=) (. *) (? <= \)) Using lookbehind. ?<=\() to match the pattern after the opening brackets ( and .* retrieves all strings that follow. 
		(? = \)) to constrain the fetched strings, i.e. up to before the closing brackets)
		• Sort -u to sort the output
		• Echo to display each variable content
	
#### b). Then, Ryujin must display all error messages that appear along with the number of occurrences.
	
	#(b)
	grep -oE 'ERROR.*' syslog.log
	echo c_err=$(grep -cE 'ERROR' syslog.log) 
	
##### (b) The code above shows how we display data with the ERROR log type and add it up
	o grep -oE 'ERROR. *' syslog.log command which will run first, and will display the message ERROR
		• Grep command to search for given pattern files
		• -o option to display only the part that matches the pattern
		• -E translate patterns as extended regular expressions (EREs)
		• 'ERROR. *' The asterisk * in ERROR. * Is a quantifier for matching patterns starting from zero onwards
		• -c counts the number of lines that match the pattern

#### c). Ryujin must also be able to display the number of occurrences of the ERROR and INFO logs for each user.
	
	#(c)
	c_user=$(grep -Po '(?<=\()(.*)(?=\))' syslog.log | sort | uniq -c)
	echo -e "\n$c_user\n"

##### (c) The code above shows how we display data in the form of a username and the number of occurrences of the ERROR and INFO logs
	• Grep command to search for predefined pattern files
	• -P translates patterns as Perl-compatible regular expressions (PCREs)
	• -o option to display only the part that matches the pattern
	• Sort to sort the output
	• Uniq -c to filter usernames so there are no duplicates
	• Echo to display each variable content
	
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
	error=$(echo $row | cut -d ' ' -f 2-)
	count=$(echo $row | cut -d ' ' -f 1)
	print="$error,$count"
	echo $print >> error_message.csv
	done
##### (d) The code above shows the ERROR log type information and is written in the form error_message.csv file
	• The cat command is used to read the syslog.log file
	• Grep command to search for given pattern files
	• -P translates patterns as Perl-compatible regular expressions (PCREs)
	• -o option to display only the part that matches the pattern
	• (? <= ERROR \ s) (. *) (? = \ S)
	• Sort to sort the output
	• Uniq -c to filter usernames so there are no duplicates
	• echo 'Error, Count'> error_message.csv to enter the requested data into a file named error_message.csv
	• while read row reads $ count_err as row
	• error = $ (echo $ row | cut -d '' -f 2-) for
	• Count = $ (echo $ row | cut -d '' -f 1) for
	• print to display each variable content
	• echo $ print >> error_message.csv to display each variable content into the error_message.csv file

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
	
## Question 2:

### 2. Steven and Manis founded a startup called “TokoShiSop”, While you and Clemong are the first employees of TokoShiShop. After three years of work, Clemong was appointed to be TokoShiSop’s sales manager, while you became the head of the warehouse who supervised entry and exit of goods.

	Every year, TokoShiSop holds a meeting that discusses how sales results and future strategies will be implemented. You’ve been very prepared for this year’s meeting. But suddenly, Steven, Manis, and Clemong ask you to look for some conclusions from the “Laporan-TokoShiSop.tsv” sales data.

#### a). Steven wants to appreciate the performance of his employees so far by knowing Row ID and the largest profit percentage (if the largest profit percentage is more than 1, take the largest Row ID). To make your work easier, Clemong provides the definition of profit percentage, i.e.:

Profit Percentage = (Profit Cost Price) 100

	#(a)

#### b). Cost Price is obtained from the reduction of Sales with Profit. (Quantity ignored). Clemong has a promotional plan in Albuquerque using the MLM method. Therefore, Clemong needs a list of customer names on the 2017 transaction in Albuquerque.

	#(b)
	list_name=$(awk '/Albuquerque/ && $3>="01-01-17" {print $8 " "$9}' Laporan- TokoShiSop.tsv | sort | uniq )


#### c). TokoShiSop focuses on three customer segments, among others: Home Offices, Customers, and Corporates. Clemong wants to increase sales in the customer segment that has the least sales. Therefore, Clemong needs a customer segment and the number of transactions with the least amount of transactions.

	#(c)
	least_sale=$(cut -f 8 Laporan-TokoShiSop.tsv | sort | uniq -c | head -n -1 | tail -n -1 | awk '{print "The type of customer segment with the least sales is " $2 " " $3" with "$1" transactions."}')


#### d). TokoShiSop divides the sales region into four parts: Central, East, South, and West. Manis wants to find the region that has the least total profit and the total profit of that region.

	#(d)
	max_profit=$(cut -f 13,21 Laporan-TokoShiSop.tsv | sort -s | uniq -c | awk 'NR>=2 && p!=$2 {print "The region which has the least total profit is " p " with total profit " s;s=0} {s+=$3*$1} {p=$2}' | head -n 1)

#### e). To make it easy for Manis, Clemong, and Steven to read, (e) you are expected to be able to create a script that will produce a file “Hasil.txt” 
	
	#(e)
	echo -e "The last transaction with the largest *Transaction ID* with a percentage of *Profit Percentage*%." > hasil.txt
	echo -e "The list of customer names in Albuquerque in 2017 includes: \n$list_name\n \n$least_sale\n \n$max_profit\n" >> hasil.txt

## Question 3:

### 3. Kuuhaku is a person who really likes to collect digital photos, but Kuuhaku is also a lazy person so he doesn't want to bother looking for photos, besides that he is also shy, so he doesn't want anyone to see his collection, unfortunately, he has a friend named Steven who made being nosy his primary responsibility. Kuuhaku then had an idea, a way so that Steven won't be able to see his collection. To make his life easier, he is asking for your help. The idea is:

#### a). Make a script to download 23 images from "https://loremflickr.com/320/240/kitten" and save the logs to the file "Foto.log". Since the downloaded images are random, it is possible that the same image is downloaded more than once, therefore you have to delete the same image (no need to download new images to replace them). Then save the images with the name "Kumpulan_XX" with consecutive numbers without missing any number (example: Koleksi_01, Koleksi_02, ...)
	
	#3a
	
#### b). Because Kuuhaku is too lazy to run the script manually, he also asks you to run the script once a day at 8 o'clock in the evening for some specific dates every month, namely starting the 1st every seven days (1,8, ...), as well as from the 2nd once every four days (2,6, ...). To tidy it up, the downloaded images and logs are moved to a folder named the download date with the format "DD-MM-YYYY" (example: "13-03-2023").
	
	#3b

#### c). To prevent Kuuhaku getting bored with pictures of kittens, he also asked you to download rabbit images from "https://loremflickr.com/320/240/bunny". Kuuhaku asks you to download pictures of cats and rabbits alternately (the first one is free. example: 30th cat > 31st rabbit > 1st cat > ...). To distinguish between folders containing cat pictures and rabbit pictures, the folder names are prefixed with "Kucing_" or "Kelinci_" (example: "Kucing_13-03-2023").

	#3c
	
#### d). To secure his Photo collection from Steven, Kuuhaku asked you to create a script that will move the entire folder to zip which is named "Koleksi.zip" and lock the zip with a password in the form of the current date with the format "MMDDYYYY" (example: "03032003").

	#3d
	
#### e). Because kuuhaku only met Steven during college, which is every day except Saturday and Sunday, from 7 am to 6 pm, he asks you to zip the collection during college, apart from the time mentioned, he wants the collection unzipped. and no other zip files exist.

	#3e
