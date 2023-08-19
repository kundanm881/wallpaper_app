
import 'package:flutter/material.dart';

import '../../../database/model/images_model.dart';
import '../../../widgets/btns/k_fav_btn.dart';

class ImageCardTile extends StatelessWidget {
  const ImageCardTile({
    super.key,
    required this.item,
    this.onClick, this.onFavClick,
  });
  final Function()? onClick;
  final Function()? onFavClick;

  final Photos item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Image.network(
              item.src!.portrait!,
              fit: BoxFit.cover,
            ),
            //
            
            Positioned(
              bottom: 10,
              right: 10,
              child: KFavBtn(
                isFav: item.liked!,
                onPressed: onFavClick
              ),
            )
          ],
        ),
      ),
    );
  }
}
