import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/match/match_controller.dart';
import 'package:waggly/utils/colors.dart';


class FilterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MatchFilterController controller = Get.put(MatchFilterController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(()=>
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              controller.state.value == 0 ? FilterMain() :
              controller.state.value == 1 ? QuestionOne() :
              controller.state.value == 2 ? QuestionTwo() :
              controller.state.value == 3 ? QuestionThree() : SizedBox(),
                ],
              )
         , )),
    );
  }
}


class FilterMain extends StatelessWidget {
  const FilterMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MatchFilterController controller = Get.put(MatchFilterController());
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("필터 설정을 통해 소통을 도와드릴게요!", style: TextStyle(
            fontSize: 16.0.sp,
            color: Colors.black,
            fontFamily: 'NotoSansKR_Bold',),),
          Text("어떤 친구를 찾으세요?", style: TextStyle(
            fontSize: 16.0.sp,
            color: Colors.black,
            fontFamily: 'NotoSansKR_Bold',),),
          SizedBox(height: 30.h,),
          Container(
            child:Image.asset(
              'assets/wagglyImg/filter_entrance.png',
          ),),
          SizedBox(height: 30.h,),
          Container(
            width: double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: Palette.purple,),
            child: TextButton(
              child: Text(
                '기존 설정으로 진행하기',
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: (){
                controller.reFilter.value = false;
                controller.state.value = 1;
              },
            ),
          ),
          SizedBox(height: 15.h,),
          Container(
            width: double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              border: Border.all(width: 1.0, color: Palette.purple),
              color: Colors.white,),
            child: TextButton(
              child: Text(
                '필터 재설정하기',
                style: TextStyle(
                  color:Palette.purple,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: (){
                controller.reFilter.value = true;
                controller.state.value = 1;
              },
            ),
          ),
        ],
      );
  }
}


class QuestionOne extends StatelessWidget {
  const QuestionOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MatchFilterController controller = Get.put(MatchFilterController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Q1", style: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.black,
              fontFamily: 'NotoSansKR_Bold',),),
            SizedBox(width: 5.w),
            Container(
                width: 17.w,
                height: 17.h,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Palette.lightGray),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                      icon: Icon(Icons.question_mark),
                      color: Palette.gray,
                      iconSize: 10.0.sp,
                      onPressed: () {
                       print('add click event');
                      },
                    ),
              ),
          ],
        ),
        SizedBox(height: 5.h),
        Text('친구들과의 소통을 위해 필터를 설정해주세요.', style: TextStyle(
          fontSize: 16.0.sp,
          color: Colors.black,
          fontFamily: 'NotoSansKR_Bold',),),
        SizedBox(height: 5.h),
        Text('소통하고 싶은 유형을 한가지 선택해주세요.', style: TextStyle(
          fontSize: 10.0.sp,
          color: Palette.gray,
          fontFamily: 'NotoSansKR',),),
        SizedBox(height: 30.h,),
        Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(width: 1.0, color: Palette.lightGray),
            color: Colors.white,),
          child: TextButton(
            child: Text(
              '편하게 소통할 수 있는 친구를 찾고 있어요',
              style: TextStyle(
                color:Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: (){
              controller.answerOne.value = 1;
            },
          ),
        ),
        SizedBox(height: 15.h,),
        Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(width: 1.0, color: Palette.lightGray),
            color: Colors.white,),
          child: TextButton(
            child: Text(
              '도움을 줄 수 있는 멘토가 되고 싶어요',
              style: TextStyle(
                color:Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: (){
              controller.answerOne.value = 2;
            },
          ),
        ),
        SizedBox(height: 15.h,),
        Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(width: 1.0, color: Palette.lightGray),
            color: Colors.white,),
          child: TextButton(
            child: Text(
              '도움을 구할 수 있는 멘토를 찾고 있어요',
              style: TextStyle(
                color:Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: (){
              controller.answerOne.value = 3;
            },
          ),
        ),
        SizedBox(height: 15.h,),
        SlideIndicator(),
        SizedBox(height: 30.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                border: Border.all(width: 1.5, color: Palette.purple),
                color: Colors.white,),
              child: TextButton(
                child: Text(
                  '이전',
                  style: TextStyle(
                    color:Palette.purple,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: (){
                  controller.state.value = 0;
                },
              ),
            ),),
            SizedBox(width: 10.w,),
            Expanded(
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(width: 1.5, color: Palette.purple),
                  color: Palette.purple),
                child: TextButton(
                  child: Text(
                    '다음',
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: (){
                    controller.state.value = 2;
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class QuestionTwo extends StatelessWidget {
  const QuestionTwo({Key? key}) : super(key: key);

  final double runSpacing = 4;
  final double spacing = 12;
  final int listSize = 4;
  final columns = 5;

  @override
  Widget build(BuildContext context) {
    MatchFilterController controller = Get.put(MatchFilterController());

    List<String> QuestionTheme = ["학업", "취업", "스터디", "기타"];
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) / columns;

    return controller.answerOne == 1 ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Text("Q2", style: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.black,
              fontFamily: 'NotoSansKR_Bold',),),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('누구와 소통하고 싶나요?', style: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.black,
              fontFamily: 'NotoSansKR_Bold',),),
            Text('동성만 찾기')
          ],
        ),
        SizedBox(height: 35.h),
        Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(width: 1.0, color: Palette.lightGray),
            color: Colors.white,),
          child: TextButton(
            child: Text(
              '후배',
              style: TextStyle(
                color:Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: (){
              controller.reFilter.value = false;
              controller.state.value = 2;
            },
          ),
        ),
        SizedBox(height: 15.h,),
        Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(width: 1.0, color: Palette.lightGray),
            color: Colors.white,),
          child: TextButton(
            child: Text(
              '동기',
              style: TextStyle(
                color:Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: (){
              controller.reFilter.value = true;
              controller.state.value = 2;
            },
          ),
        ),
        SizedBox(height: 15.h,),
        Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(width: 1.0, color: Palette.lightGray),
            color: Colors.white,),
          child: TextButton(
            child: Text(
              '선배',
              style: TextStyle(
                color:Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: (){
              controller.reFilter.value = true;
              controller.state.value = 2;
            },
          ),
        ),
        SizedBox(height: 15.h,),
        SlideIndicator(),
        SizedBox(height: 30.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                border: Border.all(width: 1.5, color: Palette.purple),
                color: Colors.white,),
              child: TextButton(
                child: Text(
                  '이전',
                  style: TextStyle(
                    color:Palette.purple,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: (){
                  controller.state.value = 1;
                },
              ),
            ),),
            SizedBox(width: 10.w,),
            Expanded(
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(width: 1.5, color: Palette.purple),
                    color: Palette.purple),
                child: TextButton(
                  child: Text(
                    '다음',
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: (){
                    controller.state.value = 3;
                  },
                ),
              ),
            ),
          ],
        )
      ],
    ) :
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Q2", style: TextStyle(
          fontSize: 16.0.sp,
          color: Colors.black,
          fontFamily: 'NotoSansKR_Bold',),),
        SizedBox(height: 5.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('소통하고 싶은 주제를 골라주세요', style: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.black,
              fontFamily: 'NotoSansKR_Bold',),),
            SizedBox(height: 5.h),
            Text('세개까지 중복 선택이 가능해요', style: TextStyle(
              fontSize: 10.0.sp,
              color: Palette.gray,
              fontFamily: 'NotoSansKR',),),
          ],
        ),
        SizedBox(height: 35.h),
        Center(
          child: SingleChildScrollView(
            child: Wrap(
              runSpacing: runSpacing,
              spacing: spacing,
              alignment: WrapAlignment.center,
              children: List.generate(listSize, (index) {
                return InkWell(
                  child: Container(
                    width: w,
                    height: w,
                    margin: EdgeInsets.only(bottom: 5.h),
                    child: Center(
                      child: Text(
                          QuestionTheme[index]),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                          width: 1.0.w,
                          // color: controller.selected.value == index
                          //     ? Palette.main
                          //     : Palette.lightGray
                          color: Palette.lightGray

                      ),
                    ),
                  ),
                  onTap: () {
                    print(QuestionTheme[index]);
                  },
                );
              }),
            ),
          ),
        ),
        SizedBox(height: 25.h,),
        SlideIndicator(),
        SizedBox(height: 40.h,),
        Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: Palette.lightGray,),
          child: TextButton(
            child: Text(
              '선택 완료',
              style: TextStyle(
                color:Palette.gray,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: (){
            },
          ),
        ),
      ],
    );
  }
}

class QuestionThree extends StatelessWidget {
  const QuestionThree({Key? key}) : super(key: key);

  final double runSpacing = 4;
  final double spacing = 12;
  final int listSize = 7;
  final columns = 5;

  @override
  Widget build(BuildContext context) {
    MatchFilterController controller = Get.put(MatchFilterController());
    List<String> theme = ["학업", "자유", "스터디", "생활", "취업", "취미", "기타"];

    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) / columns;

    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Q3", style: TextStyle(
                  fontSize: 16.0.sp,
                  color: Colors.black,
                  fontFamily: 'NotoSansKR_Bold',),),
                SizedBox(height: 5.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('소통하고 싶은 주제를 골라주세요', style: TextStyle(
                      fontSize: 16.0.sp,
                      color: Colors.black,
                      fontFamily: 'NotoSansKR_Bold',),),
                    SizedBox(height: 5.h),
                    Text('세개까지 중복 선택이 가능해요', style: TextStyle(
                      fontSize: 10.0.sp,
                      color: Palette.gray,
                      fontFamily: 'NotoSansKR',),),
                  ],
                ),
                SizedBox(height: 35.h),
                Center(
                  child: SingleChildScrollView(
                    child: Wrap(
                      runSpacing: runSpacing,
                      spacing: spacing,
                      alignment: WrapAlignment.center,
                      children: List.generate(listSize, (index) {
                        return InkWell(
                          child: Container(
                            width: w,
                            height: w,
                            margin: EdgeInsets.only(bottom: 5.h),
                            child: Center(
                              child: Text(
                                  theme[index]),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  width: 1.0.w,
                                  // color: controller.selected.value == index
                                  //     ? Palette.main
                                  //     : Palette.lightGray
                                  color: Palette.lightGray

                              ),
                            ),
                          ),
                          onTap: () {
                            print(theme[index]);
                          },
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(height: 25.h,),
                SlideIndicator(),
                SizedBox(height: 40.h,),
                Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Palette.lightGray,),
                      child: TextButton(
                        child: Text(
                          '선택 완료',
                          style: TextStyle(
                            color:Palette.gray,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: (){
                        },
                      ),
                    ),
              ],
    );
  }
}

class SlideIndicator extends StatelessWidget {
  const SlideIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MatchFilterController controller = Get.put(MatchFilterController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: controller.state == 1 ? 8.w : 6.w,
          height: controller.state == 1 ? 8.h : 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.state == 1 ? Palette.purple :Palette.lightGray ,),
                  ),
              SizedBox(width: 8.w,),
              Container(
                width: controller.state == 2 ? 8.w : 6.w,
                height: controller.state == 2 ? 8.h : 6.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.state == 2 ? Palette.purple :Palette.lightGray ,),
              ),
              SizedBox(width: 8.w,),
              Container(
                width: controller.state == 3 ? 8.w : 6.w,
                height: controller.state == 3 ? 8.h : 6.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.state == 3 ? Palette.purple :Palette.lightGray ,),
          ),
        ],
      );
  }
}
