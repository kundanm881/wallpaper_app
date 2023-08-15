
import 'package:get/get.dart';
import 'package:kd_utils/api_service/api_enum.dart';

import '../../../database/model/images_model.dart';
import '../../../repo/wallpaper_repo.dart';

class HomePageController extends GetxController {
  ImagesModel? data;
  String? error;
  ApiState apiState = ApiState.loading;
  ApiState? loadMoreState;
  String? loadError;

  loadImage() async {
    await WallPaperRepository.getWallpapersByCurated(nextPage: 1).then((value) {
      data = value;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }

  loadMore() async {
    if (data != null) {
      loadMoreState = ApiState.loading;
      update();

      await WallPaperRepository.getWallpapersByCurated(nextPage: data!.page! + 1).then((value) {
        if (value != null) {
          data?.page = value.page;
          data?.photos!.addAll(value.photos!.toList());
          data?.nextPage = value.nextPage;
        }
        loadMoreState = ApiState.success;
      }).onError((error, stackTrace) {
        loadError = error.toString();
        loadMoreState = ApiState.error;
      });
      update();
    }
  }
}
