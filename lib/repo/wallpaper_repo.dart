
import 'package:wallpaper/database/model/images_model.dart';
import 'package:wallpaper/database/network/api/app_api.dart';

import '../database/network/url/app_url.dart';

class WallPaperRepository {
  static final _api = AppApi();

  static Future<ImagesModel?> getWallPaparsBySearch({String? query}) async {

    return await _api.get(url: AppUrls.search, parems: {"query": query ?? "nature", "per_page": "10"}).then((value) {
      final result = ImagesModel.fromJson(value);
      // print(result);
      return result;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  static Future<ImagesModel?> getWallpapersByCurated({int? nextPage}) async {
    int page = nextPage ?? 1;
    Map<String, String> params = {"page": page.toString(), "per_page": "30"};

    return AppApi2().get(url: AppUrls.curated,parems: params).then((value){
      final result = ImagesModel.fromJson(value);

      if (result.photos!.isEmpty) {
        throw "No More Images";
      } else {
        return result;
      }
    }).onError((error, stackTrace) {
      throw error!;
    });
    // return await _api.get(url: AppUrls.curated, parems: params).then((value) {
    //   final result = ImagesModel.fromJson(value);
    //
    //   if (result.photos!.isEmpty) {
    //     throw "No More Images";
    //   } else {
    //     return result;
    //   }
    // }).onError((error, stackTrace) {
    //   throw error!;
    // });
  }

  static Future<Photos> getWallPaperById(int id)async{
    return await _api.get(url: AppUrls.getPhoto(id)).then((value){
      final photo = Photos.fromJson(value);
      return photo;
    }).onError((error, stackTrace){
      throw error!;
    });
  }
}
