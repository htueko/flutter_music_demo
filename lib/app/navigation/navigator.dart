import 'package:flutter_music_demo/view/error/error_view.dart';
import 'package:flutter_music_demo/view/home/home_view.dart';
import 'package:get/get.dart';

const homeRoute = '/homeRoute';
const errorRoute = '/errorRoute';

class AppRouter {
  static var route = [
    GetPage(name: homeRoute, page: () => HomeView()),
    GetPage(name: errorRoute, page: () => ErrorView()),
  ];
}
