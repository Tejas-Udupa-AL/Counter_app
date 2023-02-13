import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class QuotesService {
  static const _url = 'https://type.fit/api/quotes';

  static Future<String> requestQuote() async {
    var url = Uri.parse(_url);
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        var quote = decodedData[Random().nextInt(100)]['text'];
        return quote;
      } else {
        return 'failed to retrive quotes res: ${response.statusCode}';
      }
    } catch (e) {
      return 'failed to retrive quotes';
    }
  }
}
