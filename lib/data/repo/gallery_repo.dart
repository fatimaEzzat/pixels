import 'package:dio/dio.dart';
import 'package:pixels/data/apis/gallery_api.dart';
import 'package:pixels/data/data_models/gallery_data_model.dart';

abstract class GalleryRepoInterface {
  Future<List<Wallpaper>> getWallpapers ();

}

class GalleryRepo implements GalleryRepoInterface {
  final GalleryApi _galleryApi;

  const GalleryRepo(GalleryApi galleryApi) : _galleryApi = galleryApi;
  @override
  Future<List<Wallpaper>> getWallpapers() async{
    Response response =await _galleryApi.getWallpapers();
    List<Wallpaper>.from(response.data.map((json) => Wallpaper.fromJson(json)));
   return await  response.data['photos'];
  }

}
