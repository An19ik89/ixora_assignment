import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:ixora_assignment/data/model/photoresponse.dart';


class GalleryViewController extends GetxController {

  late PageController pageController;
  late List<PhotoResponseModel> recievedImageListAsArguments = <PhotoResponseModel>[];
  late int index;


  @override
  void onInit() {
    super.onInit();
    recievedImageListAsArguments = Get.arguments[0]["imageList"];
    index = Get.arguments[1]["index"];

    pageController = PageController(initialPage: index);
  }

  @override
  void onClose() {}

  onPageChanged(int ind){
    index = ind;
    update();
  }

}
