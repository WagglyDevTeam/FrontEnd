import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_social_textfield/controller/social_text_editing_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:waggly/components/button/bottom_long_button.dart';
import 'package:waggly/components/button/rules_button.dart';
import 'package:waggly/components/inputField/input_hashtag_field.dart';
import 'package:waggly/components/inputField/input_title_field.dart';
import 'package:waggly/model/post/dtos/post_edit_request_dto.dart';
import '../components/post/custom_text_form_field.dart';
import 'package:waggly/widgets/header/page_appbar.dart';
import '../controller/post/image_controller.dart';
import '../controller/post/post_controller.dart';
import '../controller/postDetail/post_edit_controller.dart';
import '../model/post/dtos/post_request_dto.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../utils/text_frame.dart';

const double _dividerHeight = 18.0;
const double _titleAreaHeight = 40.0;
const double _hashtagAreaHeight = 40.0;
const double _buttonAreaHeight = 41.0;
const double _bottomButtonHeight = 36.0;
const double _rulesButtonAreaHeight = 40.0;
const double _imageThumbnailAreaHeight = 110.0;
const double _bottomButtonPaddingTop = 10.0;
const double _bottomButtonPaddingBottom = 15.0;

class WritePage extends StatelessWidget {
  final ImageController _imageController = Get.put(ImageController());
  final PostController _postController = Get.put(PostController());
  final PostEditController postEditController = Get.put(PostEditController());
  final _hashtag = SocialTextEditingController();
  TextEditingController? _content;
  TextEditingController? _title;
  var type;

  WritePage(this.type, {Key? key}) : super(key: key);

  void buttonActivateCheck() {
    if (_title.text.isBlank == true ||
        extractHashTags(_hashtag.text).isEmpty ||
        _content.text.isBlank == true) {
      _postController.isButtonActivate.value = false;
    } else {
      _postController.isButtonActivate.value = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    var _page = Status.edit;
    var _os = Platform.operatingSystem;
    const _postName = "게시글 작성";
    if(type == "edit"){
      postEditController.updatePostEditData();
      _imageController.getImagesUrl(postEditController.postEditData.value.postImages);
      _title = TextEditingController(text: postEditController.postEditData.value.postTitle);
      _content = TextEditingController(text: postEditController.postEditData.value.postDesc);
    }else{
      _imageController.getImagesUrl([]);
      _title = TextEditingController();
      _content = TextEditingController();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PageAppbar(
        page: _page,
        pageTitle: _postName,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: _dividerHeight.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: SizedBox(
                  height: _titleAreaHeight.h,
                  child: InputTitleField(
                    onEditingComplete: buttonActivateCheck,
                    controller: _title!,
                    hintText: "제목을 입력하세요.",
                    // height: titleAreaHeight,
                  ),
                ),
              ), // 제목 영역
              Divider(height: _dividerHeight.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: SizedBox(
                  height: _hashtagAreaHeight.h,
                  child: InputHashtagField(
                    onEditingComplete: buttonActivateCheck,
                    controller: _hashtag,
                    hintText: "#해시태그를 이용하여 게시글을 소개해주세요.",
                    // height: hashtagAreaHeight,
                  ),
                ),
              ), // 해시태그 영역
              Divider(height: _dividerHeight.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                  child: CustomTextFormField(
                    onChanged: buttonActivateCheck,
                    maxLines: 15,
                    controller: _content,
                    hint: "내용을 입력하세요.",
                  ),
                ),
              ), // 내용 영역
              Obx(() => PhotoWidget(imageController: _imageController,imageUrlLength: _imageController.imagesUrl.length,imagesLength:_imageController.images!.length, length: _imageController.showImages.length, type: "write"),),
              // Obx(
              //   () =>
              //     PhotoWidget(imageController: _imageController, length: _imageController.images!.length, type: "write")
              // ), // 선택된 이미지 표시 영역
              Padding(
                padding: EdgeInsets.only(left: 10.0.w, right: 20.0.w),
                child: SizedBox(
                  height: _rulesButtonAreaHeight.h,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            await _imageController.getImage();
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/photo_camera.svg",
                            width: 20.0.w,
                            height: 20.0.h,
                            fit: BoxFit.fitWidth,
                            color: Color(0xFF6C6C6C),
                          )
                          // Icon(
                          //   Icons.photo_camera,
                          //   size: 25,
                          //   color: Color(0xFF6C6C6C),
                          // ),
                          ), // 카메라 아이콘
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
                            child: RulesButton(text: "커뮤니티 이용규칙 전체 보기"),
                          ),
                        ),
                      ), // 커뮤니티 이용 수칙
                    ],
                  ),
                ),
              ), // 카메라 아이콘, 커뮤니티 이용규칙
              Divider(height: _dividerHeight.h),
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0.w,
                  right: 20.0.w,
                  top: _bottomButtonPaddingTop.h,
                  bottom: _os == "ios" ? 0.0 : _bottomButtonPaddingBottom.h,
                ),
                child: SizedBox(
                  height: _buttonAreaHeight.h,
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: _bottomButtonHeight.h,
                      decoration: BoxDecoration(
                        color: Palette.main,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextButton(
                        onPressed: () async {type == "edit" ? await editPost(_title!.text, _content!.text, "SOCIAL") : await writePost();},
                        child: Text(
                          "게시글 작성하기",
                          style: CommonText.BodyBoldWhite,
                        ),
                      ),
                    ),
                  // child: BottomLongButton(
                  //   controller: _postController,
                  //   text: "게시글 작성하기",
                  //   height: _bottomButtonHeight.h,
                  //   onPressed: () async {
                  //     print("object");
                  //     // await editPost(_title!.text, _content!.text, "SOCIAL");
                  //     // List<MultipartFile> file = imageToMultipartFile();
                  //     // await _postController.editBoard(PostEditRequestDto(_title!.text, _content!.text, "SOCIAL", file, _imageController.parseToStringList()));
                  //     // List<MultipartFile> file = imageToMultipartFile();
                  //     // List<String> hashtags = extractHashTags(_hashtag.text);
                  //     // await _postController.writeBoard(
                  //     //   PostRequestDto(
                  //     //     _title!.text,
                  //     //     _content!.text,
                  //     //     "SOCIAL",
                  //     //     false,
                  //     //     hashtags,
                  //     //     file,
                  //     //   ),
                  //     // );
                  //   },
                  // ),
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
    for (var img in _imageController.images!) {
      file.add(MultipartFile(File(img.path), filename: img.name));
    }
    return file;
  }

  Future<void> editPost(title, description, college) async {
    List<MultipartFile> file = imageToMultipartFile();
    await _postController.editBoard(PostEditRequestDto(title, description, college, file, _imageController.parseToStringList()));
  }

  Future<void> writePost() async {
    print(_content!.text);
        List<MultipartFile> file = imageToMultipartFile();
        List<String> hashtags = extractHashTags(_hashtag.text);
        await _postController.writeBoard(
          PostRequestDto(
            _title!.text,
            _content!.text,
            "SOCIAL",
            false,
            hashtags,
            file,
          ),
        );
  }
}

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    Key? key,
    required this.imageController,
    required this.imagesLength,
    required this.imageUrlLength,
    required this.length,
    required this.type
  }) : super(key: key);

  final int length;
  final int imagesLength;
  final int imageUrlLength;
  final ImageController imageController;
  final String type;
  @override
  Widget build(BuildContext context) {
    return length > 0
        ? SizedBox(
            height: _imageThumbnailAreaHeight.h,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 4.0.w,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: imageUrlLength + imagesLength,
              itemBuilder: (ctx, index) {
                print(index);
                if(index < imageUrlLength){
                  return Row(
                    children: [
                      if (index == 0) SizedBox(width: 20.0.w),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0.w),
                        height: 100.0.h,
                        width: 100.0.w,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: Image.network(
                                imageController.imagesUrl[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: 6.h,
                              left: _imageThumbnailAreaHeight - 27.w,
                              child: InkWell(
                                onTap: () {
                                  imageController.deleteImages.add(imageController.imagesUrl[index]);
                                  imageController.imagesUrl.removeAt(index);
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/cancel.svg",
                                  width: 14.0.w,
                                  height: 14.0.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }else{
                  return Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0.w),
                        height: 100.0.h,
                        width: 100.0.w,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: Image.file(
                                File(imageController.images![index-imageUrlLength].path),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: 6.h,
                              left: _imageThumbnailAreaHeight - 27.w,
                              child: InkWell(
                                onTap: () {
                                  var list = imageController.showImages[1];
                                  imageController.showImages[1].removeAt(index-imageUrlLength);
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/cancel.svg",
                                  width: 14.0.w,
                                  height: 14.0.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (index == imagesLength-1) SizedBox(width: 20.0.w),
                    ],
                  );
                }
              },
            ),
          )
        : SizedBox(height: _imageThumbnailAreaHeight.h);
  }
}
