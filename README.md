DBase to SQLite Converter
=========================

So, long story short. Working on a project recently I needed to convert some legacy 
dbase files to a more portable and easy to use format like SQLite. I look a lot on the 
web but nothing I found was quite the thing required, so using the GREAT dbview 
application I wrote a little ( like 5 lines with out the comments and stuff ) bash 
script to do just that.

I decided to make it publicly available just is case someone else is having this same unusual problem.

First thing first, remember to install the dependencies just if not already there:

	sudo apt-get install dbview sqlite3

How to use it
-------------

	dbftosql.sh DBASE.dbf sqlname

That's it, it will create a SQLite3 database file called 'sqlname' and a table of the same name.

Have fun!
