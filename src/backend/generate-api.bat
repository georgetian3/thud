curl -C - -o openapi.jar --url https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/6.6.0/openapi-generator-cli-6.6.0.jar
py main.py --docs
java -jar .\openapi.jar generate -i .\openapi.json -g dart -o ../app/lib/api --skip-validate-spec --global-property skipFormModel=false
del openapi.json
py fix_api.py