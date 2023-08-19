// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controllers/controllers_binding.dart';
import 'package:wallpaper/style/app_theme.dart';
import 'package:wallpaper/ui/home_page/home_page.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: HomePage(),
    );
  }
}
