import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/image_model.dart';
import '../repo/Image_repository.dart';

class ImagePickerWidget extends StatelessWidget {
  final Function(String) onImageSelected;

  ImagePickerWidget({super.key, required this.onImageSelected});

  final ImageRepository _imageRepository = ImageRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PicsumImage>>(
        future: _imageRepository.loadImages(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PicsumImage>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        onImageSelected(snapshot.data![index].download_url);
                      },
                      child: Image.network(snapshot.data![index].download_url));
                });
          } else if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text("Failed to get images",
                  style: TextStyle(color: Colors.white)),
            );
          }
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
