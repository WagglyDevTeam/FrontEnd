import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_social_textfield/controller/social_text_editing_controller.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:waggly/components/button/bottom_long_button.dart';
import 'package:waggly/components/button/rules_button.dart';
import 'package:waggly/components/inputField/input_hashtag_field.dart';
import 'package:waggly/components/inputField/input_title_field.dart';
import '../components/post/custom_text_form_field.dart';
import '../components/post/post_app_bar.dart';
import '../controller/post/image_controller.dart';
import '../controller/post/post_controller.dart';
import '../model/post/dtos/post_request_dto.dart';

const double appBarHeight = 50.0;
const double dividerHeight = 18.0;
const double titleAreaHeight = 40.0;
const double hashtagAreaHeight = 40.0;
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
        hashtagAreaHeight -
        buttonAreaHeight -
        cameraButtonAreaHeight -
        imageThumbnailAreaHeight -
        (dividerHeight * 4);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PostAppbar(
        page: page,
        postName: postName,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SizedBox(
            height: screenHeight,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: InputTitleField(
                      onEditingComplete: (){},
                      controller: _title,
                      hintText: "제목을 입력하세요.",
                      // height: titleAreaHeight,
                    ),
                  ), // 제목 영역
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: InputHashtagField(
                      controller: _hashtag,
                      hintText: "#해시태그를 이용하여 게시글을 소개해주세요.",
                      // height: hashtagAreaHeight,
                    ),
                  ), // 해시태그 영역
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: contentAreaHeight,
                      child: SizedBox(
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
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
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
                          ),
                        ), // 카메라 아이콘
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
                              child: RulesButton(text: "커뮤니티 이용규칙 전체 보기"),
                            ),
                          ),
                        ), // 커뮤니티 이용 수칙
                      ],
                    ),
                  ), // 카메라 아이콘, 커뮤니티 이용규칙
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: BottomLongButton(
                      text: "게시글 작성하기",
                      height: buttonAreaHeight,
                      onPressed: () async {
                        List<MultipartFile> file = imageToMultipartFile();
                        List<String> hashtags = extractHashTags(_hashtag.text);
                        await postController.writeBoard(
                          PostRequestDto(
                            _title.text,
                            _content.text,
                            "SOCIAL",
                            false,
                            hashtags,
                            file,
                          ),
                        );
                      },
                    ),
                  ), // 게시글 작성하기 버튼
                ],
              ),
            ),
          ),
      ),
    );
  }

  List<MultipartFile> imageToMultipartFile() {
    List<MultipartFile> file = <MultipartFile>[];
    for (var img in imageController.images!) {
      file.add(MultipartFile(File(img.path), filename: img.name));
    }
    return file;
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
