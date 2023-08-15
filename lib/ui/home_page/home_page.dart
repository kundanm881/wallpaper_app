// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/api_service/api_enum.dart';
import 'package:wallpaper/ui/wallpaper_view/wallpaper_view_page.dart';

import 'home_page_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomePageState {


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
                    return GestureDetector(
                      onTap: (){
                        // print(item.id.runtimeType);
                        Get.to(()=> WallPagerView(id: item.id!));
                      },
                      child: Card(
                        clipBehavior: Clip.hardEdge,

                        child: Image.network(
                          item.src!.portrait!,
                          fit: BoxFit.cover,
                        ),
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

