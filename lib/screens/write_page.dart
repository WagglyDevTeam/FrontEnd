import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/components/Post/custom_text_form_field.dart';
import 'package:waggly/controller/image_controller.dart';
import 'package:waggly/model/dtos/post_request_dto.dart';
import '../components/Post/post_app_bar.dart';
import '../controller/post/post_controller.dart';

class WritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ImageController imageController = Get.put(ImageController());
    PostController postController = Get.put(PostController());
    final _title = TextEditingController();
    final _content = TextEditingController();

    var page = Status.home;
    const postName = "글쓰기";
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    var safeWidth = mediaQuery.size.width - 40;
    const double appBarHeight = 50.0;
    const double dividerHeight = 16.0;
    const double titleAreaHeight = 45.0;
    const double tagAreaHeight = 45.0;
    const double buttonAreaHeight = 45.0;
    const double cameraButtonAreaHeight = 40.0;
    const double cameraButtonWidth = 40.0;
    var contentAreaHeight = screenHeight -
        appBarHeight -
        titleAreaHeight -
        tagAreaHeight -
        buttonAreaHeight -
        cameraButtonAreaHeight -
        (dividerHeight * 4);

    return Scaffold(
      appBar: PostAppbar(
        page: page,
        postName: postName,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
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
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                alignment: Alignment.centerLeft,
                height: tagAreaHeight,
                child: Text(
                  "#해시태그를 이용하여 게시글을 소개해주세요.",
                  style: TextStyle(fontSize: 16.0, color: Colors.purple),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Container(
                    // color: Colors.yellow.shade500,
                    alignment: Alignment.topCenter,
                    height: contentAreaHeight,
                    child: CustomTextFormField(
                      // maxLines: 15,
                      controller: _content,
                      hint: "내용을 입력하세요.",
                    ),
                  ),
                  Container(
                    // color: Colors.yellow.shade700,
                    alignment: Alignment.center,
                    height: cameraButtonAreaHeight,
                    width: safeWidth,
                    child: Row(
                      children: [
                        SizedBox(
                            width: cameraButtonWidth,
                            child: IconButton(
                              onPressed: () async {
                                Get.to(() => ImageController());
                                // imageController.getImage(ImageSource.gallery);
                              },
                              icon: Icon(
                                Icons.photo_camera,
                                size: 30,
                                color: Color(0xFF6C6C6C),
                              ),
                            )),
                        SizedBox(width: 140),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: SizedBox(
                            // color: Colors.red.shade700,
                            // alignment: Alignment.centerRight,
                            width: safeWidth - cameraButtonWidth - 140,
                            child: TextButton(
                              onPressed: () {
                                // Navigator.of(context).push(sign.slideRitghtToLeft());
                              },
                              child: Text("커뮤니티 이용규칙 전체보기"),
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                  foreground: Paint()
                                    ..color = Color(0xFF959595),
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
