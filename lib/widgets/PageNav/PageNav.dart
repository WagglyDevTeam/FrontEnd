import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/textFrame.dart';

class PageNav extends StatefulWidget {
  const PageNav({
    Key? key,
    this.pageTitle,
    this.noBorder,
  }) : super(key: key);
  final pageTitle;
  final noBorder;

  @override
  State<PageNav> createState() => _PageNavState();
}

class _PageNavState extends State<PageNav> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                margin: EdgeInsets.only(top: 20, right: 10, left: 16),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Palette.lightGray),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Palette.gray,
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                width: 200,
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  widget.pageTitle,
                  style: CommonText.BodyL,
                ),
              ),
            ],
          ),
        ),
        Divider(
            thickness: 1,
            height: 1,
            color: widget.noBorder ? Colors.transparent : Palette.paper),
      ],
    );
  }
}
