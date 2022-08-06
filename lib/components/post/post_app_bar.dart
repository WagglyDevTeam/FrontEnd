import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/index.dart';
import 'package:waggly/widgets/sign_in.dart';
import '../../screens/write_page.dart';
import '../../utils/colors.dart';

enum Status { home, main, detail, edit, login }

class PostAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String postName;
  final Status page;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  const PostAppbar({Key? key, required this.postName, required this.page})
      : super(key: key);

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
      case Status.main:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.shrink(),
            Text(postName, style: CommonText.TitleM)
          ],
        );
      case Status.login:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.shrink(),
            Text(postName, style: CommonText.TitleM)
          ],
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
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
      case Status.detail:
        return DetailBtn();
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
            padding:
                const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActionButton(
                    event: () => Get.to(() => WritePage()),
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
                    )),
                Line(),
                ActionButton(
                    event: () => Navigator.of(context).pop(),
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
        padding:
            const EdgeInsets.only(top: 14, bottom: 10, left: 12, right: 12),
        child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(40.0) // POINT
                      ),
              color: Palette.main,
            ),
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Text('로그인',
                  style: CommonText.LabelWhite, textAlign: TextAlign.center),
            )),
      ),
    );
  }
}

class DetailBtn extends StatelessWidget {
  const DetailBtn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(sign.slideRitghtToLeft()),
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 7, left: 12, right: 12),
        child: SvgPicture.asset(
          'assets/icons/more_doc.svg',
          fit: BoxFit.contain,
          width: 30,
          height: 30,
        ),
      ),
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
