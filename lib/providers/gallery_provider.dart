import 'package:flutter/material.dart';
import 'package:pixels/data/apis/gallery_api.dart';
import 'package:pixels/data/data_models/gallery_data_model.dart';
import 'package:pixels/data/repo/gallery_repo.dart';

import '../network/local/cache_helper.dart';
import '../shared/utilities.dart';
enum GalleryStates { init, loading,loadingMore, success, error ,clear }
class GalleryProvider with ChangeNotifier{

  final _galleryRepo = GalleryRepo(GalleryApi());

  GalleryStates state=GalleryStates.init;

  void setDataState({required GalleryStates dateState}){
    this.state=dateState;
    notifyListeners();
  }

  List<Wallpaper> wallpapers = [];

  int currentPage = 1;
  int lastPage = 20;
  int perPage = 10;

  Future<void> getPaginatedGalleryItems({
    bool getMore = false,
  }) async {
    if (getMore) {
      currentPage++;
      setDataState(dateState: GalleryStates.loadingMore);
    } else {
      currentPage = 1;
      setDataState(dateState: GalleryStates.loading);
    }
    _galleryRepo
        .getWallpapers(
        page: currentPage,
        perPage: perPage)
        .then((GalleryResponseModel value) {
      if (value.wallpapers.isNotEmpty) {
        if (getMore) {
          wallpapers.addAll(value.wallpapers);
          print('getMore');
        } else {
          wallpapers = value.wallpapers;
        }
        setDataState(dateState: GalleryStates.success);
      } else {
        if (!getMore) {
          setDataState(dateState: GalleryStates.error);
        }
      }
    }).catchError((onError) {
      setDataState(dateState: GalleryStates.error);
      printDebug('getCategories error: $onError}');
    });
  }


  List<Wallpaper> searchResultList = [];

  List<Wallpaper> get searchUiDisplayedWallpapers =>
      searchResultList.isEmpty ? wallpapers : searchResultList;

  Future<void> searchWallpaper({required String target}) async {
    setDataState(dateState: GalleryStates.loading);
    try {
      var response = await _galleryRepo.searchWallpaper(target: target);
      searchResultList = response.wallpapers;
      setDataState(dateState: GalleryStates.success);
    } catch (e) {
      setDataState(dateState: GalleryStates.error);
    }
  }


  void clearUsersSearch({bool emitted = false}) {
    searchResultList = [];
    if (emitted)setDataState(dateState: GalleryStates.clear);
  }

  bool isFav =false;
  void toggleFavorite({required String id}) async {
    isFav = !isFav;
    await CacheHelper.saveData(key: id, value: isFav);
    print('saveddd');
    setDataState(dateState: GalleryStates.success);
  }
}