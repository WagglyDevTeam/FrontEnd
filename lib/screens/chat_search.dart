import 'package:flutter/material.dart';
import 'package:waggly/components/post/custom_text_form_field.dart';
import 'package:waggly/components/post/post_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/utils/text_frame.dart';

class ChatSearchScreen extends StatelessWidget {
  final String _postName = "채팅 검색";
  final Status _page = Status.editAlarmOnly;
  final _searchKeyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PostAppbar(
        postName: _postName,
        page: _page,
      ),
      body: Column(
        children: [
          TextFormField(
            style: CommonText.BodyM,
            controller: _searchKeyword,
            maxLines: 1,
            onEditingComplete: () {},
            autocorrect: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF8F8F8),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            width: 20.0,
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
