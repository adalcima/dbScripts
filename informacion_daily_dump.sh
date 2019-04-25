#!/bin/sh

#----------------------------------------------------------
# a simple mysql database backup script.
# version 2, updated March 26, 2011.
# copyright 2011 alvin alexander, http://alvinalexander.com
#----------------------------------------------------------
# This work is licensed under a Creative Commons 
# Attribution-ShareAlike 3.0 Unported License;
# see http://creativecommons.org/licenses/by-sa/3.0/ 
# for more information.
#----------------------------------------------------------

# (1) set up all the mysqldump variables
OUTPUT_DIR="/var/backups/mariadb/relappro_informacion"
FILE=relappro_informacion.`date +"%d%m%Y"`.sql
DBSERVER=127.0.0.1
DATABASE=relappro_informacion
USER=relapprod
PASS=R3l4pPr02017

# (2) in case you run this more than once a day, remove the previous version of the file
##unalias rm     2> /dev/null
##rm ${FILE}     2> /dev/null
##rm ${FILE}.gz  2> /dev/null

# (3) do the mysql database backup (dump)

# use this command for a database server on a separate host:
#mysqldump --opt --protocol=TCP --user=${USER} --password=${PASS} --host=${DBSERVER} ${DATABASE} > ${FILE}

# use this command for a database server on localhost. add other options if need be.
mysqldump --opt --user=${USER} --password=${PASS} ${DATABASE} > ${OUTPUT_DIR}/${FILE}

# (4) gzip the mysql database dump file
gzip ${OUTPUT_DIR}/$FILE

# (5) show the user the result
echo "${OUTPUT_DIR}/${FILE}.gz was created:" >> /opt/dbScripts/relappro_informacion.log
ls -l ${OUTPUT_DIR}/${FILE}.gz

# Delete all backups older than 7 days
find $OUTPUT_DIR -mtime +7 -exec rm -f {} \;
