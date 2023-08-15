import 'dart:convert';

import 'package:wallpaper/database/network/api/base_api.dart';
import 'package:http/http.dart' as http;

class AppApi extends BaseApi {
  @override
  Future get({required String url, Map<String, String>? parems}) async {
    Uri newUrl = Uri.parse(url);

    late Uri finalUri;
    if (parems != null) {
      finalUri = Uri(
        scheme: newUrl.scheme,
        host: newUrl.host,
        path: newUrl.path,
        queryParameters: parems,
      );
    } else {
      finalUri = newUrl;
    }

    http.Request request = http.Request("GET", finalUri);
    request.headers.addAll(headers);

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final result = json.decode(await response.stream.bytesToString());
        return result;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      rethrow;
    }
  }
}
