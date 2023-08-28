#!/bin/bash

curl -C - -o openapi.jar --url https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/6.6.0/openapi-generator-cli-6.6.0.jar
rm openapi.json
python3 main.py --docs
rm -r ../app/lib/api
java -jar openapi.jar generate -i openapi.json -g dart -o ../app/lib/api
python3 fix_api.py
