import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waggly/components/post/post_modal.dart';
import 'package:waggly/controller/postDetail/post_detail_controller.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/index.dart';
import 'package:waggly/widgets/sign_in.dart';
import 'package:waggly/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';

enum Status {
  home,
  main,
  board,
  boardTitle,
  detail,
  boardDetail,
  edit,
  login,
  setting,
  editAlarmOnly,
  chatList
}

class PageAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final Status page;
  double appbarHeight = 68.0.h;
  SignInController signInController = Get.find();

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight);

  PageAppbar({Key? key, required this.pageTitle, required this.page})
      : super(key: key);

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
          title: leadingCase(context),
          actions: [actionCase()],
        )
      ],
    );
  }

  leadingCase(context) {
    switch (page) {
      case Status.main:
      case Status.home:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.shrink(),
            Text(
              pageTitle,
              style: CommonText.TitleL,
            )
          ],
        );
      case Status.login:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.shrink(),
            Text(pageTitle, style: CommonText.TitleL)
          ],
        );
      default:
        return Row(
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
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
                padding: EdgeInsets.only(bottom: 3.h),
                child: Text(pageTitle, style: CommonText.BodyL))
          ],
        );
    }
  }

  actionCase() {
    switch (page) {
      case Status.home:
        if (signInController.checkLoggedIn().value == true) {
          return ActionBtn();
        } else {
          return LoginBtn();
        }
        ;
      case Status.boardTitle:
        return ActionBtn();
      case Status.login:
        return LoginBtn();
      case Status.edit:
        return Text('edit');
      case Status.editAlarmOnly:
        return AlarmBtn();
      case Status.boardDetail:
        return DetailBtn();
      case Status.chatList:
        return SearchAlarmPairBtn();
      case Status.setting:
        return Empty();
    }
  }
}

class ActionBtn extends StatelessWidget {
  const ActionBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0.w, top: 7.0.h),
      padding: EdgeInsets.all(10.0.r),
      width: 155.0.w,
      height: 36.0.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40.0) // POINT
            ),
        border: Border.all(width: 1.0, color: Palette.lightGray),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ActionButton(
              event: () => Get.toNamed("/writePage"),
              isIcon: Icon(
                Icons.add,
                color: Palette.gray,
                size: 18.w,
              )),
          line(),
          ActionButton(
              event: () => Get.toNamed("/writePage"),
              isIcon: Icon(
                Icons.search,
                color: Palette.gray,
                size: 18.w,
              )),
          line(),
          ActionButton(
              event: () async {
                // 알림 페이지로 이동
                await Get.put(NotificationController()).getNotification();
                Get.toNamed('/notification');
              },
              isIcon: Icon(
                Icons.notifications_none,
                color: Palette.gray,
                size: 18.w,
              )),
        ],
      ),
    );
  }

  line() {
    return const SizedBox(
      width: 1,
      height: 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              // POINT
              color: Palette.lightGray,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginBtn extends StatelessWidget {
  const LoginBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed('/signInPage');
          },
          child: Container(
            margin: EdgeInsets.only(right: 16.0.w),
            alignment: Alignment.center,
            width: 60.0.w,
            height: 24.0.h,
            child: Text(
              "로그인",
              style: CommonText.LabelWhite,
            ),
            decoration: BoxDecoration(
              color: Palette.main,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }
}

class DetailBtn extends StatelessWidget {
  DetailBtn({Key? key}) : super(key: key);

  /// 게시판 상세 페이지 GetX 데이터
  final PostDetailController _postDetailX = Get.put(PostDetailController());

  @override
  Widget build(BuildContext context) {
    double modalHeight = 163.0.h;
    String title = '글 메뉴';
    void postDelete() {
      Navigator.pop(context);
    }

    void postFix() {
      Navigator.pop(context);
    }

    PostModal modalOn = PostModal(
        context: context,
        contents: buttons(),
        height: modalHeight,
        title: title);
    return GestureDetector(
      onTap: () => {modalOn.ModalOn()},
      child: Container(
          margin: EdgeInsets.only(right: 16.w),
          child: SvgPicture.asset(
            'assets/icons/top_modal_dot.svg',
            fit: BoxFit.contain,
            width: 36.w,
            height: 36.h,
          )),
    );
  }

  buttons() {
    return Column(
      children: [
        ModalButton(
            title: '삭제하기',
            event: () {
              _postDetailX.postDelete(
                  postId: _postDetailX.postDetail.value.postId ?? 0);
            }),
        ModalButton(title: '수정하기', event: () {Get.toNamed("/editPage");}),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final Icon isIcon;
  final void Function()? event;

  ActionButton({Key? key, required this.isIcon, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: event,
      child: isIcon,
    );
  }
}

class SearchAlarmPairBtn extends StatelessWidget {
  const SearchAlarmPairBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 16.0.w, top: 7.0.h),
        padding: EdgeInsets.all(10.0.r),
        width: 104.0.w,
        height: 36.0.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40.0) // POINT
              ),
          border: Border.all(width: 1.0, color: Palette.lightGray),
          // shape: BoxShape.circle,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionButton(
                event: () => {},
                isIcon: Icon(
                  Icons.add,
                  color: Palette.gray,
                  size: 18.w,
                )),
            line(),
            ActionButton(
                event: () async {
                  // 알림 페이지로 이동
                  await Get.put(NotificationController()).getNotification();
                  Get.toNamed('/notification');
                },
                isIcon: Icon(
                  Icons.notifications_none,
                  color: Palette.gray,
                  size: 18.w,
                )),
          ],
        ));
  }

  line() {
    return const SizedBox(
      width: 1,
      height: 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              // POINT
              color: Palette.lightGray,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class AlarmBtn extends StatelessWidget {
  const AlarmBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // 알림 페이지로 이동
        await Get.put(NotificationController()).getNotification();
        Get.toNamed('/notification');
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 15.0.w, top: 7.0.h),
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
    );
  }
}

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
