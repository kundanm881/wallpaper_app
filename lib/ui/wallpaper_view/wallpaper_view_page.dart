import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/api_service/api_enum.dart';
import 'package:wallpaper/database/model/images_model.dart';
import 'package:wallpaper/repo/wallpaper_repo.dart';

class WallPagerView extends StatefulWidget {
  const WallPagerView({super.key, required this.id});
  final int id;

  @override
  State<WallPagerView> createState() => _WallPagerViewState();
}

class _WallPagerViewState extends State<WallPagerView> {
  late WallpaperViewController wallpaperViewController;

  @override
  void initState() {
    wallpaperViewController = WallpaperViewController();
    wallpaperViewController.loadImage(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: wallpaperViewController,
        builder: (controller) {
          if(controller.apiState == ApiState.loading){
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if(controller.apiState == ApiState.error){
            return Scaffold(body: Center(child: Text("${controller.error}")));
          }
          return Scaffold(
            // extendBodyBehindAppBar: true,
            // extendBody: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(controller.photo?.photographer ?? ""),
            ),
            body: Image.network(
              controller.photo!.src!.portrait!,
              height: context.height,
              width: context.width,
              fit: BoxFit.cover,
            ),

            bottomNavigationBar: Container(
              height: 100,
              alignment: Alignment.center,
              child: ElevatedButton(
                child: const Text("set as Wallpaper"),
                onPressed: () {},
              ),
            ),
          );
        });
  }
}

class WallpaperViewController extends GetxController {
  Photos? photo;
  ApiState apiState = ApiState.loading;
  String? error;

  loadImage(int id) async {
    await WallPaperRepository.getWallPaperById(id).then((value) {
      photo = value;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }
}
