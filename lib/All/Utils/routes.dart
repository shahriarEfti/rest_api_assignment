import 'package:flutter/material.dart';

import '../AllDetailsScreen/details_screen.dart';
import '../HomeScreen/home_screen.dart';
import '../Models/detail_page_model.dart';

class Routes {
  static String homeScreen = "/homeScreen";
  static String detailsScreen = "/detailScreen";

  static MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
    final Map<String, WidgetBuilder> routes = {
      Routes.homeScreen: (context) => const HomeScreen(),
      Routes.detailsScreen: (context){
        DetailPageModel detailPageModel = routeSettings.arguments as DetailPageModel;
        return DetailsScreen(detailPageModel: detailPageModel);
      },
    };
    final WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}