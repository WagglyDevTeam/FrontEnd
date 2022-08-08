import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_social_textfield/controller/social_text_editing_controller.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import '../components/post/custom_text_form_field.dart';
import '../components/post/post_app_bar.dart';
import '../controller/post/image_controller.dart';
import '../controller/post/post_controller.dart';
import '../model/post/dtos/post_request_dto.dart';

const double appBarHeight = 50.0;
const double dividerHeight = 16.0;
const double titleAreaHeight = 40.0;
const double tagAreaHeight = 40.0;
const double buttonAreaHeight = 40.0;
const double cameraButtonAreaHeight = 40.0;
const double imageThumbnailAreaHeight = 100.0;
const double cameraButtonWidth = 40.0;

class WritePage extends StatelessWidget {
  ImageController imageController = Get.put(ImageController());
  PostController postController = Get.put(PostController());
  final _title = TextEditingController();
  final _hashtag = SocialTextEditingController();
  final _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var page = Status.edit;
    const postName = "게시글 작성";
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    var safeWidth = mediaQuery.size.width - 40; // 좌우 Padding 20 씩

    var contentAreaHeight = screenHeight -
        appBarHeight -
        titleAreaHeight -
        tagAreaHeight -
        buttonAreaHeight -
        cameraButtonAreaHeight -
        imageThumbnailAreaHeight -
        (dividerHeight * 4)
        - 8; // 왠지 모르겠는데 키보드가 올라가면 8만큼 높이가 오버플로우 돼서 8 빼줬음

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PostAppbar(
        page: page,
        postName: postName,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: screenHeight,
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
                  child: HashtagInputField(controller: _hashtag),
                ),
              ), // 해시태그 영역
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: contentAreaHeight,
                  child: Container(
                    width: safeWidth,
                    child: CustomTextFormField(
                      maxLines: 200,
                      controller: _content,
                      hint: "내용을 입력하세요.",
                    ),
                  ),
                ),
              ), // 내용 영역
              Obx(
                () => PhotoWidget(
                    imageController: imageController,
                    length: imageController.images!.length),
              ), // 선택된 이미지 표시 영역
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: cameraButtonWidth,
                      child: IconButton(
                        onPressed: () async {
                          await imageController.getImage();
                        },
                        icon: Icon(
                          Icons.photo_camera,
                          size: 25,
                          color: Color(0xFF6C6C6C),
                        ),
                      ),
                    ), // 카메라 아이콘
                    SizedBox(width: 140),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: safeWidth - cameraButtonWidth - 140,
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            padding: EdgeInsets.fromLTRB(14, 7, 14, 7),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8E8E8),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "커뮤니티 이용규칙 전체 보기",
                              style: TextStyle(
                                foreground: Paint()..color = Color(0xFF959595),
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ), // 커뮤니티 이용 수칙
                  ],
                ),
              ), // 카메라 아이콘, 커뮤니티 이용규칙
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: buttonAreaHeight,
                  child: TextButton(
                    onPressed: () async {
                      List<MultipartFile> file = imageToMultipartFile();
                      await postController.writeBoard(
                        PostRequestDto(
                            _title.text,
                            _content.text,
                            "SOCIAL",
                            false,
                            file
                        ),
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
              ), // 게시글 작성하기 버튼
            ],
          ),
        ),
      ),
    );
  }

  List<MultipartFile> imageToMultipartFile() {
    List<MultipartFile> file = <MultipartFile>[];
    for (var img in imageController.images!) {
      print(img.name);
      file.add(MultipartFile(File(img.path), filename: img.name));
    }
    return file;
  }
}

class HashtagInputField extends StatelessWidget {
  final SocialTextEditingController controller;

  HashtagInputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return HashTagTextField(
      onChanged: (text) {
        if (text[text.length - 2] == ',') {
          controller.text = text + " ";
          controller.selection =
              TextSelection.collapsed(offset: controller.text.lastIndexOf(" "));
        }
      },
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        hintText: "#해시태그를 이용하여 게시글을 소개해주세요.",
        hintStyle: TextStyle(color: Colors.purple.shade200),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
      ),
      decoratedStyle: TextStyle(fontSize: 14.0, color: Colors.purple),
    );
  }
}

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    Key? key,
    required this.imageController,
    required this.length,
  }) : super(key: key);

  final int length;
  final ImageController imageController;

  @override
  Widget build(BuildContext context) {
    return length > 0
        ? SizedBox(
            height: imageThumbnailAreaHeight,
            child: ListView.builder(
              // shrinkWrap: true,
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              scrollDirection: Axis.horizontal,
              itemCount: imageController.images!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: imageThumbnailAreaHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.file(
                            File(imageController.images![index].path),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -15,
                        left: imageThumbnailAreaHeight - 35,
                        child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.purple.shade600,
                            size: 20.0,
                          ),
                          onPressed: () {
                            imageController.images!.removeAt(index);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : SizedBox(height: imageThumbnailAreaHeight);
  }
}
