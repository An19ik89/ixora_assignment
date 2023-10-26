import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/galleryview_controller.dart';

class GalleryView extends GetView<GalleryViewController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GalleryViewController>(
        builder: (galleryController) => SafeArea(
              child: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.grey.shade700,
                  title: Text('GalleryView'),
                  centerTitle: true,
                ),
                body: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                        child: PhotoViewGallery.builder(
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        final url = galleryController
                            .recievedImageListAsArguments[index].urls!.full
                            .toString();
                        final id = galleryController
                            .recievedImageListAsArguments[index].id;
                        return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(
                              url
                          ),
                          initialScale: PhotoViewComputedScale.contained,
                          heroAttributes:
                              PhotoViewHeroAttributes(tag: id.toString()),
                        );
                      },
                      itemCount:
                          galleryController.recievedImageListAsArguments.length,
                      loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
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
                    )),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Image : ${galleryController.index + 1}/${galleryController.recievedImageListAsArguments.length}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  border: Border.all(color: Colors.blueAccent)
                              ),
                              width: 20.0,
                              height: 30.0,
                              child: Center(
                                child: Text(
                                  'Download',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 13.0),
                                ),
                              ),
                            ),
                            onTap: () async{
                              try {
                                // Saved with this method.
                                var imageId = await ImageDownloader.downloadImage(
                                    galleryController
                                        .recievedImageListAsArguments[galleryController.index].urls!.full
                                        .toString()
                                );
                                if (imageId == null) {
                                  return;
                                }
                                // Below is a method of obtaining saved image information.
                                //var fileName = await ImageDownloader.findName(imageId);
                                //var path = await ImageDownloader.findPath(imageId);
                                //print("path : $path");
                                //var size = await ImageDownloader.findByteSize(imageId);
                                //var mimeType = await ImageDownloader.findMimeType(imageId);
                                Get.snackbar("Download", "Image downloaded.");
                              } on PlatformException catch (error) {
                                print(error);
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  border: Border.all(color: Colors.blueAccent)
                              ),
                              width: 20.0,
                              height: 30.0,
                              child: Center(
                                child: Text(
                                  'Share',
                                  textAlign: TextAlign.center,
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 13.0),
                                ),
                              ),

                            ),
                            onTap: () async{
                              try {
                                final box = context.findRenderObject() as RenderBox?;
                                await Share.share(galleryController.recievedImageListAsArguments[galleryController.index].urls!.full.toString(),
                                    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
                              } on PlatformException catch (error) {
                                print(error);
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
