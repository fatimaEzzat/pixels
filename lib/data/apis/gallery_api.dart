import 'package:pixels/shared/constants.dart';

import '../../network/remote/dio_helper.dart';

class GalleryApi {
  Future<dynamic> getWallpapers(
      {required Map<String, dynamic> queryMap}) async {
    var response =
        await DioHelper.getData(query: queryMap, endPoint: getPhotosEndpoint);
    return response;
  }
}
