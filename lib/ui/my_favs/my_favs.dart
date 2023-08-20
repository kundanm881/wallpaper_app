// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controllers/fav_controller/fav_controller.dart';
import 'package:wallpaper/database/model/images_model.dart';
import 'package:wallpaper/style/app_style.dart';

import '../home_page/widgets/image_card_tile.dart';
import '../wallpaper_view/wallpaper_view_page.dart';

class MyFavPage extends StatefulWidget {
  const MyFavPage({super.key});

  @override
  State<MyFavPage> createState() => _MyFavPageState();
}

class _MyFavPageState extends State<MyFavPage> {
  late FavController favController;

  @override
  void initState() {
    favController = Get.find<FavController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorites", style: AppStyle.mainAppBar),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: favController,
        builder: (controller) {
          if (controller.favImages == null || controller.favImages!.isEmpty) {
            return Center(child: Text("No favorites to show"));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: controller.favImages!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 280,
              ),
              itemBuilder: (context, index) {
                final item = controller.favImages![index];
                final Photos photo = Photos(
                  id: item.id,
                  width: item.width,
                  height: item.height,
                  url: item.url,
                  avgColor: item.avgColor,
                  photographer: item.photographer,
                  photographerId: item.photographerId,
                  photographerUrl: item.photographerUrl,
                  src: Src(portrait: item.src.portrait),
                  liked: item.liked,
                  alt: item.alt,
                );


                return ImageCardTile(
                  item: photo,
                  onClick: () async {
                    Get.to(() => WallPagerView(photo: photo));
                  },
                  onFavClick: () async {
                    controller.removeImage(id: item.id);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
