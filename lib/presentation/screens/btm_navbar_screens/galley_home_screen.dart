import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixels/data/apis/gallery_api.dart';
import 'package:pixels/data/repo/gallery_repo.dart';
import 'package:pixels/presentation/views/gallery_item_view.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // GalleryRepo(GalleryApi()).getWallpapers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            itemCount: 10,
            itemBuilder: (context, index) {
              return GalleryItemView(imageUrl: 'https://images.pexels.com/photos/17366673/pexels-photo-17366673.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800');
            }),
      ),
    );
  }
}


