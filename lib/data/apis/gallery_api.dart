import 'package:pixels/shared/constants.dart';

import '../../network/remote/dio_helper.dart';

class GalleryApi{

  Future<dynamic> getWallpapers() async {
    var response = await DioHelper.getData(
        endPoint: getPhotosEndpoint);
    return response;
  }
}