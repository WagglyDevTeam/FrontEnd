import "dart:ui";
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:waggly/components/Post/post_common.dart';
import 'package:waggly/utils/text_frame.dart';
import '../controller/post/post_home_controller.dart';
import 'package:waggly/widgets/header/page_appbar.dart';
import '../controller/signIn/sign_in_conroller.dart';
import '../model/post/dtos/post_college_dto.dart';
import '../utils/colors.dart';

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? on = false;
    bool? off = true;
    Status? page = Status.login;

    /// getx controller
    final PostHomeController _postDetailX = Get.put(PostHomeController());
    String? postName = "게시판";
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PageAppbar(page: page, pageTitle: postName),
        body: Container(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 6.h, bottom: 6.h),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Obx(() => Text(
                        _postDetailX.userCollegeData.value.collegeTypeName,
                        style: CommonText.TitleS)),
                    SizedBox(width: 6.w),
                    Icon(Icons.auto_awesome, color: Palette.main, size: 17),
                  ],
                ),
                SizedBox(height: 10.h),
                Obx(() => PostCard(
                      postList: _postDetailX.userCollegeData.value.posts,
                      postName:
                          _postDetailX.userCollegeData.value.collegeTypeName,
                      collegeId: _postDetailX.userCollegeData.value.collegeType,
                      on: on,
                      page: page,
                    )),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Text("다른 계열 둘러보기", style: CommonText.BodyL),
                    SizedBox(width: 6.w),
                  ],
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  height: 220.h,
                  child: Obx(() => PostDifferentList(widgetList: [
                        for (var i = 0;
                            i < _postDetailX.otherCollegeData.value.length;
                            i++)
                          Row(
                            children: [
                              Obx(() => PostCard(
                                    postList: _postDetailX
                                        .otherCollegeData.value[i].posts,
                                    postName: _postDetailX.otherCollegeData
                                        .value[i].collegeTypeName,
                                    collegeId: _postDetailX
                                        .otherCollegeData.value[i].collegeType,
                                    on: off,
                                    page: page,
                                  )),
                              SizedBox(width: 20.w)
                            ],
                          )
                      ])),
                )
              ]),
        ));
  }
}

class PostCard extends StatelessWidget {
  SignInController signInController = Get.put(SignInController());
  double bottomAppbarHeight = 55.0;
  List<PostListData>? postList;
  String? postName;
  Status? page;
  String? collegeId;
  final on;
  PostCard({
    Key? key,
    @required this.postList,
    @required this.postName,
    @required this.on,
    @required this.page,
    @required this.collegeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          signInController.checkLoggedIn().value == false
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "로그인이 필요합니다.",
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(milliseconds: 1000),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(
                        bottom: bottomAppbarHeight + 20,
                        left: 50.w,
                        right: 50.w),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                )
              // : Get.toNamed("/postCollege", arguments: {
              //     "collegeId": "$collegeId",
              //     "collegeName": "$postName"
              //   });
              : Get.toNamed(
                  "/postCollege/param?collegeId=$collegeId&collegeName=$postName");
        },
        child: Container(
          height: 220.h,
          width: 250.w,
          padding:
              EdgeInsets.only(left: 15.w, top: 12.h, right: 15.h, bottom: 12.w),
          decoration: BoxDecoration(
              color: on ? Palette.paper : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                  color: on ? Palette.paper : Palette.light,
                  style: BorderStyle.solid,
                  width: 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 123.h,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(5),
                  itemCount: postList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (page == "login") {
                      return Stack(
                        children: [
                          ListItem(
                              category: postList?[index].majorName,
                              title: postList?[index].postTitle,
                              id: postList?[index].postId),
                          Positioned(
                              top: 1,
                              left: 1,
                              child: SizedBox(
                                height: 20,
                                width: 200,
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 2),
                                  child: Container(
                                      color: Colors.white.withOpacity(0.1)),
                                ),
                              )),
                          Positioned(
                              top: 1,
                              right: -160,
                              child: SizedBox(
                                  height: 20, width: 200, child: NewItem()))
                        ],
                      );
                    } else {
                      return ListItem(
                          category: postList?[index].majorName,
                          title: postList?[index].postTitle,
                          id: postList?[index].postId);
                    }
                  },
                ),
              ),
              Container(
                height: 70.h,
                padding: EdgeInsets.only(
                    left: 20.w, right: 15.w, top: 5.h, bottom: 5.h),
                decoration: BoxDecoration(
                  color: on ? Colors.white : Palette.main,
                  borderRadius: BorderRadius.circular(26.0),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100.h,
                        width: 120.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              postName!,
                              style: on
                                  ? CommonText.TitleM
                                  : CommonText.TitleMediumWhite,
                            ),
                            Text(
                              "게시판 보러가기",
                              style: on
                                  ? CommonText.BodyS
                                  : CommonText.BodySmallWhite,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 45.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: Palette.main,
                              style: BorderStyle.solid,
                              width: 1),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Palette.main,
                          size: 40.w,
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ));
  }
}

class ListItem extends StatelessWidget {
  SignInController signInController = Get.put(SignInController());
  ListItem(
      {Key? key,
      @required this.category,
      @required this.title,
      @required this.id})
      : super(key: key);
  final category;
  final title;
  final id;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isLoading: signInController.checkLoggedIn().value ? false : true,
        skeleton: SkeletonParagraph(),
        child: Container(
          height: 23.h,
          padding: EdgeInsets.only(bottom: 3.h),
          child: Row(children: [
            Text(category, style: CommonText.BodyB),
            SizedBox(width: 8.w),
            Expanded(
                flex: 2,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  strutStyle: StrutStyle(fontSize: 12.0.sp),
                  text: TextSpan(text: title, style: CommonText.BodyS),
                )),
            NewItem(),
          ]),
        ));
  }
}

class NewItem extends StatelessWidget {
  const NewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20.0),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: RadialGradient(
                    colors: [
                      Color(0xffC682FC),
                      Colors.white,
                    ],
                    center: Alignment.center,
                  ),
                ),
              ),
            ),
            Positioned(
                left: 3.w,
                top: 5.h,
                child: Text("N",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: Palette.violet))),
          ],
        ));
  }
}
