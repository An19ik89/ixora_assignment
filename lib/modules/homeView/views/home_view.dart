import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ixora_assignment/core/app_values.dart';
import 'package:ixora_assignment/core/size_config.dart';
import 'package:ixora_assignment/core/strings.dart';
import 'package:ixora_assignment/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (homeController) => SafeArea(
                child: Scaffold(
                    body: CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              controller: homeController.scrollController,
              slivers: [
                SliverAppBar(
                  floating: false,
                  expandedHeight: getProportionateScreenHeight(context, 120.0),
                  flexibleSpace: FlexibleSpaceBar(
                    title: InkWell(
                      child: const Text(AppStrings.HOME_APPBAR_TITLE),
                      onTap: () {
                        Get.toNamed(Routes.TESTVIEW);
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(15.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return InkWell(
                          child: SizedBox(
                            width: getProportionateScreenHeight(context,200),
                            height: getProportionateScreenWidth(context,200),
                            child: CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                size: 20.0,
                                color: Colors.redAccent,
                              ),
                              fadeInCurve: Curves.bounceOut,
                              fadeInDuration: const Duration(seconds: 3),
                              imageUrl: homeController
                                  .rxPhotoResponseModelList[index].urls!.regular
                                  .toString(),
                              fit: BoxFit.fill,
                            ),
                          ),
                          onTap: () => homeController.openPhotoView(index),
                        );
                      },
                      childCount:
                          homeController.rxPhotoResponseModelList.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2.0,
                    ),
                  ),
                ),
              ],
            ))));
  }
}
