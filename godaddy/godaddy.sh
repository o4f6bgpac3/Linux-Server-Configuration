#!/bin/bash
# This script checks and automatically updates your GoDaddy DNS "A" record server with your current IP address.
# by Marius Bogdan Lixandru updated to make it work with Synology NAS for users with Dynamic IP.
domain=$Domain   # Your own domain name
name="*"     # name of A record to update

source /srv/config/godaddy.txt

key=$Key     # Your own GoDaddy developer API Key See STEP 4
secret=$Secret   # Your own GoDaddy developer API Secret Key See STEP 4

headers="Authorization: sso-key $key:$secret"

# echo $headers

result=$(curl -s -X GET -H "$headers" \
 "https://api.godaddy.com/v1/domains/$domain/records/A/$name")

#echo $result;

dnsIp=$(echo $result | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
#echo "dnsIp:" $dnsIp

# Get public IP address. There are several websites that can do this.
ret=$(curl -s GET "https://ipinfo.io/json")
currentIp=$(echo $ret | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")


#echo "currentIp:" $currentIp

if [ "$dnsIp" != "$currentIp" ];
 then
#       echo "Ips are not equal"
        request='[{"data":"'$currentIp'","ttl":600}]'
#       echo " request:" $request
        nresult=$(curl -i -s -X PUT \
 -H "$headers" \
 -H "Content-Type: application/json" \
 -d $request "https://api.godaddy.com/v1/domains/$domain/records/A/$name")
#       echo "result:" $nresult
fi
