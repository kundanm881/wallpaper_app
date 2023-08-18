// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/api_service/api_enum.dart';
import 'package:wallpaper/style/app_style.dart';

import '../wallpaper_view/wallpaper_view_page.dart';
import 'home_page_state.dart';
import 'widgets/drawer.dart';
import 'widgets/image_card_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomePageState {
  final pageScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: pageScaffoldKey,
      appBar: AppBar(
        title: Text(
          "WallPager App",
          style: AppStyle.mainAppBar,
        ),
        centerTitle: true,
      ),
      drawer: HomeDrawer(scaffoldKey: pageScaffoldKey),
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
                    return ImageCardTile(
                      item: item,
                      onClick: () {
                        Get.to(() => WallPagerView(id: item.id!));
                      },
                    );
                  },
                ),
              ),
              // more Loading
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
