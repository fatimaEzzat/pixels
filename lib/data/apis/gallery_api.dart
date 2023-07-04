import 'package:pixels/shared/constants.dart';

import '../../network/remote/dio_helper.dart';

class GalleryApi{

  Future<dynamic> getPhotos() async {
    var response = await DioHelper.getData(
        endPoint: getPhotosEndpoint);
    print("response: ${response.data.toString()}");
    return response;
  }
}