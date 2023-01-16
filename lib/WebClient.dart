import 'package:http/http.dart' as http;
import 'ResponseParser.dart';
import 'dart:convert';

class WebClient {
  /// Used to get the url and the strategies
  Future<List<String>> getInfo(String url) async {
    var response = await http.get(url);
    var info = json.decode(response.body);
    var strats = ResponseParser().parseInfo(info);
    var list = <String>[];
    list.add(strats[0]);
    list.add(strats[1]);
    return list;
  }
}