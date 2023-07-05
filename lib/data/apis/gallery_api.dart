import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixels/shared/constants.dart';

import '../../network/remote/dio_helper.dart';

class GalleryApi {
  Future<dynamic> getWallpapers(
      {required Map<String, dynamic> queryMap}) async {
    var response =
        await DioHelper.getData(query: queryMap, endPoint: getPhotosEndpoint);
    return response;
  }

  Future<dynamic> searchWallpaper(
      {required Map<String, dynamic> targetQueryMap}) async {
    var response = await DioHelper.getData(
        query: targetQueryMap, endPoint: searchWallpaperEndpoint);
    print(response.data);
    return response;
  }

  Future<dynamic> addWallpaperToFavorites(
      {required Map<String, dynamic> wallpaperData,
      required String uId,
      required String wallpaperId}) async {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(uId)
        .collection(favoritesCollection)
        .doc(wallpaperId)
        .set(wallpaperData);
  }
}
