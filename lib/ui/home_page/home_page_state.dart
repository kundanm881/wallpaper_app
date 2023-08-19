import 'package:flutter/material.dart';

import 'controller/home_page.controller.dart';
import 'home_page.dart';

abstract class HomePageState extends State<HomePage> {
  final pageScaffoldKey = GlobalKey<ScaffoldState>();

  late HomePageController homePageController;

  ScrollController pageScrollController = ScrollController();

  @override
  void initState() {
   
    homePageController = HomePageController()..loadImage();

    pageScrollController.addListener(() {
      if (pageScrollController.position.maxScrollExtent ==
          pageScrollController.offset) {
        homePageController.loadMore();
      }
    });
    super.initState();
  }
}
