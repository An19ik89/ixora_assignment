import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:ixora_assignment/core/app_values.dart';
import 'package:ixora_assignment/core/size_config.dart';
import 'package:ixora_assignment/modules/galleryview/controllers/galleryView_controller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';


class GalleryView extends GetView<GalleryViewController> {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GalleryViewController>(
        builder: (galleryController) => SafeArea(
              child: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.grey.shade700,
                  title: const Text(AppValues.PHOTO_GALLERY_APPBAR_TITLE),
                  centerTitle: true,
                ),
                body: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    PhotoViewGallery.builder(
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        final url = galleryController
                            .recievedImageListAsArguments[index].urls!.full
                            .toString();
                        final id = galleryController
                            .recievedImageListAsArguments[index].id;
                        return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(url),
                          initialScale: PhotoViewComputedScale.contained,
                          heroAttributes:
                              PhotoViewHeroAttributes(tag: id.toString()),
                        );
                      },
                      itemCount:
                          galleryController.recievedImageListAsArguments.length,
                      loadingBuilder: (context, event) => Center(
                        child: SizedBox(
                          width: getProportionateScreenWidth(context,20.0),
                          height: getProportionateScreenHeight(context,20.0),
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                    event.expectedTotalBytes!.toInt(),
                          ),
                        ),
                      ),
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      pageController: galleryController.pageController,
                      onPageChanged: (index) =>
                          galleryController.onPageChanged(index),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              '${AppValues.IMAGE_TITLE} : ${galleryController.index + 1}/${galleryController.recievedImageListAsArguments.length}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  border: Border.all(color: Colors.blueAccent)),
                              width: getProportionateScreenWidth(context,20.0),
                              height: getProportionateScreenWidth(context,30.0),
                              child: const Center(
                                child: Text(
                                  AppValues.DOWNLOAD_TITLE,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                              ),
                            ),
                            onTap: () async {
                              try {
                                var imageId =
                                    await ImageDownloader.downloadImage(
                                        galleryController
                                            .recievedImageListAsArguments[
                                                galleryController.index]
                                            .urls!
                                            .full
                                            .toString());
                                if (imageId == null) {
                                  return;
                                }
                                Get.snackbar(AppValues.DOWNLOAD_TITLE,
                                    AppValues.DOWNLOADED_TITLE);
                              } on PlatformException catch (error) {
                                debugPrint(error.message);
                              }
                            },
                          ),
                        ),
                         SizedBox(
                          width: getProportionateScreenWidth(context,5.0),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  border: Border.all(color: Colors.blueAccent)),
                              width: getProportionateScreenWidth(context,20.0),
                              height: getProportionateScreenHeight(context,30.0),
                              child: const Center(
                                child: Text(
                                  AppValues.SHARE_BUTTON_TITLE,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                              ),
                            ),
                            onTap: () async {
                              try {
                                final box =
                                    context.findRenderObject() as RenderBox?;
                                await Share.share(
                                    galleryController
                                        .recievedImageListAsArguments[
                                            galleryController.index]
                                        .urls!
                                        .full
                                        .toString(),
                                    sharePositionOrigin:
                                        box!.localToGlobal(Offset.zero) &
                                            box.size);
                              } on PlatformException catch (error) {
                                debugPrint(error.message);
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
