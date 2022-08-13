import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/widgets/PageNav/page_nav.dart';
import 'package:waggly/model/myPage/notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: myNotification(),
    );
  }
}

class myNotification extends StatefulWidget {
  myNotification({Key? key}) : super(key: key);

  @override
  _myNotificationState createState() => _myNotificationState();
}

class _myNotificationState extends State<myNotification> {
  bool _isChecked = false;
  bool _isEdit = false;
  List<dynamic> checkBoxList = [];

  @override
  void initState() {
    super.initState();
    getNotification();
  }

  void getNotification() async {
    Response response;
    response = await getList();
    // print(response);
    for (var i = 0; i < response.data.length; i++) {
      var map = response.data[i];
      print(map);
      checkBoxList.add(
        CheckBoxModal(
          name: map['name'],
          content: map['content'],
          purpose: map['purpose'],
          time: map['time'],
        ),
      );
    }
  }

  Future getList() async {
    Response response;
    Dio dio = new Dio();
    response = await dio
        .get('https://2e828a7c-3f92-4016-bd0f-a0a58904819d.mock.pstmn.io/list');
    // print(response);
    Response res = response;
    // print(res);
    return res;
  }

  final allChecked = CheckBoxModal(
      name: 'min', content: 'all Checked', time: '11:00', purpose: 'chat');
  // final checkBoxList = [
  // CheckBoxModal(
  //     name: '우글',
  //     content: '님으로 부터 도움 신청이 왔습니다',
  //     time: '12:30',
  //     purpose: 'help'),
  // CheckBoxModal(
  //     name: '성은',
  //     content: ' 님으로 부터 대화 신청이 왔습니다',
  //     time: '12:30',
  //     purpose: 'chat'),
  // CheckBoxModal(
  //     name: '밍기',
  //     content: ' 님으로 부터 도움 신청이 왔습니다',
  //     time: '12:30',
  //     purpose: 'help'),
  // ];

  // final checkBoxList = arr.map((item) => {
  //       CheckBoxModal(
  //         name: item.name,
  //         content: item.content,
  //         time: item.time,
  //         purpose: item.pursose,
  //       )
  //     });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              PageNav(
                pageTitle: '알림',
                noBorder: true,
              ),
              Column(
                children: [
                  //편집하기,삭제하기 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _isEdit
                          ? Container(
                              width: 70.0,
                              height: 24.0,
                              margin: EdgeInsets.only(left: 16, right: 16),
                              child: ElevatedButton(
                                child: Text(
                                  "삭제하기",
                                  style: CommonText.BodyXS,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isEdit = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Palette.candy,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ).copyWith(
                                    elevation:
                                        ButtonStyleButton.allOrNull(0.0)),
                              ),
                            )
                          : Container(
                              width: 70.0,
                              height: 24.0,
                              margin: EdgeInsets.only(left: 16, right: 16),
                              child: ElevatedButton(
                                child: Text(
                                  "편집하기",
                                  style: CommonText.BodyXS,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isEdit = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Palette.candy,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ).copyWith(
                                    elevation:
                                        ButtonStyleButton.allOrNull(0.0)),
                              ),
                            ),
                    ],
                  ),
                  //전체 선택 체크박스
                  _isEdit
                      ? Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.7,
                                  child: Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                    activeColor: Palette.main,
                                  ),
                                ),
                              ),
                              Text('전체선택'),
                            ],
                          ),
                        )
                      : Container(),
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
                                                    '도움')
                                                ? 'assets/images/green.png'
                                                : (item.purpose == '대화')
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
                                        child: Row(
                                          children: [
                                            Text(item.name,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff47505F),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            Text(item.content,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff47505F),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                          ],
                                        ),
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
