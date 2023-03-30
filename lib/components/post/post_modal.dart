import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

class PostModal {
  BuildContext context;
  Widget contents;
  double height;
  String title;
  PostModal({Key? key, required this.context , required this.contents ,required this.height ,required this.title});

  ModalOn() {
    const double modalWidth = 360.0;

    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          height: height.h,
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                      width: modalWidth.w,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Palette.paper, width: 1.0))),
                      child: Center(
                        child: Text(title, style: CommonText.BodyM),
                      )),
                  Container(
                    width: modalWidth.w,
                    color: Colors.white,
                    padding:
                    EdgeInsets.only(top: 16.h, left: 16.h, right: 16.h),
                    child: contents,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ModalOff(){
    return;
  }
}

class ModalButton extends StatelessWidget {
  final String title;
  final void Function()? event;

  ModalButton({Key? key, required this.title, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: event,
      child: Column(
        children: [
          Container(
            width: 183.w,
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.h),
            decoration: BoxDecoration(
                color: Palette.candy,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Center(
              child: Text(
                title,
                style: CommonText.BodyM,
              ),
            ),
          ),
          SizedBox(height: 8.h)
        ],
      ),
    );
  }
}
