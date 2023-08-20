import 'package:wallpaper/database/network/api/secretes.dart';

abstract class BaseApi {
  final headers = {AppSecretes.pixelsApiKeyType: AppSecretes.pixelsApiKey};

  Future get({required String url});
}
