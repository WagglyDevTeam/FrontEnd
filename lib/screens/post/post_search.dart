import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/chat/chat_search_controller.dart';
import 'package:waggly/controller/myPage/my_profile_controller.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/provider/my_comment_provider.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';

class PostSearchScreen extends StatelessWidget {
  PostSearchScreen({Key? key}) : super(key: key);

  final _searchKeyword = TextEditingController();
  final SignInController signInController = Get.put(SignInController());
  //게시판꺼 나오면 게시판꺼로 변경해야함
  final ChatSearchController chatSearchController = Get.put(ChatSearchController());

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<User>('user');
    var userId = box.get('user')?.id;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(),
      body: Column(
        children: [
          SizedBox(height: 5.0.h),
          Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 15.0.w),
            child: Row(
              children: [
                SizedBox(
                  width: 250.0.w,
                  height: 36.0.h,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: CommonText.BodyM,
                    controller: _searchKeyword,
                    maxLines: 1,
                    onEditingComplete: () {},
                    autocorrect: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 10.0.w,
                        right: 20.0.w,
                        bottom: 36.0.h / 2, // Vertical Center
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.main, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.lavender, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () async {
                    // 게시글 검색어 입력 부분, 아래 주석은 채팅 검색에서 카피한 것
                    // final searchList = chatSearchController.searchHistoryBox.value;
                    //
                    if (_searchKeyword.text.isEmpty) {
                      CustomSnackBar.messageSnackbar(
                        context,
                        "검색어를 입력해주세요.",
                        EdgeInsets.only(bottom: 60.h, left: 20.w, right: 20.w),
                      );
                    } else {
                      int id = 0;
                      // if (chatSearchController.historyList.isNotEmpty == true) {
                      //   final prevItem = searchList.getAt(searchList.length - 1);
                      //   id = prevItem!.id + 1;
                      // }
                      //
                      //   chatSearchController.searchHistoryBox.value
                      //       .add(SearchHistory(id: id, userId: userId, keyword: _searchKeyword.text));
                      //   chatSearchController.toList(userId);
                      //
                      _searchKeyword.text = '';
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 70.0.w,
                      height: 36.0.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Palette.lavender),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("검색하기", style: CommonText.BodyMediumMain)),
                ),
              ],
            ),
          ), // 검색영역
          SizedBox(height: 24.0.h),
          SizedBox(
            height: 65.h,
            child: SearchHistoryBox(
              text: "최근 검색어",
              itemList: chatSearchController.historyList,
              // itemList: chatSearchController.getHistoryList(userId),
            ),
          ), // 최근 검색어
        ],
      ),
    );
  }
}

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  TopAppBar({super.key});
  final SignInController signInController = Get.put(SignInController());

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
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Palette.lightGray),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Palette.gray,
                    iconSize: 20.0.sp,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Container(padding: EdgeInsets.only(bottom: 3.h), child: Text("게시글 검색", style: CommonText.BodyL))
            ],
          ),
          actions: [
            if (signInController.checkLoggedIn().value == true)
              InkWell(
                onTap: () async {
                  // 알림 페이지로 이동
                  await Get.put(NotificationController()).getNotification();
                  Get.put(MyProfileController()).removeData();
                  Get.toNamed('/notification');
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 16.0.w),
                  width: 36.0.w,
                  height: 36.0.h,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Palette.lightGray),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: Palette.gray,
                        size: 18.r,
                      ),
                      Positioned(
                        top: 1.6.h,
                        left: 11.w,
                        // right: -20,
                        child: Container(
                          width: 6.0.w,
                          height: 6.0.h,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5.w, color: Colors.white),
                            color: Color(0xFFFF5F5F),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class SearchHistoryBox extends StatelessWidget {
  SearchHistoryBox({
    Key? key,
    required this.text,
    required this.itemList,
  }) : super(key: key);

  final String text;
  final itemList;
  SignInController signInController = Get.find();
  //chat search history
  ChatSearchController controller = Get.find();

  //dummy search list
  //final list = ['job', 'work', 'cake'];
  final list = [];

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: CommonText.TitleS,
          ),
        ),
      ), // 타이틀
      SizedBox(height: 10.0.h),
      if (list.isNotEmpty)
        SizedBox(
          height: 24.0.h,
          child: ListView.separated(
            itemBuilder: (item, index) {
              return Row(
                children: [
                  if (index == 0) SizedBox(width: 20.0.w),
                  Container(
                    alignment: AlignmentDirectional(0.w, 0.h),
                    height: 24.0.h,
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    decoration: BoxDecoration(
                      color: Palette.candy,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          list[index],
                          style: CommonText.BodyM,
                        ),
                        SizedBox(
                          width: 4.0.w,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: AlignmentDirectional(0.w, 0.15.h),
                            child: Icon(Icons.close, size: 10.w),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index == list.length - 1)
                    SizedBox(
                      width: 20.w,
                    )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 7.0.h);
            },
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
          ),
        )
      else if (list.isEmpty)
        Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 24.0.h,
            child: Text(
              '검색 내역이 존재하지 않습니다.',
              style: CommonText.BodyMediumGray,
            ),
          ),
        )
    ]);
  }
}

class SearchPostList extends StatelessWidget {
  SearchPostList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.only(
        //     top: 16, bottom: 16, left: 26, right: 26),
        // decoration: BoxDecoration(
        //     color: Colors.white,
        //     border: Border(
        //       top: BorderSide(
        //           color: Palette.paper,
        //           style: BorderStyle.solid,
        //           width: 1),
        //     )),
        // child: Obx(() => PostContext(
        //   postId:
        //   _postDetailX.postCollegeData[postInt].postId ??
        //       0,
        //   postTitle: _postDetailX
        //       .postCollegeData[postInt].postTitle ??
        //       '',
        //   postDesc: _postDetailX
        //       .postCollegeData[postInt].postDesc ??
        //       '',
        //   postCreatedAt: _postDetailX
        //       .postCollegeData[postInt].postCreatedAt ??
        //       '',
        //   authorMajor: _postDetailX
        //       .postCollegeData[postInt].authorMajor ??
        //       '',
        //   postImageCnt: _postDetailX
        //       .postCollegeData[postInt].postImageCnt ??
        //       0,
        //   postLikeCnt: _postDetailX
        //       .postCollegeData[postInt].postLikeCnt ??
        //       0,
        //   postCommentCnt: _postDetailX
        //       .postCollegeData[postInt].postCommentCnt ??
        //       0,
        //   isLikedByMe: _postDetailX
        //       .postCollegeData[postInt].isLikedByMe ??
        //       false,
        //   isBlind:
        //   _postDetailX.postCollegeData[postInt].isBlind ??
        //       false,
        //   postName: postName,
        //   collegeType: _pageTitle,
        // )),
        );
  }
}

class PostContext extends StatelessWidget {
  String? postDesc;
  int? postImageCnt;
  int? postLikeCnt;
  int? postCommentCnt;
  bool? isLikedByMe;
  bool? isBlind;
  String? authorMajor;
  String? postTitle;
  String? postCreatedAt;
  int? postId;
  String? postName;
  String? collegeType;

  PostContext(
      {Key? key,
      this.postId,
      this.postTitle,
      this.postDesc,
      this.postCreatedAt,
      this.authorMajor,
      this.postImageCnt,
      this.postLikeCnt,
      this.postCommentCnt,
      this.isLikedByMe,
      this.isBlind,
      this.postName,
      this.collegeType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Get.toNamed("/postDetail/param?postId=$postId&collegeName=$collegeType")},
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 210.w,
                child: Text(postTitle ?? "", style: CommonText.BodyL),
              ),
              Text(postCreatedAt ?? "", style: CommonText.BodyEngGray),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: MediaQuery.of(context).size.width - 32.w,
            child: Text(postDesc ?? "", style: CommonText.BodyS),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(authorMajor ?? "", style: CommonText.BodyEngGray),
            ],
          )
        ],
      ),
    );
  }
}
