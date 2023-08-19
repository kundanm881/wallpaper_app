// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class KFavBtn extends StatelessWidget {
  const KFavBtn({
    super.key,
    required this.onPressed, required this.isFav,
  });

  final Function()? onPressed;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(100),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child:  Padding(
            padding: EdgeInsets.all(6),
            child: Icon(
              (isFav == true)?Icons.favorite_rounded: Icons.favorite_border_rounded,
              color: (isFav == true)?Colors.red: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
