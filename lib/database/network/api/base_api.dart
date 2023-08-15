import 'package:wallpaper/database/network/api/secretes.dart';

abstract class BaseApi {
  final headers = {AppSecretes.pexelsApiKeyType: AppSecretes.pexelsApiKey};

  Future get({required String url});
}
