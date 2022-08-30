import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/components/post/post_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/controller/major/major_controller.dart';

import 'package:waggly/widgets/textFormField/text_form_field.dart';

class MajorSearchScreen extends StatelessWidget {
  final String _postName = "학과 검색";
  final Status _page = Status.editAlarmOnly;
  final _searchKeyword = TextEditingController();
  final MajorController _majorController = Get.put(MajorController());
  final List<String> majorList;

  MajorSearchScreen({required this.majorList});

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
            SizedBox(
              height: 30.h,
            ),
            RenderTextFormField(
              mode: 'searchBar',
              searchList: majorList,
              placeholder: '학과 검색',
              buttonText: '검색하기',
              controller: _searchKeyword,
              onclick: () async {
                // TODO:59 임시로 여기에 만들어놓음
                await _majorController.getMajorListByUniversityName("서울대학교");
                final majorList = _majorController.majorList;
                for (var major in majorList) {
                  print(major.majorName);
                }
              },
            ),
          ],
        ));
  }
}
