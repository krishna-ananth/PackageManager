#!/bin/sh
echo "Package Manager"
echo ""
choice=1
while [ $choice -ne 25 ]
do
	echo "Enter your choice"
	echo "	1.  Display list of installed Packages"
	echo "	2.  Checking RPM signature of a package"
	echo "	3.  Install a package"
	echo "	4.  Check dependencies of a package"
	echo "	5.  Install a package without dependencies"
	echo "	6.  Check an installed RPM package"
	echo "	7.  Upgrade a package"
	echo "	8.  Remove a package"
	echo "	9.  Remove a package without dependencies"
	echo "	10. List all files of an installed RPM package"
	echo "	11. Find information about a particular package"
	echo "	12. Display recently installed packages"
	echo "	13. Export list of packages"
	echo "	14. Import list of packages"
	echo "	15. Find the owner of a file"
	echo "	16. Query documentation of an installed package"
	echo "	17. Verify a package against the RPM database"
	echo "	18. Verify all RPM packages"
	echo "	19. Import GPG key"
	echo "	20. List all imported GPG keys"
	echo "	21. Rebuild Corrupted RPM Database"
	echo "	22. List the configuration files for a package"
	echo "	23. List the configuration files for a command"
	echo "	24. Reset the screen"
	echo "	25. Exit"
	read choice
	
	case $choice in
		1) echo "Listing all packages"
			rpm -qa;;
		2) echo "Checking RPM signature. Enter package name"
			read pname
			rpm --checksig $pname;; 	#Checks signature against md5 of RPM Database
		3) echo "Installing package. Enter package name"
                        read pname
                        rpm -ivh $pname;;		#i --> Install, v --> Verbose(nicer display), h --> Print hash marks when unpacking package
		4) echo "Checking dependencies. Enter package name"
                        read pname
                        rpm -qpR $pname;;		#q --> Query, p --> List capabilities this package provides, R --> List capabilities this package depends upon
		5) echo "Installing package without dependencies. Enter package name"
                        read pname
                        rpm -ivh --nodeps $pname;;	#nodeps --> No dependencies check
		6) echo "Checking installed package. Enter package name"
                        read pname
                        rpm -q $pname;;			#q --> Query
		7) echo "Upgrading package. Enter package name"
                        read pname
                        rpm -Uvh $pname;;		#U --> Upgrade (Saves backup of older package in case of error)
		8) echo "Removing package. Enter package name"
                        read pname
                        rpm -ev $pname;;		#e --> Erase
		9) echo "Removing package without dependencies. Enter package name"
                        read pname
                        rpm -ev --nodeps $pname;;	#nodeps --> No dependencies check
		10) echo "Listing all files of an installed package. Enter package name"
                        read pname
                        rpm -ql $pname;;		#q --> Query, l --> List
		11) echo "Finding information about package. Enter package name"
			read pname
			rpm -qip $pname;;		#qip --> Query Info Package
		12) echo "Displaying recently installed packages"
                        rpm -qa --last;;		#qa --> Query All
		13) echo "Exporting list of packages. Specify export file name"
			read fname
                        rpm -qa > $fname
			echo "Exported to $fname";;
		14) echo "Importing packages. Specify filename containing list of packages."
			#read fname
			#cat $fname | while read LINE
			#do
			#	chk=rpm -q $LINE
			#	if [ $chk = $LINE ]
			#		then echo "YES"
			#	fi
			#	#echo "$LINE"
			#done
			;;
		15) echo "Finding owner of file. Enter path to file"
			read fname
			rpm -qf $fname;;		#qf --> Query Find;;
		16) echo "Querying documentation. Enter package name"
                        read pname
                        rpm -qdf $pname;;		#qdf --> Query Document File
		17) echo "Verifying package against RPM Database. Enter package name"
                        read pname
                        rpm -Vp $pname;;		#Vp --> Verify Package
		18) echo "Verifying all packages against RPM Database"
                        rpm -Va;;			#Va --> Verify All
		19) echo "Importing GPG Key"
                        rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6;; #Importing GPG Key for CentOS
		20) echo "Listing all imported GPG Keys"
			rpm -qa gpg-pubkey*;;		#qa --> Query All GPG pubkeys
		21) echo "Rebuilding RPM Database"
			cd /var/lib			#Entering library
			rm __db*			#Removing corrupted files
			rpm --rebuilddb			#Rebuilding RPM Databas
			rpmdb_verify Packages		#Verifying with RPM Database 
			cd;;
		22) echo "Listing configuration files of package. Enter package name"
			read pname
			rpm -qc $pname;;		#qc --> Query Conf
		23) echo "Listing configuration files for command. Enter path to file"
			read fname
			rpm -qcf $fname;;		#qcf --> Query Conf File
		24) reset;;
		25)echo "Thank you for using Package Manager";;	#Exiting
		*) echo "Wrong choice. Please run again";	#Default 
	esac
done
