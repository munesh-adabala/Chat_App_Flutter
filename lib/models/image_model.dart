
import 'package:json_annotation/json_annotation.dart';
part 'image_model.g.dart';

@JsonSerializable()
class PicsumImage {
  String id;
  String author;
  int width;
  int height;
  String download_url;

  PicsumImage(
      {required this.id,
      required this.author,
      required this.width,
      required this.height,
      required this.download_url});

  factory PicsumImage.fromJson(Map<String, dynamic> json) => _$PicsumImageFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PicsumImageToJson(this);
}
