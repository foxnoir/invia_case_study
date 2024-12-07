import 'dart:convert';
import 'dart:io';

dynamic parseJson({required String filePath}) {
  final file = File(filePath).readAsStringSync();
  final parsedJson = jsonDecode(file);
  return parsedJson;
}
