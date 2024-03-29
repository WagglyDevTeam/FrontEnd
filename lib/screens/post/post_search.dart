import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/post/post_search_controller.dart';
import 'package:waggly/controller/myPage/my_profile_controller.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/hive/post_search_history.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';

class PostSearchScreen extends StatelessWidget {
  PostSearchScreen({Key? key}) : super(key: key);

  final _searchKeyword = TextEditingController();
  final SignInController signInController = Get.put(SignInController());
  final PostSearchController postSearchController = Get.put(PostSearchController());

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<User>('user');
    var userId = box.get('user')?.id;
    postSearchController.toList(userId!);
    postSearchController.searchResult.value = false;

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
                  width: MediaQuery.of(context).size.width - 80.w,
                  height: 36.0.h,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: CommonText.BodyM,
                    controller: _searchKeyword,
                    maxLines: 1,
                    maxLength: 10,
                    onEditingComplete: () {},
                    autocorrect: false,
                    decoration: InputDecoration(
                      counterText:'',
                      hintText: '게시글 검색',
                      contentPadding: EdgeInsets.only(
                        left: 10.0.w,
                        right: 20.0.w,
                        bottom: 36.0.h / 2, // Vertical Center
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Palette.paperLow,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.lightGray, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.lightGray, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                  Container(
                      alignment: Alignment.center,
                      width: 36.0.w,
                      height: 36.0.h,
                      decoration: BoxDecoration(
                        color: Palette.purple,
                        border: Border.all(color: Palette.purple),
                        shape: BoxShape.circle,
                      ),
                      //child: Text("검색하기", style: CommonText.BodyMediumMain)),
                    child: IconButton(
                        onPressed: (){
                          postSearchController.getInPage.value = false;
                          final searchList = postSearchController.postSearchHistoryBox.value;
                          if (_searchKeyword.text.isEmpty) {
                            CustomSnackBar.messageSnackbar(
                              context,
                              "검색어를 입력해주세요.",
                              EdgeInsets.only(bottom: 60.h, left: 20.w, right: 20.w),
                            );
                          } else {

                            int id = 0;
                            if (postSearchController.historyList.isNotEmpty == true) {
                              final prevItem = searchList.getAt(searchList.length - 1);
                              id = prevItem!.id + 1;
                            }
                            //검색어 찾아오기
                            postSearchController.getSearchPost(_searchKeyword.text);
                            //검색어 하이브에 더하기
                            postSearchController.postSearchHistoryBox.value
                                .add(PostSearchHistory(id: id, userId: userId, keyword: _searchKeyword.text));
                            //검색어 가져오기
                            postSearchController.toList(userId);
                            _searchKeyword.text = '';
                          }
                        },
                        icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 18.w,
                    )),
                ),
              ],
            ),
          ), // 검색영역
          SizedBox(height: 15.0.h),
          Obx(() => postSearchController.getInPage.value == true ? SizedBox(
              height: postSearchController.historyList.length == 0 ? MediaQuery.of(context).size.height - 250.h : 30.h,
              child: SearchHistoryBox(
              itemList:postSearchController.historyList,
          )):
              SizedBox(
                height: MediaQuery.of(context).size.height - 180.h,
                child: postSearchController.searchedPost.length == 0 ? SearchBlank() :SearchPostList(),),),
         //  Obx (() =>
         // SizedBox(
         //     height: MediaQuery.of(context).size.height - 180.h,
         //     child: postSearchController.searchedPost.length == 0 ? SearchBlank() :SearchPostList(),),
         //  // SizedBox(
         //  //   height: MediaQuery.of(context).size.height - 180.h,
         //  //   child: SearchPostList(),
         //  // ),
         //  ),
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
    required this.itemList,
  }) : super(key: key);

  final itemList;
  SignInController signInController = Get.find();
  PostSearchController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    int? userId = Hive.box<User>('user').get('user')?.id;

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Obx(() => itemList.isEmpty == true ? Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            '검색 내역이 존재하지 않습니다.',
            style: CommonText.BodyB,
          ),
        ),
      ):  SizedBox(
        height: 24.0.h,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 7.0.h);
          },
          scrollDirection: Axis.horizontal,
          itemCount: itemList.length,
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
                        itemList[index],
                        style: CommonText.BodyM,
                      ),
                      SizedBox(
                        width: 4.0.w,
                      ),
                      InkWell(
                        onTap: () {
                          controller.deleteSearchHistory(itemList.length - 1 - index);
                          controller.toList(userId!);
                        },
                        child: Container(
                          alignment: AlignmentDirectional(0.w, 0.15.h),
                          child: Icon(Icons.close, size: 10.w),
                        ),
                      ),
                    ],
                  ),
                ),
                if (index == itemList.length - 1)
                  SizedBox(
                    width: 20.w,
                  )
              ],
            );
          },
        ),
      ))
    ]);
  }
}

class SearchPostList extends StatelessWidget {
  SearchPostList({Key? key});
  final ScrollController _scrollController = ScrollController();
  final postDetail = Get.put(PostSearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: postDetail.searchedPost.length,
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          child: Container(
              padding: EdgeInsets.only(
                  top: 16.h, bottom: 16.h, left: 26.w, right: 26.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                        color: Palette.paper,
                        style: BorderStyle.solid,
                        width: 1),
                  )),
              child: Obx(() => PostContext(
                postId: postDetail.searchedPost[index].postId ?? 0,
                postTitle: postDetail.searchedPost[index].postTitle ?? '',
                postDesc: postDetail.searchedPost[index].postDesc ?? '',
                postCreatedAt: postDetail.searchedPost[index].postCreatedAt ?? '',
                authorMajor: postDetail.searchedPost[index].authorMajor ?? '',
                postImageCnt: postDetail.searchedPost[index].postImageCnt ?? 0,
                postLikeCnt: postDetail.searchedPost[index].postLikeCnt ?? 0,
                postCommentCnt: postDetail.searchedPost[index].postCommentCnt ?? 0,
                isLikedByMe: postDetail.searchedPost[index].isLikedByMe ?? false,
                isBlind: postDetail.searchedPost[index].isBlind ?? false,
                isAnonymous: postDetail.searchedPost[index].isAnonymous ?? false,
              )),
            ),
          onTap: (){
            postDetail.selectIndex.value = index;
            // Get.toNamed("/postDetail/param?postId=$postId&collegeName=$collegeType")
          },
        );
      },
    ));
  }
}


class SearchBlank extends StatelessWidget{
  SearchBlank({Key? key});
  final ScrollController _scrollController = ScrollController();
  final postDetail = Get.put(PostSearchController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('찾으시는 검색 결과가 없어요', style: CommonText.BodyB ),
        ],
      ),
    );
  }

}

class PostContext extends StatelessWidget {
  String? postDesc;
  int? postImageCnt;
  int? postLikeCnt;
  int? postCommentCnt;
  bool? isLikedByMe;
  bool? isAnonymous;
  bool? isBlind;
  String? authorMajor;
  String? postTitle;
  String? postCreatedAt;
  int? postId;
  // String? postName;
  // String? collegeType;

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
        this.isAnonymous,
      this.isBlind,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
       // Get.toNamed("/postDetail/param?postId=$postId&collegeName=$collegeType")
      },
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
