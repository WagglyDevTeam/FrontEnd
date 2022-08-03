import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wagly/components/Post/post_app_bar.dart';
import 'package:wagly/components/Post/post_common.dart';
import 'package:wagly/utils/textFrame.dart';
import 'package:wagly/widgets/signIn.dart';
import '../components/Post/post_affiliation.dart';
import '../components/Post/post_data.dart';
import '../utils/colors.dart';
import 'package:wagly/widgets/index.dart';

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);
  List<PostListData> dummy = [
    PostListData.fromMap({
      'authorMajor': '스포츠레저학과',
      'postTitle': '전공 수업 질문 안녕하아아 아아아아아아',
      'postCreatedAt': '20210101',
      'postId': 563
    }),
    PostListData.fromMap({
      'authorMajor': '시각디자인과',
      'postTitle': '다들 노트북 어떤 제품 많이 써?',
      'postCreatedAt': '20210101',
      'postId': 12
    }),
    PostListData.fromMap({
      'authorMajor': '기악과',
      'postTitle': '악기 브랜드 뭐써?',
      'postCreatedAt': '20220301',
      'postId': 6
    }),
    PostListData.fromMap({
      'authorMajor': '서양화과',
      'postTitle': '다들 학교 커리큘럼',
      'postCreatedAt': '20220303',
      'postId': 36
    }),
    PostListData.fromMap({
      'authorMajor': '공업디자인과',
      'postTitle': '아와 과제 개 많아',
      'postCreatedAt': '20220320',
      'postId': 1556
    })
  ];

  @override
  Widget build(BuildContext context) {
    bool on = false;
    bool off = true;
    String mySchool = '예술체육계열';
    Status page = Status.main;
    String postName = '게시판';

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PostAppbar(
          page: page,
          postName: postName,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Text(mySchool, style: CommonText.BodyL),
                    SizedBox(width: 6),
                    Icon(Icons.auto_awesome, color: Palette.main, size: 17),
                  ],
                ),
                SizedBox(height: 5),
                PostCard(
                  datas: page == 'login ' ? dummy : dummy,
                  postName: mySchool,
                  on: on,
                  page: page,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text('다른 계열 둘러보기', style: CommonText.BodyL),
                    SizedBox(width: 6),
                  ],
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 190,
                  child: PostDifferentList(widgetList: [
                    PostCard(
                      datas: page == 'login ' ? dummy : dummy,
                      postName: '자연계열',
                      on: off,
                      page: page,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    PostCard(
                      datas: page == 'login ' ? dummy : dummy,
                      postName: '공과계열',
                      on: off,
                      page: page,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    PostCard(
                      datas: page == 'login' ? dummy : dummy,
                      postName: '인문계열',
                      on: off,
                      page: page,
                    )
                  ]),
                )
              ]),
        ));
  }
}

class PostCard extends StatelessWidget {
  PostCard(
      {Key? key,
      @required this.datas,
      @required this.postName,
      @required this.on,
      @required this.page})
      : super(key: key);
  final datas;
  final postName;
  final on;
  final page;
  @override
  Widget build(BuildContext context) {
    PageRouteWithAnimation postingList =
        PageRouteWithAnimation(PostAffiliation(postName: postName));
    PageRouteWithAnimation sign = PageRouteWithAnimation(SignUpRoute());
    return Container(
      height: 195,
      width: 250,
      padding: EdgeInsets.only(left: 10, top: 8, right: 10, bottom: 8),
      // margin: EdgeInsets.only(right:on ? 30 : 0),
      decoration: BoxDecoration(
          color: on ? Palette.paper : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
              color: on ? Palette.paper : Palette.light,
              style: BorderStyle.solid,
              width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(5),
              itemCount: datas.length,
              itemBuilder: (BuildContext context, int index) {
                if (page == 'login') {
                  return Stack(
                    children: [
                      ListItem(
                          category: datas[index].authorMajor,
                          title: datas[index].postTitle,
                          date: datas[index].postCreatedAt,
                          id: datas[index].postId),
                      Positioned(
                          top: 1,
                          left: 1,
                          child: SizedBox(
                            height: 20,
                            width: 200,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 2),
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
                      category: datas[index].authorMajor,
                      title: datas[index].postTitle,
                      date: datas[index].postCreatedAt,
                      id: datas[index].postId);
                }
              },
            ),
          ),
          GestureDetector(
              onTap: () {
                if (page == 'login') {
                  Navigator.of(context).push(sign.slideLeftToRight());
                } else {
                  Navigator.of(context).push(postingList.slideLeftToRight());
                }
              },
              child: Container(
                height: 60,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: on ? Colors.white : Palette.main,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            postName,
                            style: on
                                ? CommonText.TitleS
                                : CommonText.TitleSmallWhite,
                          ),
                          Text(
                            '게시판 보러가기',
                            style: on
                                ? CommonText.BodyS
                                : CommonText.BodySmallWhite,
                          )
                        ],
                      ),
                      Container(
                        width: 35,
                        height: 35,
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
                          size: 30,
                        ),
                      )
                    ]),
              )),
        ],
      ),
    );
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
    return SizedBox(
      height: 20,
      child: Row(children: [
        Text(category, style: CommonText.BodyB),
        SizedBox(width: 8),
        Expanded(
            flex: 2,
            child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              strutStyle: StrutStyle(fontSize: 12.0),
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
                width: 20,
                height: 20,
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
                child: Text('N',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Palette.violet))),
          ],
        ));
  }
}
