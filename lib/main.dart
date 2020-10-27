import 'package:flutter/material.dart';
import 'package:flutter_music_demo/util/constant_string.dart';
import 'package:get/get.dart';

import 'app/navigation/navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      getPages: AppRouter.route,
      initialRoute: homeRoute,
      defaultTransition: Transition.downToUp,
    );
  }
}
