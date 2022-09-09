import "dart:ui";
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/components/Post/post_app_bar.dart';
import 'package:waggly/components/Post/post_common.dart';
import 'package:waggly/utils/text_frame.dart';
import '../model/postCollege/dtos/post_college_dto.dart';
import '../utils/colors.dart';

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);

  PostCollegeData myCollege = PostCollegeData.fromJson({
    "postCollegeName": "예술계열",
    "postColoegeId": "art",
    "postList": [
      {
        "authorMajor": "스포츠레저학과",
        "postTitle": "전공 수업 질문 안녕하아아 아아아아아아",
        "postCreatedAt": "20210101",
        "postId": 563
      },
      {
        "authorMajor": "시각디자인과",
        "postTitle": "다들 노트북 어떤 제품 많이 써?",
        "postCreatedAt": "20210101",
        "postId": 12
      },
      {
        "authorMajor": "기악과",
        "postTitle": "악기 브랜드 뭐써?",
        "postCreatedAt": "20220301",
        "postId": 6
      },
      {
        "authorMajor": "서양화과",
        "postTitle": "다들 학교 커리큘럼",
        "postCreatedAt": "20220303",
        "postId": 36
      },
      {
        "authorMajor": "공업디자인과",
        "postTitle": "아와 과제 개 많아",
        "postCreatedAt": "20220320",
        "postId": 1556
      }
    ]
  });

  List<PostCollegeData> otherCollege = [
    PostCollegeData.fromJson({
      "postCollegeName": "자연계열",
      "postColoegeId": "nature_science",
      "postList": [
        {
          "authorMajor": "스포츠레저학과1",
          "postTitle": "전공 수업 질문 안녕하아아 아아아아아아",
          "postCreatedAt": "20210101",
          "postId": 563
        },
        {
          "authorMajor": "시각디자인과1",
          "postTitle": "다들 노트북 어떤 제품 많이 써?",
          "postCreatedAt": "20210101",
          "postId": 12
        },
        {
          "authorMajor": "기악과1",
          "postTitle": "악기 브랜드 뭐써?",
          "postCreatedAt": "20220301",
          "postId": 6
        },
        {
          "authorMajor": "서양화과1",
          "postTitle": "다들 학교 커리큘럼",
          "postCreatedAt": "20220303",
          "postId": 36
        },
        {
          "authorMajor": "공업디자인과1",
          "postTitle": "아와 과제 개 많아",
          "postCreatedAt": "20220320",
          "postId": 1556
        }
      ]
    }),
    PostCollegeData.fromJson({
      "postCollegeName": "공과계열",
      "postColoegeId": "engineering_science",
      "postList": [
        {
          "authorMajor": "스포츠레저학과2",
          "postTitle": "전공 수업 질문 안녕하아아 아아아아아아",
          "postCreatedAt": "20210101",
          "postId": 563
        },
        {
          "authorMajor": "시각디자인과2",
          "postTitle": "다들 노트북 어떤 제품 많이 써?",
          "postCreatedAt": "20210101",
          "postId": 12
        },
        {
          "authorMajor": "기악과3",
          "postTitle": "악기 브랜드 뭐써?",
          "postCreatedAt": "20220301",
          "postId": 6
        },
        {
          "authorMajor": "서양화과1",
          "postTitle": "다들 학교 커리큘럼",
          "postCreatedAt": "20220303",
          "postId": 36
        },
        {
          "authorMajor": "공업디자인과1",
          "postTitle": "아와 과제 개 많아",
          "postCreatedAt": "20220320",
          "postId": 1556
        }
      ]
    }),
    PostCollegeData.fromJson({
      "postCollegeName": "인문계열",
      "postColoegeId": "social",
      "postList": [
        {
          "authorMajor": "스포츠레저학과1s",
          "postTitle": "전공 수업 질문 안녕하아아 아아아아아아",
          "postCreatedAt": "20210101",
          "postId": 563
        },
        {
          "authorMajor": "시각디자인과1s",
          "postTitle": "다들 노트북 어떤 제품 많이 써?",
          "postCreatedAt": "20210101",
          "postId": 12
        },
        {
          "authorMajor": "기악과1s",
          "postTitle": "악기 브랜드 뭐써?",
          "postCreatedAt": "20220301",
          "postId": 6
        },
        {
          "authorMajor": "서양화과1",
          "postTitle": "다들 학교 커리큘럼",
          "postCreatedAt": "20220303",
          "postId": 36
        },
        {
          "authorMajor": "공업디자인과1",
          "postTitle": "아와 과제 개 많아",
          "postCreatedAt": "20220320",
          "postId": 1556
        }
      ]
    })
  ];

  @override
  Widget build(BuildContext context) {
    bool? on = false;
    bool? off = true;
    PostCollegeData myCollegeData = myCollege;
    List<PostCollegeData>? otherCollegeData =
    otherCollege ;
    String? myCollegeName = myCollegeData.postCollegeName;
    String? myCollegeId = myCollegeData.postColoegeId;
    List<PostListData>? myCollegepreview = myCollegeData.postList;
    Status? page = Status.main;
    String? postName = "게시판";

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PostAppbar(
          page: page,
          postName: postName,
        ),
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
                    Text(myCollegeName, style: CommonText.TitleS),
                    SizedBox(width: 6.w),
                    Icon(Icons.auto_awesome, color: Palette.main, size: 17),
                  ],
                ),
                SizedBox(height: 10.h),
                PostCard(
                  datas: myCollegepreview,
                  postName: myCollegeName,
                  collegeId: myCollegeId,
                  on: on,
                  page: page,
                ),
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
                  child: PostDifferentList(widgetList: [
                    for (var i = 0; i < otherCollegeData.length; i++)
                      Row(
                        children: [
                          PostCard(
                            datas: otherCollegeData[i].postList,
                            postName: otherCollegeData[i].postCollegeName,
                            collegeId: otherCollegeData[i].postColoegeId,
                            on: off,
                            page: page,
                          ),
                          SizedBox(width: 20.w)
                        ],
                      )
                  ]),
                )
              ]),
        ));
  }
}

class PostCard extends StatelessWidget {
  List<PostListData>? datas;
  String? postName;
  Status? page;
  String? collegeId;
  final on;
  PostCard({
    Key? key,
    @required this.datas,
    @required this.postName,
    @required this.on,
    @required this.page,
    @required this.collegeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (page == 'login') {
            Get.toNamed("/postCollege/$collegeId");
          } else {
            Get.toNamed("/postCollege/$collegeId");
          }
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
                  itemCount: datas?.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (page == "login") {
                      return Stack(
                        children: [
                          ListItem(
                              category: datas?[index].authorMajor,
                              title: datas?[index].postTitle,
                              date: datas?[index].postCreatedAt,
                              id: datas?[index].postId),
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
                          category: datas?[index].authorMajor,
                          title: datas?[index].postTitle,
                          date: datas?[index].postCreatedAt,
                          id: datas?[index].postId);
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
                        height: 100,
                        width: 120,
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
                          size: 40,
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
  ListItem(
      {Key? key,
        @required this.category,
        @required this.title,
        @required this.date,
        @required this.id})
      : super(key: key);
  final category;
  final title;
  final date;
  final id;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
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
                left: 3,
                top: 5,
                child: Text("N",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: Palette.violet))),
          ],
        ));
  }
}
