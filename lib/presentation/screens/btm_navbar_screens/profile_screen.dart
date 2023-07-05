import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixels/presentation/widgets/default_button_widget.dart';
import 'package:pixels/presentation/widgets/user_info_widget.dart';
import 'package:pixels/providers/auth_provider.dart';
import 'package:pixels/shared/style/colors.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants.dart';
import '../../../shared/utilities.dart';
import '../../views/gallery_item_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfo(),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Favorites',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Consumer<AuthProvider>(
                builder: (context, provider, _) {
                  return ConditionalBuilder(
                    condition: provider.favWallpaper.isNotEmpty,
                    builder: (context) {
                      return MasonryGridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          itemCount: provider.favWallpaper.length,
                          itemBuilder: (context, index) {
                            return GalleryItemView(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, wallpaperDetailsScreen,
                                      arguments: provider.favWallpaper[index]);
                                },
                                imageUrl:
                                    provider.favWallpaper[index].src!.original);
                          });
                    },
                    fallback: (BuildContext context) {
                      if (provider.listenSate == ListenDataSates.loading) {
                        return shimmerSliverGridViewEffect();
                      } else {
                        return Center(child: Text('Empty yet !'),);
                      }
                      },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
