#!/bin/bash
# Copyright 2018, Oracle and/or its affiliates. All rights reserved.

echo "$(date +%H:%M:%S): Running the Parse and Upload OWASP Report wercker Step"

#
# Check for required dependencies
#

if [ -n "$JAVA_HOME" ] ; then
  if [ ! -x "$JAVA_HOME/bin/java" ] ; then
      echo "$(date +%H:%M:%S): ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME"
      exit 1
  fi
else
  echo "$(date +%H:%M:%S): Please ensure Java is installed and JAVA_HOME set correctly"
  exit 1
fi

hash curl 2>/dev/null || { echo "$(date +%H:%M:%S): curl is required, install curl before this step."; exit 1; }

hash unzip 2>/dev/null || { echo "$(date +%H:%M:%S): unzip is required, install unzip before this step"; exit 1; }

echo "$(date +%H:%M:%S): Parse and Upload OWASP Report requirements complete"

#
# Proxy information when available [IFF proxy server then include proxy port]
#
if [[ -z "$HTTPS_PROXY_SERVER" ]]; then
  CURL_PROXY=""
  CHECK_PROXY=""
  echo "$(date +%H:%M:%S): A proxy will not be used"
else
  CURL_PROXY="--proxy $HTTPS_PROXY_SERVER:$HTTPS_PROXY_PORT"
  CHECK_PROXY="--proxyserver $HTTPS_PROXY_SERVER --proxyport $HTTPS_PROXY_PORT"
fi

#
# Check if required libraries are available
# Currently it assumes the required libraries are copied to WERCKER_CACHE_DIR in previous steps
# Later if these libraries are downloadable, this can be changed to check and download required libraries.

#
# Parse dependency-check-report.json to generate occurrences and upload to grafeas server
#
PARSE_CMD="java -classpath $CLASSPATH generateOccurrences $DEPENDENCY_REPORT_FILE $URL_GRAFEAS"
echo "$(date +%H:%M:%S): Parse dependency-check-report.json to generate occurrences and upload to grafeas server with command:"
echo "% $PARSE_CMD"
$PARSE_CMD

echo "$(date +%H:%M:%S): Generated occurrences from OWASP dependency-check report"
