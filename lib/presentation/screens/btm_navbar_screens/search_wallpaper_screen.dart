import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../providers/gallery_provider.dart';
import '../../../shared/utilities.dart';
import '../../views/gallery_item_view.dart';

class SearchWallpaperScreen extends StatelessWidget {
  const SearchWallpaperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: searchController,
                onSubmitted: (String value) {
                  context
                      .read<GalleryProvider>()
                      .searchWallpaper(target: searchController.text);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      searchController.clear();
                      context.read<GalleryProvider>().clearUsersSearch(
                          emitted: searchController.text.isNotEmpty);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  hintText: 'Search',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: context.watch<GalleryProvider>().state ==
                  GalleryStates.loading,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            // Consumer<GalleryProvider>(
            //   builder: (context, provider, _) {
                 ConditionalBuilder(
                  condition: context.watch<GalleryProvider>().searchUiDisplayedWallpapers.isNotEmpty,
                  builder: (context) {
                    return Expanded(
                      child: MasonryGridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          itemCount:
                          context.watch<GalleryProvider>().searchUiDisplayedWallpapers.length,
                          itemBuilder: (context, index) {
                            return GalleryItemView(
                                imageUrl: context.watch<GalleryProvider>()
                                    .searchUiDisplayedWallpapers[index]
                                    .src!
                                    .original!);
                          }),
                    );
                  },
                  fallback: (BuildContext context) {
                    return shimmerSliverGridViewEffect();
                  },
                )
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
