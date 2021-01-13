#!/bin/bash
# Generate PWPUSH URL PASSWORD
# Author: Julio Cesar Mauro (julio.mauro<at>gmail.com)
# Date: 13/01/2021

helpFunction()
{
   echo ""
   echo "Uso: $0 -p PASSWORD -d DAYS -v VIEWS"
   echo -e "\t-p Password"
   echo -e "\t-d Days to expiration"
   echo -e "\t-v Views to expiration"
   exit 1
}

while getopts "p:d:v:" opt
do
   case "$opt" in
      p ) parameterP="$OPTARG" ;;
      d ) parameterD="$OPTARG" ;;
      v ) parameterV="$OPTARG" ;;
      ? ) helpFunction ;;
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$parameterP" ] || [ -z "$parameterD" ] || [ -z "$parameterV" ]
then
   echo "Empty parameters";
   helpFunction
fi

echo "Password generated:: http://pwpush.com/p/`curl -s -X POST --data "password[payload]=$parameterP&password[expire_after_days]=$parameterD&password[expire_after_views]=$parameterV" \
 https://pwpush.com/p.json |jq -r .url_token`"
