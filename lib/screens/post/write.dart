import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_social_textfield/controller/social_text_editing_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/widgets/button/rules_button.dart';
import 'package:waggly/widgets/textFormField/custom_text_form_field.dart';
import 'package:waggly/widgets/textFormField/input_hashtag_field.dart';
import 'package:waggly/widgets/checkBox/simple_check_box.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';
import 'package:waggly/controller/postDetail/post_detail_controller.dart';
import 'package:waggly/model/post/dtos/post_edit_request_dto.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/widgets/header/page_appbar.dart';
import '../../controller/post/image_controller.dart';
import '../../controller/post/post_controller.dart';
import '../../controller/post/post_home_controller.dart';
import '../../controller/postDetail/post_edit_controller.dart';
import '../../model/post/dtos/post_request_dto.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../utils/text_frame.dart';

const double _dividerHeight = 25.0;
const double _titleAreaHeight = 30.0;
const double _hashtagAreaHeight = 30.0;
const double _buttonAreaHeight = 41.0;
const double _bottomButtonHeight = 36.0;
const double _rulesButtonAreaHeight = 40.0;
const double _imageThumbnailAreaHeight = 110.0;
const double _bottomButtonPaddingTop = 10.0;
const double _bottomButtonPaddingBottom = 15.0;

class WritePage extends StatelessWidget {
  final ImageController _imageController = Get.put(ImageController());
  final PostController _postController = Get.put(PostController());
  final PostHomeController _postHomeController = Get.put(PostHomeController());
  final _hashtag = SocialTextEditingController();
  final _content = TextEditingController();
  final _title = TextEditingController();
  final String type;
  final loginUser = Hive.box<User>('user').get('user');

  WritePage(this.type, {Key? key}) : super(key: key);

  void buttonActivateCheck() {
    if (_title.text.isBlank == true || _content.text.isBlank == true) {
      _postController.isButtonActivate.value = false;
      // print(_postController.isButtonActivate.value);
    } else {
      _postController.isButtonActivate.value = true;
      // print(_postController.isButtonActivate.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _page = Status.edit;
    var _os = Platform.operatingSystem;
    var _postName = "게시글 작성";
    _imageController.getImagesUrl([]);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: PageAppbar(
      //   page: _page,
      //   pageTitle: _postName,
      // ),
      appBar: TopAppBar(type),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: _dividerHeight.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: _titleAreaHeight.h,
                        child: CustomTextFormField(
                          onChanged: buttonActivateCheck,
                          controller: _title,
                          hint: "제목을 입력하세요.",
                          focus: true,
                        ),
                      ),
                    ),
                    CustomCheckbox(controller: _postController, text: '익명'),
                  ],
                ),
              ), // 제목 영역
              // Divider(height: _dividerHeight.h),
              // Padding(
              //   padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
              //   child: SizedBox(
              //     height: _hashtagAreaHeight.h,
              //     child: InputHashtagField(
              //       // onChanged: buttonActivateCheck,
              //       controller: _hashtag,
              //       hintText: "#해시태그를 이용하여 게시글을 소개해주세요.",
              //       // height: hashtagAreaHeight,
              //     ),
              //   ),
              // ), // 해시태그 영역
              Divider(height: _dividerHeight.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: CustomTextFormField(
                  onChanged: buttonActivateCheck,
                  // onEditingComplete: ,
                  maxLines: 15,
                  controller: _content,
                  hint: "내용을 입력하세요.",
                  focus: true,
                ),
              ), // 내용 영역
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: Obx(
                  () => PhotoWidget(
                      imageController: _imageController,
                      imagesLength: _imageController.images!.length),
                ),
              ), // 선택된 이미지 표시 영역
              Padding(
                padding: EdgeInsets.only(left: 10.0.w, right: 20.0.w),
                child: SizedBox(
                  height: _rulesButtonAreaHeight.h,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await _imageController.uploadMultipleImages();
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/photo_camera.svg",
                          width: 20.0.w,
                          height: 20.0.h,
                          fit: BoxFit.fitWidth,
                          color: Color(0xFF6C6C6C),
                        ),
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
                  child: Obx(
                    () => Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: _bottomButtonHeight.h,
                      decoration: BoxDecoration(
                        color: _postController.isButtonActivate.value == true
                            ? Palette.main
                            : Palette.paper,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          final result = await writePost();
                          if (result.code == 201) {
                            _postHomeController.updateBoardCollege(Get.parameters['collegeId']);
                            Get.back();
                          } else {
                            CustomSnackBar.messageSnackbar(
                              context,
                              result.message,
                              EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                            );
                          }
                        },
                        child: Text(
                          "게시글 작성하기",
                          style: _postController.isButtonActivate.value == true
                              ? CommonText.BodyBoldWhite
                              : CommonText.BodyBoldGrey,
                        ),
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
    for (var img in _imageController.images!) {
      file.add(MultipartFile(File(img.path), filename: img.name));
    }
    return file;
  }

  Future<void> editPost(title, description, college) async {
    final PostDetailController postDetailController =
        Get.put(PostEditController());

    List<MultipartFile> file = imageToMultipartFile();
    await postDetailController.editBoard(PostEditRequestDto(title, description,
        college, file, _imageController.parseToStringList()));
  }

  Future<WagglyResponseDto> writePost() async {
    List<MultipartFile> file = imageToMultipartFile();
    List<String> hashtags = extractHashTags(_hashtag.text);
    final box = Hive.box<User>('user');
    int? me = box.get('user')?.id;

    return await _postController.writeBoard(
      PostRequestDto(
        _title.text,
        _content.text,
        "SOCIAL",
        _postController.checkBox.value,
        hashtags,
        file,
      ),
    );
  }
}

class PhotoWidget extends StatelessWidget {
  const PhotoWidget(
      {Key? key,
      required this.imageController,
      required this.imagesLength})
      : super(key: key);

  final int imagesLength;
  final ImageController imageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: _imageThumbnailAreaHeight.h,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 4.0.w,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: imagesLength,
              itemBuilder: (ctx, index) {
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
                              File(imageController
                                  .images![index].path),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 6.h,
                            left: _imageThumbnailAreaHeight - 27.w,
                            child: InkWell(
                              onTap: () {
                                print(index);
                                imageController.images?.removeAt(index);
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
                    // if (index == imagesLength - 1) SizedBox(width: 20.0.w),
                  ],
                );
              },
            ),
    );
  }
}

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  TopAppBar(type, {Key? key}) : super(key: key);
  final PostHomeController _postHomeController = Get.put(PostHomeController());
  @override
  Size get preferredSize => Size.fromHeight(68.h);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Palette.lightGray),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Palette.gray,
                  iconSize: 20.0.sp,
                  onPressed: () {
                    _postHomeController.updateBoardCollege(Get.parameters['collegeId']);
                  },
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text("게시글 작성", style: CommonText.BodyL))
            ],
          ),
        ),
      ],
    );
  }
}
