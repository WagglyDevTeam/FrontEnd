import 'package:flutter/material.dart';
import 'package:wagly/screens/chat.dart';
import 'package:wagly/screens/chatEdit.dart';
import 'package:wagly/screens/home.dart';
import 'package:wagly/screens/myPage.dart';
import 'package:wagly/screens/post.dart';
import 'package:wagly/utils/colors.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int screenIndex = 0;
  List<Widget> screenList = <Widget>[
    HomeScreen(),
    ChatEditScreen(),
    ChatScreen(),
    PostScreen(),
    MyPageScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screenList[screenIndex],
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFE8E8E8),
                  width: 1.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: NavigationBarTheme(
                  data: const NavigationBarThemeData(
                    backgroundColor: Colors.white,
                    indicatorColor: Colors.white,
                    height: 0,
                  ),
                  child: NavigationBar(
                    height: 55,
                    selectedIndex: screenIndex,
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysHide,
                    onDestinationSelected: (index) =>
                        setState(() => {screenIndex = index}),
                    destinations: const [
                      NavigationDestination(
                          icon: Icon(
                            Icons.home,
                            color: Palette.gray,
                            size: 23,
                          ),
                          selectedIcon: Icon(
                            Icons.home,
                            color: Palette.main,
                            size: 23,
                          ),
                          label: ''),
                      NavigationDestination(
                        icon: Icon(
                          Icons.add_comment,
                          color: Palette.gray,
                          size: 23,
                        ),
                        selectedIcon: Icon(Icons.add_comment,
                            color: Palette.main, size: 23),
                        label: '',
                      ),
                      NavigationDestination(
                          icon: Icon(Icons.chat_bubble,
                              color: Palette.gray, size: 23),
                          selectedIcon: Icon(Icons.chat_bubble,
                              color: Palette.main, size: 23),
                          label: ''),
                      NavigationDestination(
                        icon: Icon(Icons.view_list,
                            color: Palette.gray, size: 23),
                        selectedIcon: Icon(Icons.view_list,
                            color: Palette.main, size: 23),
                        label: '',
                      ),
                      NavigationDestination(
                          icon:
                              Icon(Icons.person, color: Palette.gray, size: 23),
                          selectedIcon:
                              Icon(Icons.person, color: Palette.main, size: 23),
                          label: ''),
                    ],
                  ),
                ),
              ),
            )));
  }
}
