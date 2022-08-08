import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  List<XFile>? images = <XFile>[].obs;

  @override
  onInit() {
    super.onInit();
  }

  Future getImage() async {
    var image = await ImagePicker().pickMultiImage();
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
  }
}

