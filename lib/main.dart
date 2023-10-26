import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ixora_assignment/api/client/api_client.dart';
import 'package:ixora_assignment/api/provider/get_photos_provider.dart';
import 'package:ixora_assignment/api/repository/get_photos_repository.dart';
import 'package:ixora_assignment/core/app_values.dart';
import 'package:ixora_assignment/data/local/local_storage.dart';
import 'package:ixora_assignment/data/model/photoresponse.dart';
import 'package:ixora_assignment/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var externalDir;
  if (Platform.isIOS) { // Platform is imported from 'dart:io' package
    externalDir = await getApplicationDocumentsDirectory();
  } else if (Platform.isAndroid) {
    externalDir = await getExternalStorageDirectory();
  }
  Hive.registerAdapter(PhotoResponseModelAdapter());
  Hive.registerAdapter(UrlsAdapter());

  await Hive.initFlutter();
  Hive.init(externalDir.path);
  await Hive.openBox(AppValues.DATABASE_NAME);
  await GetStorage.init();
  Get.put<LocalStorage>(LocalStorage());
  await Get.putAsync<ApiClient>(() => ApiClient().init());
  await Get.putAsync<PhotoProvider>(() async => PhotoProvider());
  await Get.putAsync<PhotoRepository>(() async => PhotoRepository());

  runApp(
    GetMaterialApp(
      title: "Gallery App",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
