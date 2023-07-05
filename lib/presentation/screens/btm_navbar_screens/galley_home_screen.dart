import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixels/presentation/views/gallery_item_view.dart';
import 'package:pixels/providers/gallery_provider.dart';
import 'package:pixels/shared/constants.dart';
import 'package:pixels/shared/utilities.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GalleryProvider _galleryProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _galleryProvider = Provider.of<GalleryProvider>(context, listen: false);
      _galleryProvider.getPaginatedGalleryItems();
      _scrollController.addListener(scrollListener);
    });
    super.initState();
  }

  scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_galleryProvider.currentPage < _galleryProvider.lastPage) {
        _galleryProvider.getPaginatedGalleryItems(getMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<GalleryProvider>(
          builder: (context, provider, _) {
            return ConditionalBuilder(
              condition: provider.wallpapers.isNotEmpty,
              builder: (context) {
                return MasonryGridView.count(
                    controller: _scrollController,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: provider.wallpapers.length,
                    itemBuilder: (context, index) {
                      return GalleryItemView(
                        onTap: (){
                          Navigator.pushNamed(context, wallpaperDetailsScreen,arguments:provider.wallpapers[index] );
                        },
                          imageUrl: provider.wallpapers[index].src!.original!);
                    });
              }, fallback: (BuildContext context) {
                return shimmerSliverGridViewEffect();
            },
            );
          },
        ),
      ),
    );
  }
}


