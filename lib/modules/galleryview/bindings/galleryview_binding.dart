import 'package:get/get.dart';

import '../controllers/galleryview_controller.dart';

class GalleryViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryViewController>(
      () => GalleryViewController(),
    );
  }
}
