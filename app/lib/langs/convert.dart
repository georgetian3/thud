import 'dart:io';
import 'package:csv/csv.dart';

String escape(String str) {
  str = str.replaceAll(RegExp('\''), '\\\'');
  str = str.replaceAll(RegExp(r'\$'), '\\\$');
  return str;
}

void convert({String fileIn = 'translations.csv', String fileOut = 'translations.dart', String format = 'dart'}) {
  String fileString = File(fileIn).readAsStringSync();

  List<List<String>> csv = const CsvToListConverter().convert(fileString);

  Map<String, Map<String, String>> translations = {
    for (int lang = 1; lang < csv[0].length; lang++)
      csv[0][lang]: {
        for (int key = 1; key < csv.length; key++)
          csv[key][0]: csv[key][lang]
      }
  };


  Iterable<String> keys = translations.values.first.keys;
  Iterable<String> langs = translations.keys;

  for (String lang in langs) {
    File('app_$lang.arb').writeAsStringSync('{}');
  }

  String out = 'Map<String, Map<String, String>> translations = {';
  for (String lang in langs) {
    out += '\n  \'$lang\': {';
    for (String key in keys) {
      out += '\n    \'$key\': \'${escape(translations[lang]![key]!)}\',';

    }
    out += '\n  },';
  }
  out += '\n};';

  File(fileOut).writeAsStringSync(out);

}


void main() {
  convert();
}