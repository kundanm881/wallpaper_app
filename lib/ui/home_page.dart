// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/api_service/api_enum.dart';
import 'package:wallpaper/repo/wallpaper_repo.dart';

import '../database/model/images_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController homePageController;
  ScrollController pageScrollController = ScrollController();

  @override
  void initState() {
    homePageController = HomePageController()..loadImage();

    pageScrollController.addListener(() {
      if (pageScrollController.position.maxScrollExtent == pageScrollController.offset) {
        homePageController.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WallPager App"),
      ),
      body: GetBuilder(
        init: homePageController,
        builder: (controller) {
          if (controller.apiState == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.apiState == ApiState.error) {
            return Center(child: Text(controller.error.toString()));
          }
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: pageScrollController,
                  padding: EdgeInsets.all(8),
                  itemCount: controller.data!.photos!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 280,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.data!.photos![index];
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        item.src!.portrait!,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              if (controller.loadMoreState == ApiState.loading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              else if (controller.loadMoreState == ApiState.error)
                Center(child: Text(controller.loadError.toString())),
            ],
          );
        },
      ),
    );
  }
}

class HomePageController extends GetxController {
  ImagesModel? data;
  String? error;
  ApiState apiState = ApiState.loading;
  ApiState? loadMoreState;
  String? loadError;

  loadImage() async {
    await WallPaperRepository.getWallPaparsByCurated(nextPage: 1).then((value) {
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

      await WallPaperRepository.getWallPaparsByCurated(nextPage: data!.page! + 1).then((value) {
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
