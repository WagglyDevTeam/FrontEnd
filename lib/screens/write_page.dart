import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../components/post/custom_text_form_field.dart';
import '../components/post/post_app_bar.dart';
import '../controller/post/post_controller.dart';
import '../model/post/dtos/post_request_dto.dart';

const double appBarHeight = 50.0;
const double dividerHeight = 16.0;
const double titleAreaHeight = 40.0;
const double tagAreaHeight = 40.0;
const double buttonAreaHeight = 50.0;
const double cameraButtonAreaHeight = 40.0;
const double imageThumbnailAreaHeight = 100.0;
const double cameraButtonWidth = 40.0;

class WritePage extends StatefulWidget {
  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = <XFile>[];

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.put(PostController());
    final _title = TextEditingController();
    final _hashtag = TextEditingController();
    final _content = TextEditingController();

    var page = Status.home;
    const postName = "글쓰기";
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    var safeWidth = mediaQuery.size.width - 40;

    var contentAreaHeight = screenHeight -
        appBarHeight -
        titleAreaHeight -
        tagAreaHeight -
        buttonAreaHeight -
        cameraButtonAreaHeight -
        imageThumbnailAreaHeight -
        (dividerHeight * 4) - 10;

    return Scaffold(
      appBar: PostAppbar(
        page: page,
        postName: postName,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  alignment: Alignment.center,
                  height: titleAreaHeight,
                  child: CustomTextFormField(
                    controller: _title,
                    hint: "제목을 입력하세요.",
                  ),
                ),
              ), // 제목 영역
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: tagAreaHeight,
                  child: CustomTextFormField(
                    // maxLines: 15,
                    controller: _hashtag,
                    hint: "#해시태그를 이용하여 게시글을 소개해주세요.",
                    hintStyle: TextStyle(color: Colors.purple.shade200),
                  ),
                ),
              ), // 해시태그 영역
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: contentAreaHeight,
                  child: CustomTextFormField(
                    // maxLines: 15,
                    controller: _content,
                    hint: "내용을 입력하세요.",
                  ),
                ),
              ),
              SizedBox(
                height: imageThumbnailAreaHeight,
                child: imageFileList!.isEmpty
                    ? Container()
                    : SelectedImage(imageFileList: imageFileList),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: cameraButtonWidth,
                      child: IconButton(
                        onPressed: () {
                          selectImages();
                        },
                        icon: Icon(
                          Icons.photo_camera,
                          size: 30,
                          color: Color(0xFF6C6C6C),
                        ),
                      ),
                    ), // 카메라 아이콘
                    SizedBox(width: 140),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: SizedBox(
                        // color: Colors.red.shade700,
                        // alignment: Alignment.centerRight,
                        width: safeWidth - cameraButtonWidth - 140,
                        child: TextButton(
                          onPressed: () {},
                          child: Text("커뮤니티 이용규칙 전체보기"),
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              foreground: Paint()..color = Color(0xFF959595),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            backgroundColor: Color(0xFFE8E8E8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                      ),
                    ), // 커뮤니티 이용 수칙
                  ],
                ),
              ), // 내용을 입력하세요.
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: buttonAreaHeight,
                  // color: Colors.yellow.shade300,
                  child: TextButton(
                    onPressed: () {
                      postController.writeBoard(
                        PostRequestDto(
                            _title.text, _content.text, "SOCIAL", false),
                      );
                    },
                    child: Text("게시글 작성하기"),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        letterSpacing: 2.0,
                        foreground: Paint()..color = Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ), // 게시글 작성하기
            ],
          ),
        ),
      ),
    );
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (selectedImages != null) {
      setState(() {
        imageFileList = selectedImages;
      });
    }
    print(selectedImages!.length);
  }
}

class SelectedImage extends StatelessWidget {
  const SelectedImage({
    Key? key,
    required this.imageFileList,
  }) : super(key: key);

  final List<XFile>? imageFileList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // shrinkWrap: true,
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        scrollDirection: Axis.horizontal,
        // itemExtent: imageThumbnailAreaHeight,
        itemCount: imageFileList!.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: imageThumbnailAreaHeight,
            padding: EdgeInsets.all(3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Image.file(
                File(imageFileList![index].path),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
    );
  }
}
