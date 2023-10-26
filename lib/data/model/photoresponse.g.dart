// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photoresponse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoResponseModelAdapter extends TypeAdapter<PhotoResponseModel> {
  @override
  final int typeId = 0;

  @override
  PhotoResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoResponseModel(
      id: fields[0] as String?,
      urls: fields[1] as Urls?,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.urls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UrlsAdapter extends TypeAdapter<Urls> {
  @override
  final int typeId = 1;

  @override
  Urls read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Urls(
      raw: fields[0] as String?,
      full: fields[1] as String?,
      regular: fields[2] as String?,
      small: fields[3] as String?,
      thumb: fields[4] as String?,
      smallS3: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Urls obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.raw)
      ..writeByte(1)
      ..write(obj.full)
      ..writeByte(2)
      ..write(obj.regular)
      ..writeByte(3)
      ..write(obj.small)
      ..writeByte(4)
      ..write(obj.thumb)
      ..writeByte(5)
      ..write(obj.smallS3);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UrlsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
