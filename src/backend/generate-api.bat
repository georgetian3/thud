py main.py --docs
java -jar .\openapi-generator-cli-6.6.0.jar generate -i .\openapi.json -g dart -o ../app/lib/api --skip-validate-spec --global-property skipFormModel=false
del openapi.json
py fix_api.py