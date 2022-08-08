import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  List<XFile>? images = <XFile>[].obs;

  Future getImage() async {
    var image = await ImagePicker().pickMultiImage();

    if (image != null && image.isNotEmpty) {
      images!.addAll(image);
      print(image.toString());
    }
  }
}

//
// class ImageController extends StatefulWidget {
//   @override
//   State<ImageController> createState() => _ImageControllerState();
// }
//
// class _ImageControllerState extends State<ImageController> {
//   List<XFile>? _images;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           TextButton(
//             onPressed: () {
//               getImage();
//             },
//             child: Text(
//               "클릭",
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           showImage()
//         ],
//       ),
//     );
//   }
//
//   Widget showImage() {
//     if (_images == null) {
//       return Container();
//     } else {
//       return Expanded(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.builder(
//             itemCount: _images!.length,
//             gridDelegate:
//                 SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//             itemBuilder: (BuildContext context, int index) {
//               return Image.file(File(_images![index].path), fit: BoxFit.cover);
//             },
//           ),
//         ),
//       );
//     }
//   }
//
//   Future getImage() async {
//     var image = await ImagePicker().pickMultiImage();
//
//     setState(() {
//       _images = image!;
//     });
//   }
// }
