#!/bin/sh
# Convert a DBase database file to SQLite3 to ease it's management
# Author: Ben Cessa <ben@pixative.com>
#
# Parameters:
#	1.- The dbase file to convert
#	2.- The name of the resultant sqlite3 file and table

# Check for the actual number of parameters
if [ $# != 2 ]; then
	printf "\e[31mERROR >> \e[0mThe requiered parameters are: DBase File and result filename\n\n"
else
	# Get the database contents in CSV format ready for import
	dbview -btd '|' $1 | sed 's/.$//g' > `dirname $1`'/'$2.records

	# OK some serious nested processing here :D, it will do the following:
	# 1.- Get the database information
	# 2.- Remove the header line
	# 3.- Keep only the field names
	# 4.- Remove any 'tab' character from the names
	# 5.- Concatenate all the names using ',' as the separator
	# 6.- Remove the last ',' char from the string
	FIELDS=`dbview -ero $1 | sed 1d | cut -d' ' -f1 | tr -d '\t' | tr '\n' ',' | sed 's/.$//'`

	# Create the SQLite3 database file and import the CSV data
	sqlite3 `dirname $1`'/'$2.db "CREATE TABLE $2($FIELDS)"
	echo ".import "`dirname $1`'/'"$2.records $2" | sqlite3 `dirname $1`'/'$2.db

	# Delete temporal files
	rm `dirname $1`'/'$2.records
fi
