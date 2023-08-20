// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/fav_controller/fav_controller.dart';
import '../../database/model/images_model.dart';
import '../../database/sqlite/cache_manager_for_img.dart';
class WallPagerView extends StatefulWidget {
  const WallPagerView({
    super.key,
    required this.photo,
  });
  final Photos photo;

  @override
  State<WallPagerView> createState() => _WallPagerViewState();
}

class _WallPagerViewState extends State<WallPagerView> {
 
  late FavController favController;

  @override
  void initState() {
    favController = Get.find<FavController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: Center(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade300,
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.photo.liked!) {
                favController.removeImage(id: widget.photo.id!);
              } else {
                favController.addImage(photos: widget.photo);
              }
            },
            icon: GetBuilder(
              init: favController,
              builder: (controller) {
                return Icon(
                  (widget.photo.liked!)
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: (widget.photo.liked!) ? Colors.red : Colors.white,
                  size: 28,
                );
              },
            ),
          ), // download image
          IconButton(
            onPressed: () {
              Get.showSnackbar(GetSnackBar(
                message: "Comming soon",
                duration: Duration(seconds: 2),
                snackPosition: SnackPosition.TOP,
              ),);
            },
            icon: Icon(Icons.download, color: Colors.grey.shade300, size: 28),
          )
        ],
      ),
      body: Stack(
        children: [

          Container(
              height: context.height,
              width: context.width,
            color: Color(
                int.parse(widget.photo.avgColor!.replaceAll("#", "0xff"))),
            child:  Hero(
              tag: "img",
              child: Image(
                image: CachedNetworkImageProvider(
                  widget.photo.src!.portrait!,
                  cacheManager: cacheManager(widget.photo.src!.portrait!),
                ),
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  return (loadingProgress != null)
                      ? Center(
                    child: CircularProgressIndicator(
                        value: loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!),
                  )
                      : child;
                },
              ),
            ),
          ),

          // Image.network(
          //   widget.photo.src!.portrait!,
          //   height: context.height,
          //   width: context.width,
          //   fit: BoxFit.cover,
          // ),
          Positioned(
            bottom: 20,
            child: Container(
              width: context.width,
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text("set as Wallpaper".capitalize!),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),

     
    );
  }
}

