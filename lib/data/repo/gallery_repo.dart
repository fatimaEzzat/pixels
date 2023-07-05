import 'package:dio/dio.dart';
import 'package:pixels/data/apis/gallery_api.dart';
import 'package:pixels/data/data_models/gallery_data_model.dart';

abstract class GalleryRepoInterface {
  Future<GalleryResponseModel> getWallpapers({required int page,required int  perPage});

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

}
