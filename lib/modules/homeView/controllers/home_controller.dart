import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ixora_assignment/api/repository/get_photos_repository.dart';
import 'package:ixora_assignment/core/app_values.dart';
import 'package:ixora_assignment/data/model/photoresponse.dart';
import 'package:ixora_assignment/routes/app_pages.dart';


class HomeController extends GetxController {

  final PhotoRepository photoRepository = Get.find();
  late RxList<PhotoResponseModel> rxPhotoResponseModelList;
  ScrollController scrollController = ScrollController();
  int listLength = 16;
  int pageNumber = 1;
  RxInt connectionType = 0.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription ;

  @override
  void onInit(){
    super.onInit();
    GetConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
    rxPhotoResponseModelList = <PhotoResponseModel>[].obs;
  }


  @override
  void onClose() {
    _streamSubscription.cancel();
  }



  Future<void>GetConnectionType() async{
    var connectivityResult;
    try{
      connectivityResult = await (_connectivity.checkConnectivity());
    }on PlatformException catch(e){
      debugPrint(e.message);
    }
    return _updateState(connectivityResult);
  }
  _updateState(ConnectivityResult result)
  {
    switch(result)
    {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        getAllPhotoList(connectionType.value);
       addItems();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        getAllPhotoList(connectionType.value);
        addItems();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        getAllPhotoListWithHive(connectionType.value);
        break;
      default: Get.snackbar(AppValues.NETWORK_ERROR_TITLE, AppValues.NETWORK_STATUS_MESSAGE);
      break;
    }
  }

  getAllPhotoList(int connectionType) async {
    rxPhotoResponseModelList.value = await photoRepository.getAllPhotoListRepository(pageNumber,listLength,connectionType);
    update();
  }

  getAllPhotoListWithHive(int connectionType) async {
    rxPhotoResponseModelList.clear();
    rxPhotoResponseModelList.value = await photoRepository.getAllPhotoListFromHiveRepository();
    update();
  }

  addItems() async {
    scrollController.addListener(() async {
      if (scrollController.offset == scrollController.position.maxScrollExtent) {
        pageNumber++;
        List<PhotoResponseModel> newItems = [];
        newItems.addAll( await photoRepository.getAllPhotoListRepository(pageNumber,listLength,1));
        rxPhotoResponseModelList+=newItems;
        update();
      }
    });
  }

  openPhotoView(int index) {
    connectionType.value == 0 ? Get.snackbar(AppValues.NETWORK_ERROR_TITLE,AppValues.NO_INTERNET_MESSAGE,snackPosition: SnackPosition.BOTTOM) :
    Get.toNamed(Routes.GALLERYVIEW, arguments: [
      {"imageList": rxPhotoResponseModelList},
      {"index": index},
    ]);
  }
}
