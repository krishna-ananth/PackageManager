#!/bin/sh
echo "Package Manager for Ubuntu"
echo ""
choice=1
while [ $choice -ne 18 ]
do
	echo "Enter your choice"
	echo "	1.  Display list of installed Packages"
	echo "	2.  Build dependencies of a package"
	echo "	3.  Install a package"
	echo "	4.  Check an installed package"
	echo "	5.  Upgrade a package"
	echo "	6.  Remove a package but leave configuration files intact"
	echo "	7.  Purge a package"
	echo "	8.  List all files of an installed package"
	echo "	9.  Find information about a particular package"
	echo "	10. Display recently installed packages"
	echo "	11. Export list of packages"
	echo "	12. Import list of packages"
	echo "	13. Find the owner of a file"
	echo "	14. Rebuild corrupted DPKG"
	echo "	15. List the configuration files for a package"
	echo "	16. Set up a proxy connection"
	echo "	17. Reset the screen"
	echo "	18. Exit"
	read choice
	case $choice in
		1) echo "Listing all packages"
			dpkg --get-selections | grep -v deinstall;;
		2) echo "Building dependencies of a package"
			read pname			
			apt-get build-dep $pname;;
		3) echo "Installing package. Enter package name"
                        read pname
                        sudo apt-get install $pname;;
		4) echo "Checking installed package. Enter package name"
                        read pname
                        apt-cache policy $pname;;
		5) echo "Upgrading package. Enter package name"
                        read pname
                        sudo apt-get --only-upgrade install $pname;;
		6) echo "Removing package and leaving config files intact. Enter package name"
                        read pname
                        sudo apt-get remove $pname;;
		7) echo "Purging package. Enter package name"
			read pname
			sudo apt-get --purge remove $pname;;
		8) echo "Listing all files of an installed package. Enter package name"
                        read pname
                        dpkg-query -L $pname;;
		9) echo "Finding information about package. Enter package name"
			read pname
			apt-cache show $pname;;
		10) echo "Displaying recently installed packages"
                        cat /var/log/dpkg.log | grep "\ install\ ";;
		11) echo "Exporting list of packages. Specify export file name"
			read fname
                        dpkg --get-selections > $fname
			echo "Exported to $fname";;
		12) echo "Importing packages. Specify filename containing list of packages."
			read fname
			dpkg --set-selections < $fname;;
		13) echo "Finding owner of file. Enter path to file"
			read fname
			ls -l $fname > own
			awk '{print $3}' own
			rm -f own;;
		14) echo "Rebuilding Database"
			mv /var/lib/dpkg/status /var/lib/dpkg/status_bkup
			cp /var/backups/dpkg.status.#.gz /var/lib/dpkg/
			gunzip -d /var/lib/dpkg/dpkg.status.#.gz 
			mv /var/lib/dpkg/dpkg.status.# /var/lib/dpkg/status
			sudo apt-get update
			cd;;
		15) echo "Listing configuration files of package. Enter package name"
			read pname
			cat /var/lib/dpkg/info/$pname.conffiles;;
		16) 	echo "Setting Proxy"
			echo "Enter the host id: "
			read hostid
			echo "Enter the port number: "
			read portno
			echo "Enter the username: "
			read hostusername
			echo "Enter the password: "
			read hostpassword
			echo "http_proxy=http://$hostusername:$hostpassword@$hostid:$portno" > tmpproxy
			echo "export http_proxy" >> tmpproxy
			cat tmpproxy >> ~/.bashrc
			rm -f tmpproxy;; 
		17) reset;;
		18)echo "Thank you for using Package Manager";;	#Exiting
		*) echo "Wrong choice. Please run again";	#Default 
	esac
done
