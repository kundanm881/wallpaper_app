// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/database/sqlite/app_db.dart';
import 'package:wallpaper/style/app_theme.dart';
import 'package:wallpaper/ui/home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await AppDb.init;

  db.insertFav();

  print(await db.getFavs());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: HomePage(),
    );
  }
}
