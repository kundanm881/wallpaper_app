import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../database/model/images_model.dart';
import '../../../database/sqlite/cache_manager_for_img.dart';
import '../../../widgets/btns/k_fav_btn.dart';

class ImageCardTile extends StatefulWidget {
  const ImageCardTile({
    super.key,
    required this.item,
    this.onClick,
    this.onFavClick,
  });

  final Function()? onClick;
  final Function()? onFavClick;

  final Photos item;

  @override
  State<ImageCardTile> createState() => _ImageCardTileState();
}

class _ImageCardTileState extends State<ImageCardTile>
    with TickerProviderStateMixin {
  // late Animation animation;
  // Tween<double> saleTween = Tween<double>();

  @override
  void initState() {
    // animation = A
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Container(
              height: 280,
              width: double.maxFinite,
              color: Color(
                  int.parse(widget.item.avgColor!.replaceAll("#", "0xff"))),
              child: Hero(
                tag: widget.item.src!.portrait!,
                child: Image(
                  image: CachedNetworkImageProvider(
                    widget.item.src!.portrait!,
                    cacheManager: cacheManager(widget.item.src!.portrait!),
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
            //

            Positioned(
              bottom: 10,
              right: 10,
              child: KFavBtn(
                  isFav: widget.item.liked!, onPressed: widget.onFavClick),
            )
          ],
        ),
      ),
    );
  }
}
