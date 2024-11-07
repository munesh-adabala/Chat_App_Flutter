// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PicsumImage _$PicsumImageFromJson(Map<String, dynamic> json) => PicsumImage(
      id: json['id'] as String,
      author: json['author'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      download_url: json['download_url'] as String,
    );

Map<String, dynamic> _$PicsumImageToJson(PicsumImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'width': instance.width,
      'height': instance.height,
      'download_url': instance.download_url,
    };
