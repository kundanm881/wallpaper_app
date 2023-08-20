import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

class AppApi2 extends BaseApi {
  Dio _dio = Dio();

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
    try {
      Response response = await _dio
          .getUri(finalUri, options: Options(headers: headers))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response.statusMessage.toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  // download image
  Future<File> downloadImage({required String url, void Function(int count, int total)? onReceiveProgress}) async {
    final filePath = await getExternalStorageDirectory();

    Directory wallpapersDir =
        Directory(join(filePath?.path ?? "", "wallpapers"));

    if (wallpapersDir.existsSync() == false) {
      await wallpapersDir.create();
    }

    final getImageName = url.split("?").first.split("/").last;

    final savePath = join(wallpapersDir.path, getImageName);


    if(File(savePath).existsSync() == true){
      return File(savePath) ;
    }else{
     return await _dio.download(url, savePath,onReceiveProgress: onReceiveProgress).then((value){
        if(value.statusCode == 200){
          return File(savePath);
        }else{
          throw value.statusMessage!;
        }
      }).onError((error, stackTrace){
        throw error!;
      });
    }
  }
}
