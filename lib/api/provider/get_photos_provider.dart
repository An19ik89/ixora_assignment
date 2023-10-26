import 'dart:convert';
import 'dart:developer';



import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:hive/hive.dart';
import 'package:ixora_assignment/api/client/api_client.dart';
import 'package:ixora_assignment/core/api_endpoints.dart';
import 'package:ixora_assignment/core/app_values.dart';
import 'package:ixora_assignment/data/model/photoresponse.dart';



class PhotoProvider extends GetxService {

  //dummy data
  var test =
    [
      {
        "id": "F4ottWBnCpM",
        "urls": {
          "raw": "https://images.unsplash.com/photo-1648737966636-2fc3a5fffc8a?ixid=MnwzMzQyMjN8MXwxfGFsbHwxfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1",
          "full": "https://images.unsplash.com/photo-1648737966636-2fc3a5fffc8a?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzQyMjN8MXwxfGFsbHwxfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80",
          "regular": "https://images.unsplash.com/photo-1648737966636-2fc3a5fffc8a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzQyMjN8MXwxfGFsbHwxfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80&w=1080",
          "small": "https://images.unsplash.com/photo-1648737966636-2fc3a5fffc8a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzQyMjN8MXwxfGFsbHwxfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80&w=400",
          "thumb": "https://images.unsplash.com/photo-1648737966636-2fc3a5fffc8a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzQyMjN8MXwxfGFsbHwxfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80&w=200",
          "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/photo-1648737966636-2fc3a5fffc8a"
        },
      },
      {
        "id": "141Ba0pJUZM",

        "urls": {
          "raw": "https://images.unsplash.com/photo-1654113294478-6d439fcaf6f1?ixid=MnwzMzQyMjN8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1",
          "full": "https://images.unsplash.com/photo-1654113294478-6d439fcaf6f1?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzQyMjN8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80",
          "regular": "https://images.unsplash.com/photo-1654113294478-6d439fcaf6f1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzQyMjN8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80&w=1080",
          "small": "https://images.unsplash.com/photo-1654113294478-6d439fcaf6f1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzQyMjN8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80&w=400",
          "thumb": "https://images.unsplash.com/photo-1654113294478-6d439fcaf6f1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzQyMjN8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80&w=200",
          "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1654113294478-6d439fcaf6f1"
        },
      },
    ];


  final ApiClient _apiClient = Get.find();

  List<PhotoResponseModel> photoListRes = <PhotoResponseModel>[];

   getAllPhotoListProviderFromHive () async{
    for(String key in Hive.box(AppValues.DATABASE_NAME).keys) {
      PhotoResponseModel photoResponseModel = Hive.box(AppValues.DATABASE_NAME).get(key);
      photoListRes.add(photoResponseModel);
    }
    return photoListRes ;
  }

  Future getAllPhotoListProvider (int pageNumber,int listLength,int connectionType) async
  {
    final params = {
      'client_id': AppValues.CLIENT_KEY,
      'page': pageNumber,
      'per_page': listLength,
    };
    try {
        DIO.Response response = await _apiClient.request(Api.GET_ALL_PHOTO_LIST_URL, Method.GET, params: params);
        if(response.statusCode == 200)
        {
          List<PhotoResponseModel> photoList = <PhotoResponseModel>[];
          for(int i=0;i<response.data.length;i++){
            var test = PhotoResponseModel.fromJson(response.data[i]);
            Hive.box(AppValues.DATABASE_NAME).put(test.id.toString(), test);
            photoList.add(test);
          }
          return photoList;
        }
    } catch (SocketException) {
      debugPrint(SocketException.toString());
    }
  }


}