import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pixels/data/data_models/gallery_data_model.dart';
import 'package:pixels/providers/gallery_provider.dart';
import 'package:pixels/shared/style/icon_broken.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../network/local/cache_helper.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/utilities.dart';

class WallpaperDetailsScreen extends StatelessWidget {
  final Wallpaper wallpaper;

  const WallpaperDetailsScreen({Key? key, required this.wallpaper})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverLayoutBuilder(
              builder: (BuildContext context, SliverConstraints constraints) {
            final scrolled = constraints.scrollOffset > 100;
            return SliverAppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height * 0.7,
              pinned: true,
              stretch: true,
              centerTitle: true,
              title: Text(
                wallpaper.alt!,
                style: TextStyle(
                    color: scrolled ? Colors.black : Colors.transparent),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  child: CachedNetworkImage(
                    imageUrl: wallpaper.src!.original!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: BackButton(),
              ),
              actions: [
                Consumer<GalleryProvider>(
                  builder: (context, provider, child) {
                    return InkWell(
                      onTap: () {
                        provider.toggleFavorite(id: wallpaper.id.toString());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 16.0,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.favorite,
                            color: CacheHelper.getBool(
                                    key: wallpaper.id.toString())
                                ? Colors.red
                                : MyColors.greyTextColor,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          }),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                wallpaper.alt!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Color',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: getColorFromHex(wallpaper.avgColor!),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Size',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            wallpaper.width!.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'x',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            wallpaper.height!.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: InkWell(
          //     onTap: ()async{
          //       if (!await launchUrl(Uri.parse(wallpaper.photographerUrl!))) {
          //       throw Exception('Could not launch');
          //       }
          //
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Row(
          //         children: [
          //           Icon(Iconly_Broken.Edit_Square),
          //           SizedBox(
          //             width: 10.0,
          //           ),
          //           Text(
          //             'Click to visit photographer profile',
          //             style: Theme.of(context).textTheme.titleLarge,
          //           ),
          //
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
// Future<void> _launchUrl({required String url}) async {
//   final Uri _url = Uri.parse(url);
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $_url');
//   }
// }
