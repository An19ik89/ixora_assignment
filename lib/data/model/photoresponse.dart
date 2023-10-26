// To parse this JSON data, do
//
//     final photoResponseModel = photoResponseModelFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';



List<PhotoResponseModel?> photoResponseModelFromJson(String str) => List<PhotoResponseModel?>.from(json.decode(str).map((x) => PhotoResponseModel.fromJson(x)));

String photoResponseModelToJson(List<PhotoResponseModel?> data) => json.encode(List<dynamic>.from(data.map((x) => x!.toJson())));

@HiveType(typeId: 0)
class PhotoResponseModel extends HiveObject{
  PhotoResponseModel({
    this.id,
    this.urls,

  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  Urls? urls;



  factory PhotoResponseModel.fromJson(Map<String, dynamic> json) => PhotoResponseModel(
    id: json["id"] == null ? null : json["id"],
    urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "urls": urls == null ? null : urls!.toJson(),
  };
}

@HiveType(typeId: 1)
class Urls extends HiveObject{
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });
  @HiveField(0)
  String? raw;
  @HiveField(1)
  String? full;
  @HiveField(2)
  String? regular;
  @HiveField(3)
  String? small;
  @HiveField(4)
  String? thumb;
  @HiveField(5)
  String? smallS3;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json["raw"] == null ? null : json["raw"],
    full: json["full"] == null ? null : json["full"],
    regular: json["regular"] == null ? null : json["regular"],
    small: json["small"] == null ? null : json["small"],
    thumb: json["thumb"] == null ? null : json["thumb"],
    smallS3: json["small_s3"] == null ? null : json["small_s3"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw == null ? null : raw,
    "full": full == null ? null : full,
    "regular": regular == null ? null : regular,
    "small": small == null ? null : small,
    "thumb": thumb == null ? null : thumb,
    "small_s3": smallS3 == null ? null : smallS3,
  };
}
