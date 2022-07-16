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

  final allChecked =
      CheckBoxModal(title: 'all Checked', time: '11:00', purpose: 'chat');
  final checkBoxList = [
    CheckBoxModal(
        title: '우글 님으로 부터 도움 신청이 왔습니다', time: '12:30', purpose: 'help'),
    CheckBoxModal(
        title: '성은 님으로 부터 대화 신청이 왔습니다', time: '12:30', purpose: 'chat'),
    CheckBoxModal(
        title: '밍기 님으로 부터 도움 신청이 왔습니다', time: '12:30', purpose: 'help'),
  ];

  List<Map> contents = [
    {
      'createdAt': '19:50',
      'content': '우글 님으로 부터 도움 신청이 왔습니다',
      'activated': false,
    },
    {
      'createdAt': '15:50',
      'content': '성은 님으로 부터 대화 신청이 왔습니다',
      'activated': false,
    },
    {
      'createdAt': '11:50',
      'content': '주영 님이 도움신청을 거절하셨습니다',
      'activated': false,
    },
    {
      'createdAt': '10:50',
      'content': '새로운 대댓글이 달렸습니다',
      'activated': false,
    },
    {
      'createdAt': '08:50',
      'content': '민 님으로 부터 도움 신청이 왔습니다',
      'activated': false,
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
                      Container(
                        width: 70.0,
                        height: 24.0,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: ElevatedButton(
                          child: Text(
                            _isEdit ? "삭제하기" : "편집하기",
                            style: CommonText.BodyXS,
                          ),
                          onPressed: () {
                            setState(() {
                              if (!_isEdit) {
                                _isEdit = true;
                              } else {
                                _isEdit = false;
                              }
                            });
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
                  ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      Divider(),
                      ...checkBoxList
                          .map(
                            (item) => ListTile(
                                title: SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      _isEdit
                                          ? SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: Transform.scale(
                                                scale: 0.7,
                                                child: Checkbox(
                                                  value: item.value,
                                                  onChanged: (value) {
                                                    onAllClicked(item);
                                                  },
                                                  activeColor: Palette.main,
                                                ),
                                              ),
                                            )
                                          : SizedBox(width: 0),
                                      Container(
                                        height: 28,
                                        width: 28,
                                        margin:
                                            EdgeInsets.only(right: 10, left: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          image: DecorationImage(
                                            image: AssetImage((item.purpose ==
                                                    'help')
                                                ? 'assets/images/green.png'
                                                : (item.purpose == 'chat')
                                                    ? 'assets/images/red.png'
                                                    : 'assets/images/purple.png'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: _isEdit
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                130
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                110,
                                        child: Text(item.title,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color(0xff47505F),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ),
                                      if (!_isEdit)
                                        Container(
                                          child: Text(
                                            item.time,
                                            style: CommonText.LabelGray,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Divider(),
                                ],
                              ),
                            )),
                          )
                          .toList(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  onAllClicked(CheckBoxModal ckbItem) {
    setState(() {
      ckbItem.value = !ckbItem.value;
    });
  }
}

class CheckBoxModal {
  String title;
  bool value;
  String time;
  String purpose;

  CheckBoxModal(
      {required this.title,
      this.value = false,
      required this.time,
      required this.purpose});
}
