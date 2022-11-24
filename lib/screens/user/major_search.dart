import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';
import 'package:waggly/controller/major/major_controller.dart';
import 'package:waggly/controller/signUp/sign_up_controller.dart';

import 'package:waggly/widgets/textFormField/text_form_field.dart';

class MajorSearchScreen extends StatelessWidget {
  final MajorController _majorController = Get.put(MajorController());
  final SignUpController _signUpController = Get.put(SignUpController());
  final String universityName;
  final TextEditingController controller;

  // final List<String> majorList;

  MajorSearchScreen({required this.universityName, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: TopAppBar(),
        body: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            RenderTextFormField(
              mode: 'searchBar',
              placeholder: '학과 검색',
              buttonText: '검색하기',
              controller: controller,
              universityName: universityName,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
              child: Obx(
                () => Container(
                  height: 36.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: _signUpController.majorInputEmpty.value == true ? Color(0xffE8E8E8) : Color(0xffB863FB),
                  ),
                  child: TextButton(
                    child: Text(
                      '선택 완료',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () async {
                      // input 값이 major 리스트 안에 존재하는지 다시 확인
                      if (_majorController.checkMajorExist(controller.text) == false ||
                          controller.text.isEmpty == true) {
                        CustomSnackBar.messageSnackbar(
                          context,
                          "학과를 다시 선택해주세요.",
                          EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                        );
                      } else {
                        _signUpController.majorInputEmpty.value = false;
                        Get.back();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}


class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(68.h);

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
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
              ),
              SizedBox(width: 8.w),
              Container(padding: EdgeInsets.only(bottom: 3.h), child: Text("학과 검색", style: CommonText.BodyL))
            ],
          ),
        ),
      ],
    );
  }
}
