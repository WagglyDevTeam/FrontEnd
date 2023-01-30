import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/controller/signUp/sign_up_controller.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';
import 'package:waggly/widgets/textFormField/text_form_field.dart';

class WithdrawScreen extends StatelessWidget{
  const WithdrawScreen({Key? key}) : super(key:key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(),
      body: Withdraw(),
    );
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
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(padding: EdgeInsets.only(bottom: 3.h), child: Text("탈퇴", style: CommonText.BodyL)),
                ],
              ),
          ),
      ],
    );
  }
}


class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final _passwordInput = TextEditingController();
  bool defaultMode = false;
  SignUpController _signUpController = Get.put(SignUpController());
  SignInController _signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.h),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: Text("와글리를 탈퇴하시겠습니까?", style: CommonText.BodyL),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 60.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("탈퇴시 개인 테이터가 삭제됩니다.", style: CommonText.BodyMediumGray),
                        Text("한 번 삭제된 정보는 복구할 수 없습니다.",
                            style: CommonText.BodyMediumGray),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Row(
                          children: [
                            Text(
                              '비밀번호',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        SizedBox(
                          child: TextFormField(
                            autofocus: true,
                            controller: _passwordInput,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: '영문, 숫자 포함 8자 이상',
                                hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp),
                              isDense: true,
                              contentPadding:
                              EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: defaultMode == false
                                        ? Color.fromRGBO(218, 175, 254, 1)
                                        : Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(height: 40.h,),
                  Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.all(5),
                      crossAxisCount: 2,
                      childAspectRatio: ((MediaQuery.of(context).size.width / 2)/ 36.h),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Palette.candy,),
                          margin: EdgeInsets.only(left:5.w),
                          child: TextButton(
                            child: Text(
                              '돌아가기', style: TextStyle(
                              color: Palette.purple,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Palette.main,),
                          margin: EdgeInsets.only(left:5.w),
                          child: TextButton(
                            child: Text(
                              '탈퇴하기', style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            ),
                            onPressed: (){
                              //탈퇴하는 api 연결하고 여기서 예외처리
                              if(_passwordInput.value == null ){
                                CustomSnackBar.messageSnackbar(
                                  context,
                                  "탈퇴가 성공적으로 완료되었습니다.",
                                  EdgeInsets.only(bottom: 60.h, left: 20.w, right: 20.w),
                                );
                                Future.delayed(const Duration(milliseconds: 1000), () {
                                  Get.toNamed('/home');
                                });
                              }else{
                                CustomSnackBar.messageSnackbar(
                                    context,
                                    "비밀번호를 입력해주세요.",
                                    EdgeInsets.only(bottom: 60.h, left: 20.w, right: 20.w),);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
  }
}