import 'package:flutter/material.dart';
import 'package:wagly/utils/textFrame.dart';
import 'package:wagly/utils/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const myNotification(),
    );
  }
}

class myNotification extends StatefulWidget {
  const myNotification({Key? key}) : super(key: key);

  @override
  _myNotificationState createState() => _myNotificationState();
}

class _myNotificationState extends State<myNotification> {
  bool _isChecked = false;
  bool _isEdit = false;

//   {
//     alarmId: 1,
//   alarmType: 'request',
//   alarmDataId: 11,
//   isReading: false,
// }

  List<Map> contents = [
    {
      'createdAt': '19:50',
      'content': '우글 님으로 부터 도움 신청이 왔습니다',
    },
    {
      'createdAt': '15:50',
      'content': '성은 님으로 부터 대화 신청이 왔습니다',
    },
    {
      'createdAt': '11:50',
      'content': '주영 님이 도움신청을 거절하셨습니다',
    },
    {
      'createdAt': '10:50',
      'content': '새로운 대댓글이 달렸습니다',
    },
    {
      'createdAt': '08:50',
      'content': '민 님으로 부터 도움 신청이 왔습니다',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
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
                        '알림',
                        style: CommonText.BodyL,
                      )),
                ],
              ),
              Column(
                children: [
                  //편집하기,삭제하기 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!_isEdit)
                        Container(
                          width: 70.0,
                          height: 24.0,
                          margin:
                              EdgeInsets.only(left: 16, right: 16, bottom: 15),
                          child: ElevatedButton(
                            child: Text(
                              "편집하기",
                              style: CommonText.BodyXS,
                            ),
                            onPressed: () => {
                              setState(() {
                                _isEdit = true;
                              }),
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Palette.candy,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ).copyWith(
                                elevation: ButtonStyleButton.allOrNull(0.0)),
                          ),
                        ),
                      if (_isEdit)
                        Container(
                          width: 70.0,
                          height: 24.0,
                          margin:
                              EdgeInsets.only(left: 16, right: 16, bottom: 15),
                          child: ElevatedButton(
                            child: Text(
                              "삭제하기",
                              style: CommonText.BodyXS,
                            ),
                            onPressed: () => {
                              setState(() {
                                _isEdit = false;
                              }),
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Palette.candy,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ).copyWith(
                                elevation: ButtonStyleButton.allOrNull(0.0)),
                          ),
                        ),
                    ],
                  ),
                  Divider(thickness: 0.5, height: 0.5, color: Palette.paper),
                  SizedBox(
                    child: ListView.builder(
                        itemCount: contents.length,
                        itemBuilder: (context, i) {
                          return Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Palette
                                            .paper) // 색깔 진하게 확인할 때 959595
                                    )),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _isEdit && _isChecked
                                    ? SizedBox(width: 20)
                                    : SizedBox(),
                                if (_isEdit)
                                  Checkbox(
                                    value: _isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        if (_isChecked) {
                                          _isChecked = false;
                                        } else {
                                          _isChecked = true;
                                        }
                                      });
                                    },
                                    activeColor: Palette.main,
                                  ),
                                Container(
                                  height: 28,
                                  width: 28,
                                  margin: EdgeInsets.only(left: 00, right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/green.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: _isChecked
                                      ? MediaQuery.of(context).size.width - 50
                                      : MediaQuery.of(context).size.width - 120,
                                  child: Text(contents[i]['content'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xff47505F),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 16),
                                  child: Text(
                                    contents[i]['createdAt'],
                                    style: CommonText.LabelGray,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
