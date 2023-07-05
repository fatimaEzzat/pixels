import 'package:flutter/material.dart';
import 'package:pixels/presentation/screens/btm_navbar_screens/profile_screen.dart';
import 'package:pixels/presentation/screens/btm_navbar_screens/search_wallpaper_screen.dart';
import 'package:pixels/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../shared/style/colors.dart';
import '../../shared/style/icon_broken.dart';
import 'btm_navbar_screens/galley_home_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget>  btmNavScreens = [
    const HomeScreen(),
    const SearchWallpaperScreen(),
    const ProfileScreen()
  ];
  List<String> btmNavScreensAppbarTitle = [
    'Home',
    'Search',
    'Profile'
  ];
  int index = 0;

  void updateUI(int newVal) {
    setState(() {
      index = newVal;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(context.watch<AuthProvider>().currentUser!.firstName,style: TextStyle(color: Colors.black),),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white54.withOpacity(0.8),
          elevation: 0.0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Iconly_Broken.Home,
                size: 40,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Iconly_Broken.Search,
                  size: 40,
                ),
                label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(
                  Iconly_Broken.Profile,
                  size: 40,
                ),
                label: "Profile"),
          ],
          currentIndex: index,
          onTap: updateUI),
      body: btmNavScreens[index],
    );
  }
}
