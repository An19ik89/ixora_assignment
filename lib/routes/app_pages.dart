import 'package:get/get.dart';
import 'package:ixora_assignment/modules/galleryview/bindings/galleryview_binding.dart';
import 'package:ixora_assignment/modules/galleryview/views/galleryview_view.dart';
import 'package:ixora_assignment/modules/homeView/bindings/home_binding.dart';
import 'package:ixora_assignment/modules/homeView/views/home_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GALLERYVIEW,
      page: () => GalleryView(),
      binding: GalleryViewBinding(),
    ),
  ];
}
