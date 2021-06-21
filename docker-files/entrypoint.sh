#!/bin/sh
FILE=/var/www/finance/.env
if ! test -f "$FILE"; then
    
    for s in $( echo ${SECRETS} | jq -r "to_entries|map(\"\(.key)\")|.[]"); 
    do echo $s=\$\{$s\} >> $FILE;
    done
    
fi

for s in $( echo ${SECRETS} | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]"); 
do export $s; 
done 

nginx;