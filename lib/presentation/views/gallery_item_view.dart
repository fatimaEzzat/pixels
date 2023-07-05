import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GalleryItemView extends StatelessWidget {
  final Function() onTap;
  final String imageUrl;

  const GalleryItemView({Key? key, required this.imageUrl,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
    ;
  }
}
