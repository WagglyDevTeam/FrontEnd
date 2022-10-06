import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waggly/components/post/post_modal.dart';

import '../../utils/colors.dart';
import '../../utils/text_frame.dart';
import '../../widgets/index.dart';
import '../../widgets/sign_in.dart';

enum Status { home, main, detail, edit, login, alarm, editAlarmOnly, chatRoom }

class PostAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String postName;
  final Status page;

  @override
  Size get preferredSize => page == Status.chatRoom ? Size.fromHeight(55) : Size.fromHeight(68);

  const PostAppbar({Key? key, required this.postName, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      title: leadingCase(context),
      actions: [ActionCase()],
    );
  }

  leadingCase(context) {
    switch (page) {
      case Status.alarm:
      case Status.main:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [SizedBox.shrink(), Text(postName, style: CommonText.TitleM)],
        );
      case Status.login:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [SizedBox.shrink(), Text(postName, style: CommonText.TitleM)],
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => postName == '채팅 검색' ? print("임시 위치로, 뒤로가기를 수행하지 않습니다.") : Navigator.of(context).pop(),
              child: SvgPicture.asset(
                'assets/icons/btn_back_default.svg',
                fit: BoxFit.contain,
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(postName, style: CommonText.BodyL)
          ],
        );
    }
  }

  ActionCase() {
    switch (page) {
      case Status.home:
        return ActionBtns();
      case Status.main:
        return ActionBtns();
      case Status.login:
        return LoginBtn();
      case Status.edit:
        return Text('edit');
      case Status.editAlarmOnly:
        return AlarmOnly();
      case Status.detail:
        return DetailBtn();
      case Status.alarm:
        return AlarmBtns();
      case Status.chatRoom:
        return ChatRoomBtns();
    }
  }
}

class ActionBtns extends StatelessWidget {
  const ActionBtns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40.0) // POINT
                ),
            border: Border.all(width: 1.0, color: Palette.lightGray),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActionButton(
                    event: () => Get.toNamed("/writePage"),
                    isIcon: Icon(
                      Icons.add,
                      color: Palette.gray,
                      size: 15,
                    )),
                Line(),
                ActionButton(
                    event: () => Get.toNamed("/writePage"),
                    isIcon: Icon(
                      Icons.search,
                      color: Palette.gray,
                      size: 15,
                    )),
                Line(),
                ActionButton(
                    event: () => Get.toNamed("/writePage"),
                    isIcon: Icon(
                      Icons.notifications_none,
                      color: Palette.gray,
                      size: 15,
                    )),
              ],
            ),
          )),
    );
  }

  Line() {
    return const SizedBox(
      width: 1,
      height: 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              // POINT
              color: Color(0xFFE8E8E8),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

PageRouteWithAnimation sign = PageRouteWithAnimation(const SignUpRoute());

class LoginBtn extends StatelessWidget {
  const LoginBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(sign.slideRitghtToLeft()),
      child: Container(
        width: 80,
        padding: const EdgeInsets.only(top: 14, bottom: 10, left: 12, right: 12),
        child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(40.0) // POINT
                  ),
              color: Palette.main,
            ),
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Text('로그인', style: CommonText.LabelWhite, textAlign: TextAlign.center),
            )),
      ),
    );
  }
}

class DetailBtn extends StatelessWidget {
  const DetailBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double modalHeight = 163.0;
    const String title = '글 메뉴';
    void postDelete() {
      Navigator.pop(context);
    }

    void postFix() {
      Navigator.pop(context);
    }

    PostModal modalOn = PostModal(context: context, contents: Buttons(), height: modalHeight, title: title);
    return GestureDetector(
      onTap: () => {modalOn.ModalOn()},
      child: Container(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/icons/top_modal_dot.svg',
            fit: BoxFit.contain,
            width: 35.w,
          )),
    );
  }

  Buttons() {
    return Column(
      children: [
        ModalButton(title: '삭제하기', event: () {}),
        ModalButton(
            title: '수정하기',
            event: () {
              print("asdasdasd");
              Get.toNamed("/editPage");
            }),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final Icon isIcon;
  final void Function()? event;

  ActionButton({Key? key, required this.isIcon, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15,
      height: 15,
      child: GestureDetector(
        onTap: event,
        child: isIcon,
      ),
    );
  }
}

class AlarmBtns extends StatelessWidget {
  const AlarmBtns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40.0) // POINT
                ),
            border: Border.all(width: 1.0, color: Palette.lightGray),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActionButton(
                    event: () => Navigator.of(context).pop(),
                    isIcon: Icon(
                      Icons.add,
                      color: Palette.gray,
                      size: 15,
                    )),
                Line(),
                ActionButton(
                    event: () => Navigator.of(context).pop(),
                    isIcon: Icon(
                      Icons.search,
                      color: Palette.gray,
                      size: 15,
                    ))
              ],
            ),
          )),
    );
  }

  Line() {
    return const SizedBox(
      width: 1,
      height: 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              // POINT
              color: Color(0xFFE8E8E8),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class AlarmOnly extends StatelessWidget {
  const AlarmOnly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: InkWell(
        onTap: () {
          // 알림 페이지로 이동
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
      ),
    );
  }
}

class ChatRoomBtns extends StatelessWidget {
  const ChatRoomBtns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      // color: Colors.red,
      padding: EdgeInsets.fromLTRB(10.w, 15.h, 20.w, 5.h),
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40.0) // POINT
                ),
            border: Border.all(width: 1.0, color: Palette.lightGray),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActionButton(
                    event: () => Navigator.of(context).pop(),
                    isIcon: Icon(
                      Icons.search,
                      color: Palette.gray,
                      size: 18,
                    )),
                Line(),
                ActionButton(
                    event: () => Scaffold.of(context).openEndDrawer(),
                    isIcon: Icon(
                      Icons.more_horiz,
                      color: Palette.gray,
                      size: 18,
                    )),
              ],
            ),
          )),
    );
  }

  Line() {
    return const SizedBox(
      width: 1,
      height: 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              // POINT
              color: Color(0xFFE8E8E8),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
