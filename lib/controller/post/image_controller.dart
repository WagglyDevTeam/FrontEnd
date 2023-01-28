import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  List<XFile>? images = <XFile>[].obs;
  final imagesUrl = [].obs;
  final showImages = [].obs;
  final deleteImages = [].obs;
  @override
  onInit() {
    super.onInit();
  }

  Future uploadMultipleImages() async {
    var image = await ImagePicker().pickMultiImage(maxWidth: 1024, maxHeight: 1024, imageQuality: 50);
    List<String> existBytesString = <String>[];
    if (image != null) {
      if (images == null || images!.isEmpty) {
        images!.addAll(image);
      } else {
        // 중복 이미지 업로드 되지 않도록 로직 추가
        for (var img in images!) {
          existBytesString.add((await img.readAsBytes()).toString());
        }
        for (var img in image) {
          if (!existBytesString.contains((await img.readAsBytes()).toString())) {
            images!.add(img);
          }
        }
      }
    }

    showImages.add(images);
    print(showImages);
  }

  Future uploadSingleImage() async {
    var image =
        await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1024, maxHeight: 1024, imageQuality: 50);
    // print(image);
  }

  void getImagesUrl(imageUrl) {
    if (imageUrl != null) {
      imagesUrl.value = imageUrl;
      showImages.add(imageUrl);
    }
  }

  List<String> parseToStringList() {
    List<String> list = [];
    for (var url in deleteImages) {
      list.add(url);
    }
    return list;
  }
}
