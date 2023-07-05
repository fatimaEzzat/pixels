import 'package:flutter/material.dart';
import 'package:pixels/data/data_models/gallery_data_model.dart';
import 'package:pixels/presentation/screens/gallery_screens/wallpaper_details_screen.dart';
import 'package:pixels/presentation/screens/home_layout.dart';

import '../presentation/screens/auth_screens/login_screen.dart';
import '../presentation/screens/auth_screens/register_screen.dart';
import '../presentation/screens/auth_screens/splash_screen.dart';
import '../presentation/screens/btm_navbar_screens/galley_home_screen.dart';
import 'constants.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const SplashScreen();
          },
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const LoginScreen();
          },
        );
      case registerScreen:
        return MaterialPageRoute(builder: (_) {
          return const RegisterScreen();
        });
      case homeLayout:
        return MaterialPageRoute(builder: (_) {
          return const HomeLayout();
        });
      case wallpaperDetailsScreen:
        var wallpaper = routeSettings.arguments as Wallpaper;
        return MaterialPageRoute(builder: (_) {
          return WallpaperDetailsScreen(wallpaper: wallpaper);
        });
    }
    return null;
  }
}
