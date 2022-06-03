import 'dart:convert';

import 'package:http/http.dart' as http;

class Repository {
  final _baseUrl = 'https://api.quran.sutanlab.id/surah/';

  Future getData(int surah, int ayat) async {
    String req = _baseUrl + "/" + surah.toString() + "/" + ayat.toString();
    try {
      final response = await http.get(Uri.parse(req));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        return (data['data']['tafsir']['id']['short']);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
