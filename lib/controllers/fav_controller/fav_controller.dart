import 'package:get/get.dart';
import 'package:wallpaper/database/model/images_model.dart';
import 'package:wallpaper/database/model/my_fav_images.model.dart';
import 'package:wallpaper/database/sqlite/app_db.dart';

class FavController extends GetxController {
  late AppDb _db;
  List<FavImageModel>? favImages;

  FavController() {
    _getAppDb();
  }

  void _getAppDb() async {
    _db = await AppDb.init;
    await _getAllImages();
  }

  _getAllImages() async {
    var img = await _db.getAllFavs();
    favImages = _cnv(img);
    // print(favImages);
    update();
  }

  addImage({required Photos photos}) async {
    await _db.insertFav(photo: photos);
    await _getAllImages();
  }

  removeImage({required int id}) async {
    await _db.removeFav(id: id);
    await _getAllImages();
  }

  List<FavImageModel> _cnv(var images) {
    List<FavImageModel> faveimg = [];
    for (var element in images) {
      final img = FavImageModel.fromJson(element);
      faveimg.add(img);
    }
    return faveimg;
  }
}
