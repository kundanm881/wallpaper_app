import 'package:get/get.dart';
import 'package:wallpaper/controllers/fav_controller/fav_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavController(), permanent: true);
  }
}
