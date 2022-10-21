import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/utils/text_frame.dart';

class CustomCheck extends StatefulWidget {
  Function? onChange;
  bool? isChecked;
  double? size;
  double? iconSize;
  Color? selectedColor;
  Color? selectedIconColor;
  Color? borderColor;
  Icon? checkIcon;
  Color? bgColor;
  String? label;

  CustomCheck(
      {Key? key,
      this.isChecked,
      this.onChange,
      this.size,
      this.iconSize,
      this.selectedColor,
      this.selectedIconColor,
      this.borderColor,
      this.checkIcon,
      this.bgColor,
      this.label})
      : super(key: key);

  @override
  _CustomCheckState createState() => _CustomCheckState();
}

class _CustomCheckState extends State<CustomCheck> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChange!(_isSelected);
        });
      },
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
            decoration: BoxDecoration(
                color: _isSelected
                    ? widget.selectedColor ?? Colors.blue
                    : widget.bgColor ?? Colors.transparent,
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(
                  color: widget.borderColor ?? Colors.black,
                  width: 1.5,
                )),
            width: widget.size ?? 18,
            height: widget.size ?? 18,
            child: _isSelected
                ? Icon(
                    Icons.check,
                    color: widget.selectedIconColor ?? Colors.white,
                    size: widget.iconSize ?? 14,
                  )
                : null,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            widget.label ?? '',
            style: CommonText.BodyMediumGray,
          )
        ],
      ),
    );
  }
}
