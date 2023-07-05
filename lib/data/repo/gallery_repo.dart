import 'package:dio/dio.dart';
import 'package:pixels/data/apis/gallery_api.dart';
import 'package:pixels/data/data_models/gallery_data_model.dart';

abstract class GalleryRepoInterface {
  Future<GalleryResponseModel> getWallpapers({required int page,required int  perPage});
  Future<GalleryResponseModel> searchWallpaper({required String target});

}

class GalleryRepo implements GalleryRepoInterface {
  final GalleryApi _galleryApi;

  const GalleryRepo(GalleryApi galleryApi) : _galleryApi = galleryApi;
  @override
  Future<GalleryResponseModel> getWallpapers({required int page,required int  perPage}) async{
    Map<String,dynamic> queryMap={'page':page,'per_page':perPage};
    Response response =await _galleryApi.getWallpapers(queryMap: queryMap);
   return await  GalleryResponseModel.fromJson(response.data);
  }

  @override
  Future<GalleryResponseModel> searchWallpaper({required String target}) async{
   Map<String,dynamic> targetMap={'query':target};
   Response response =await _galleryApi.searchWallpaper(targetQueryMap: targetMap);
   return await  GalleryResponseModel.fromJson(response.data);
  }

}
