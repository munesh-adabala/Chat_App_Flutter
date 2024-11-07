import 'dart:convert';
import 'dart:io';

import '../models/image_model.dart';
import 'package:http/http.dart' as http;

class ImageRepository {
  Future<List<PicsumImage>> loadImages() async {
    final url = Uri.parse("https://picsum.photos/v2/list");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body) as List;
        final List<PicsumImage> imagesList = decodedResponse.map((listItem) {
          return PicsumImage.fromJson(listItem);
        }).toList();
        return imagesList;
      } else{
        throw Exception('API call failed');
      }
    } on SocketException {
      throw Exception('Connect to Internet');
    } on HttpException {
      throw Exception('Couldnt retrieve images');
    } catch (e) {
      throw Exception('Unknown Exception');
    }
  }
}
