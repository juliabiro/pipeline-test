#!/bin/bash
set -euo pipefail

while IFS= read -r var
do
    export "$var"
done < repo_conf
apikey=`cat $apikey_file`

cat >xmlFixer.xsl<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="@*|node()">
<xsl:copy>
<xsl:apply-templates select="@*|node()"/>
</xsl:copy>
</xsl:template>
<xsl:template match="url/text()">$repo_url</xsl:template>
<xsl:template match="credentialsId/text()">$repo_creds_name</xsl:template>
</xsl:stylesheet>
EOF


xsltproc xmlFixer.xsl config.xml >config_tmp.xml

ret=`curl -X GET -I -s -H "Content-Type:application/xml" --user $apikey "https://$master_url/job/$jobname/config.xml"|grep HTTP|egrep -o [0-9]{3}`

if [ "$ret" == "404" ]; then
    curl -X POST -H "Content-Type:application/xml" --user $apikey --data-binary @config_tmp.xml "https://$master_url/createItem?name=$jobname"
else
    if [ "$ret" == "200" ]; then
    curl -X POST -H "Content-Type:application/xml" --user $apikey --data-binary @config_tmp.xml "https://$master_url/job/$jobname"
    fi
fi

rm config_tmp.xml
rm xmlFixer.xsl
