// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    print(scaffoldKey.currentState?.isDrawerOpen);

    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          ListTile(
            dense: true,
            style: ListTileStyle.drawer,
            leading: Icon(Icons.favorite_border_rounded),
            title: Text("Favorites"),
            onTap: () => _checkDrawer(
              postCallBack: () {
                print("object");
              },
            ),
          ),
          ListTile(
            dense: true,
            style: ListTileStyle.drawer,
            leading: Icon(CupertinoIcons.settings),
            title: Text("settings"),
            onTap: () => _checkDrawer(postCallBack: () {}),
          )
        ],
      )),
    );
  }

  void _checkDrawer({required Function postCallBack}) {
    if (scaffoldKey.currentState != null) {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        Get.back();
        postCallBack();
      }
    }
  }
}
