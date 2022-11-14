import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatefulWidget {
  const Button({
    Key? key,
    this.text,
    this.mode,
    this.theme,
    this.disabled,
    @required this.onPress,
  }) : super(key: key);
  final text;
  final mode;
  final theme;
  final onPress;
  final disabled;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    if (widget.mode == 'double') {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(18.h, 0, 18.h, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 155.w,
              height: 36.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Color.fromRGBO(218, 175, 254, 0.2)),
              child: TextButton(
                child: Text(
                  '이전',
                  style: TextStyle(
                    color: Color(0xffA558E0),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: widget.onPress,
              ),
            ),
            Container(
              width: 155,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: widget.disabled ? Color(0xffE8E8E8) : Color(0xffB863FB),
              ),
              child: TextButton(
                child: Text(
                  '다음',
                  style: TextStyle(
                    color: Color(0xff959595),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: widget.onPress,
              ),
            ),
          ],
        ),
      );
    } else if (widget.theme == 'abled') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
        child: Container(
          width: double.infinity,
          height: 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: Color.fromRGBO(218, 175, 254, 0.2)),
          child: TextButton(
            child: Text(
              widget.text,
              style: TextStyle(
                color: Color(0xffA558E0),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: widget.onPress,
          ),
        ),
      );
    } else if (widget.theme == 'small') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
        child: Container(
          width: 200.w,
          height: 36.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: Color.fromRGBO(218, 175, 254, 0.2)),
          child: TextButton(
            child: Text(
              widget.text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: widget.onPress,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
      child: Container(
        width: double.infinity,
        height: 36.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: widget.disabled ? Color(0xffE8E8E8) : Color(0xffB863FB)),
        child: TextButton(
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.disabled ? Color(0xff959595) : Color(0xffFFFFFF),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          onPressed: widget.onPress,
        ),
      ),
    );
  }
}
