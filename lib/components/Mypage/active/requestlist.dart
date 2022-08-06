import 'package:flutter/material.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/textFrame.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const requestList(),
    );
  }
}

class requestList extends StatefulWidget {
  const requestList({Key? key}) : super(key: key);

  @override
  _requestListState createState() => _requestListState();
}

class _requestListState extends State<requestList> {
  bool requestStatus = false;

  final List<Map> getRequestList = [
    {
      'requestId': 1,
      'requestPurpose': '친구 찾기',
      'requestCreatedAt': '2022-07-12',
      'requestText': '요즘 진로에 대해 고민이 많은데 취업 관련 정보 공유하면서 서로 도움을 주고 받을 친구를 찾고 있어요',
      'requestUser': {
        "userId": 4,
        "userprofileImg":
            'https://dthezntil550i.cloudfront.net/4s/latest/4s1907071502001570010034211/1280_960/e5a4a98e-f0a4-4146-9594-1a6fa3002449.png',
        "nickname": "바글",
        "gender": "female",
        "major": "컴퓨터공학과",
//          학번 ?\
        //짧은 메세지
      },
    },
    {
      'requestId': 2,
      'requestPurpose': '대화 신청',
      'requestCreatedAt': '2022-07-11',
      'requestText': '요즘 진로에 대해 고민이 많은데 취업 관련 정보 공유하면서 서로 도움을 주고 받을 친구를 찾고 있어요',
      'requestUser': {
        "userId": 4,
        "nickname": "냠이",
        "userprofileImg":
            'https://dthezntil550i.cloudfront.net/4s/latest/4s1907071502001570010034211/1280_960/e5a4a98e-f0a4-4146-9594-1a6fa3002449.png',
        "gender": "male",
        "major": "시각디자인과",
      },
    },
    {
      'requestId': 3,
      'requestPurpose': '도움 요청',
      'requestCreatedAt': '2022-07-09',
      'requestText': '요즘 진로에 대해 고민이 많은데 취업 관련 정보 공유하면서 서로 도움을 주고 받을 친구를 찾고 있어요',
      'requestUser': {
        "userId": 1,
        "nickname": "몽글",
        "userprofileImg":
            'https://dthezntil550i.cloudfront.net/4s/latest/4s1907071502001570010034211/1280_960/e5a4a98e-f0a4-4146-9594-1a6fa3002449.png',
        "gender": "female",
        "major": "법학대",
      },
    },
  ];

  final List<Map> requestList = [
    {
      'requestId': 1,
      'requestPurpose': '친구 찾기',
      'requestCreatedAt': '2022-07-12',
      'requestUser': {
        "userId": 4,
        "userprofileImg":
            'https://dthezntil550i.cloudfront.net/4s/latest/4s1907071502001570010034211/1280_960/e5a4a98e-f0a4-4146-9594-1a6fa3002449.png',
        "nickname": "와글바글",
        "gender": "female",
        "major": "컴퓨터공학과",
//          학번 ?\
        //짧은 메세지
      },
    },
    {
      'requestId': 2,
      'requestPurpose': '대화 신청',
      'requestCreatedAt': '2022-07-11',
      'requestUser': {
        "userId": 4,
        "nickname": "냠냠이",
        "userprofileImg":
            'https://dthezntil550i.cloudfront.net/4s/latest/4s1907071502001570010034211/1280_960/e5a4a98e-f0a4-4146-9594-1a6fa3002449.png',
        "gender": "male",
        "major": "시각디자인과",
      },
    },
    {
      'requestId': 3,
      'requestPurpose': '도움 요청',
      'requestCreatedAt': '2022-07-09',
      'requestUser': {
        "userId": 1,
        "nickname": "몽글몽글",
        "userprofileImg":
            'https://dthezntil550i.cloudfront.net/4s/latest/4s1907071502001570010034211/1280_960/e5a4a98e-f0a4-4146-9594-1a6fa3002449.png',
        "gender": "female",
        "major": "법학대",
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 28;
    final double itemWidth = size.width / 2;

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        margin: EdgeInsets.only(top: 20, right: 10, left: 16),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.5, color: Palette.lightGray),
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
                      if (requestStatus)
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(top: 25),
                          child: Text(
                            '내가 보낸 요청',
                            style: CommonText.BodyL,
                          ),
                        ),
                      if (!requestStatus)
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(top: 25),
                          child: Text(
                            '내가 받은 요청',
                            style: CommonText.BodyL,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: ElevatedButton(
                        child: Icon(
                          Icons.forward_to_inbox,
                          size: 16.0,
                        ),
                        onPressed: () {
                          setState(() {
                            requestStatus = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: requestStatus ? Palette.main : Colors.white,
                          onPrimary:
                              requestStatus ? Colors.white : Palette.gray,
                          side: BorderSide(
                            width: 0.5,
                            color: requestStatus ? Colors.white : Palette.light,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: ElevatedButton(
                        child: Icon(
                          Icons.forward_to_inbox,
                          size: 16.0,
                        ),
                        onPressed: () {
                          setState(() {
                            requestStatus = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: !requestStatus ? Palette.main : Colors.white,
                          onPrimary:
                              !requestStatus ? Colors.white : Palette.gray,
                          side: BorderSide(
                            width: 0.5,
                            color:
                                !requestStatus ? Colors.white : Palette.light,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                      ),
                    ),
                  ],
                ),
              ),
              if (requestStatus)
                Container(
                  height: MediaQuery.of(context).size.height - 120,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: requestList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 0.5, color: Palette.lightGray),
                              ),
                            ),
                            child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 16),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 22,
                                            width: 22,
                                            margin: EdgeInsets.only(
                                                right: 10, top: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    '${requestList[index]['requestUser']['userprofileImg']}'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${requestList[index]['requestUser']['nickname']}',
                                            style: CommonText.BodyB,
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            child: Icon(
                                              Icons.female,
                                              size: 10,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${requestList[index]['requestUser']['major']}',
                                            style: CommonText.BodyEngGray,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '18 학번',
                                            style: CommonText.BodyEngGray,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(right: 16, left: 16),
                                padding: EdgeInsets.only(
                                    top: 12, bottom: 12, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Palette.light),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  '${requestList[index]['requestPurpose']}',
                                  style: CommonText.BodyS,
                                ),
                              ),
                              SizedBox(height: 15),
                            ]));
                      }),
                ),
              if (!requestStatus)
                Container(
                  height: MediaQuery.of(context).size.height - 120,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: requestList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 0.5, color: Palette.lightGray),
                              ),
                            ),
                            child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 16),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 22,
                                            width: 22,
                                            margin: EdgeInsets.only(
                                                right: 10, top: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://t1.daumcdn.net/cfile/tistory/9925993E5C8CE8FB05"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${getRequestList[index]['requestUser']['nickname']}',
                                            style: CommonText.BodyB,
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            child: Icon(
                                              Icons.female,
                                              size: 10,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${getRequestList[index]['requestUser']['major']}',
                                            style: CommonText.BodyEngGray,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '18 학번',
                                            style: CommonText.BodyEngGray,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 70.0,
                                            height: 24.0,
                                            margin: EdgeInsets.only(right: 10),
                                            child: ElevatedButton(
                                              child: Text(
                                                "수락하기",
                                                style: CommonText.BodyXS,
                                              ),
                                              onPressed: () =>
                                                  print("it's pressed"),
                                              style: ElevatedButton.styleFrom(
                                                primary: Palette.candy,
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0),
                                                ),
                                              ).copyWith(
                                                  elevation: ButtonStyleButton
                                                      .allOrNull(0.0)),
                                            ),
                                          ),
                                          Container(
                                            width: 70.0,
                                            height: 24.0,
                                            child: ElevatedButton(
                                              child: Text(
                                                "거절하기",
                                                style: CommonText.BodyXS,
                                              ),
                                              onPressed: () =>
                                                  print("it's pressed"),
                                              style: ElevatedButton.styleFrom(
                                                primary: Palette.candy,
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0),
                                                ),
                                              ).copyWith(
                                                  elevation: ButtonStyleButton
                                                      .allOrNull(0.0)),
                                            ),
                                          ),
                                          SizedBox(width: 18),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                margin: EdgeInsets.only(right: 16, left: 16),
                                padding: EdgeInsets.only(
                                    top: 12, bottom: 12, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Palette.light),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  '${getRequestList[index]['requestText']}',
                                  style: CommonText.BodyM,
                                ),
                              ),
                              SizedBox(height: 15),
                            ]));
                      }),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
