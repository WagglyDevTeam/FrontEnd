import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RenderTextFormField extends StatefulWidget {
  const RenderTextFormField(
      {Key? key, this.mode, this.placeholder, this.buttonText, this.label, this.controller})
      : super(key: key);
  final mode;
  final placeholder;
  final buttonText;
  final label;
  final controller;

  @override
  State<RenderTextFormField> createState() => _RenderTextFormFieldState();
}

class _RenderTextFormFieldState extends State<RenderTextFormField> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.mode == 'withButtonAndLabel') {
      return Container(
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.label,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp)),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            SizedBox(
              height: 34.h,
              child: Row(children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(218, 175, 254, 1))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(218, 175, 254, 0.5),
                          ),
                          borderRadius: BorderRadius.circular(4)),
                      hintText: widget.placeholder,
                        hintStyle: TextStyle( color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)
                    ),
                    onSaved: (val) {},
                    validator: (val) {},
                  ),
                ),
                Container(
                  width: 70.w,
                  margin: EdgeInsets.fromLTRB(8.w, 0.h, 0.w, 0.h),
                  padding: EdgeInsets.fromLTRB(0.w, 3.h, 0.w, 3.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(color: Color.fromRGBO(182, 182, 182, 1))),
                  child: TextButton(
                    child: Text(
                      widget.buttonText,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff959595)),
                    ),
                    onPressed: () {},
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 12.h,
            ),
          ],
        ),
      );
    }

    if (widget.mode == 'withButton') {
      Padding(
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 1.8.w, 0.h),
        child: Column(children: [
          SizedBox(
            height: 4.h,
          ),
          TextFormField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(218, 175, 254, 0.5),
                  ),
                  borderRadius: BorderRadius.circular(4)),
              hintText: widget.placeholder,
                hintStyle: TextStyle( color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)
            ),
            onSaved: (val) {},
            validator: (val) {},
          ),
          SizedBox(
            height: 12.h,
          ),
        ]),
      );
    }

    if (widget.mode == 'withLabel') {
      return Padding(
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
        child: Column(children: [
          Row(
            children: [
              Text(widget.label,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp)),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 34.h,
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(218, 175, 254, 0.5),
                    ),
                    borderRadius: BorderRadius.circular(4)),
                hintText: widget.placeholder,
                  hintStyle: TextStyle( color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)
              ),
              onSaved: (val) {},
              validator: (val) {},
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
        ]),
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
          child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(218, 175, 254, 0.5),
                  ),
                  borderRadius: BorderRadius.circular(4)),
              hintText: widget.placeholder,
                hintStyle: TextStyle( color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.h)
            ),
            onSaved: (val) {},
            validator: (val) {},
            controller: widget.controller,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
      ],
    );
  }
}
