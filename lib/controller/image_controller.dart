import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends StatefulWidget {
  @override
  State<ImageController> createState() => _ImageControllerState();
}

class _ImageControllerState extends State<ImageController> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          // color: Colors.red,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  getImage();
                },
                child: Text(
                  "클릭",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              showImage()
            ],
          ),
        )
        // body: Column(
        //   children: [
        //     Container(
        //       color: Colors.white,
        //       alignment: Alignment.center,
        //       height: 30.0,
        //       child: TextButton(
        //         onPressed: () {},
        //         child: Text(
        //           "클릭",
        //           style: TextStyle(color: Colors.black),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }

  Widget showImage() {
    if (_image == null) {
      return Container();
    } else {
      return Image.file(_image!);
    }
  }

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }
}
//
// class ImageController extends GetxController {
//   File? images;
//
//   void getImage(ImageSource imageSource) async {
//     final pickedImage = await ImagePicker().pickImage(source: imageSource);
//     images = File(pickedImage!.path);
//     print('images: $images');
//     update();
//   }
// }
