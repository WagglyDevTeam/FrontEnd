import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wagly/components/Post/custom_text_form_field.dart';
import 'package:wagly/components/Post/post_common.dart';
import 'package:wagly/components/Post/post_detail_screen.dart';
import 'package:wagly/widgets/PageNav/PageNav.dart';
import 'package:wagly/widgets/index.dart';
import '../../utils/colors.dart';
import '../../utils/textFrame.dart';
import '../components/Post/post_app_bar.dart';

class WritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var page = Status.home;
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    const postName = "글쓰기";
    const double appBarHeight = 50.0;
    const double dividerHeight = 16.0;
    const double titleAreaHeight = 45.0;
    const double tagAreaHeight = 45.0;
    const double buttonAreaHeight = 50.0;
    var contentAreaHeight = screenHeight -
        appBarHeight -
        titleAreaHeight -
        tagAreaHeight -
        buttonAreaHeight -
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
              child: Container(
                color: Colors.yellow.shade300,
                alignment: Alignment.topCenter,
                height: contentAreaHeight,
                child: CustomTextFormField(
                  // maxLines: 25,
                  hint: "내용을 입력하세요.",
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
