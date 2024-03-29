import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/home/bottom_nav_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/screens/chat/chat_room_screen.dart';
import 'package:waggly/screens/home.dart';
import 'package:waggly/screens/matchFilter/filter.dart';
import 'package:waggly/screens/user/my_page.dart';
import 'package:waggly/screens/post/post_home.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/controller/home/bottom_nav_controller.dart';
import '../controller/post/post_controller.dart';

// class Screen extends StatefulWidget {
//   Screen({Key? key}) : super(key: key);
//
//   @override
//   State<Screen> createState() => _ScreenState();
// }
//
// class _ScreenState extends State<Screen> {
//   final SignInController _signInController = Get.put(SignInController());
//
//   @override
//   void initState() {
//     super.initState();
//     Get.put(PostController());
//   }
//
//   int screenIndex = 0;
//   List<Widget> screenList = <Widget>[
//     HomeScreen(),
//     //ChatEditScreen(),
//     FilterScreen(),
//     // ChatSearchScreen(),
//     ChatRoomScreen(),
//     // ChatRoomScreen(),
//     PostScreen(),
//     MyPageScreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     Get.put(PostController());
//     final bool isLoggedIn = _signInController.isLoggedIn.value;
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: screenList[screenIndex],
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           color: Colors.transparent,
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//             color: Colors.white,
//             border: Border.all(
//               color: const Color(0xFFE8E8E8),
//               width: 1.0,
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(25.0),
//             child: NavigationBarTheme(
//               data: const NavigationBarThemeData(
//                 backgroundColor: Colors.white,
//                 indicatorColor: Colors.white,
//                 height: 0,
//               ),
//               child: NavigationBar(
//                 height: 55,
//                 selectedIndex: screenIndex,
//                 labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
//                 onDestinationSelected: (index) {
//                   if (isLoggedIn == true || index == 0) {
//                     setState(() {
//                       screenIndex = index;
//                     });
//                   } else {
//                     if (index != 0) {
//                       print('index: $index');
//                       CustomSnackBar.messageSnackbar(
//                         context,
//                         "로그인이 필요한 메뉴입니다.",
//                         EdgeInsets.only(bottom: 60.h, left: 20.w, right: 20.w),
//                       );
//                     }
//                   }
//                 },
//                 destinations: const [
//                   NavigationDestination(
//                       icon: Icon(
//                         Icons.home,
//                         color: Palette.gray,
//                         size: 23,
//                       ),
//                       selectedIcon: Icon(
//                         Icons.home,
//                         color: Palette.main,
//                         size: 23,
//                       ),
//                       label: ''),
//                   NavigationDestination(
//                     icon: Icon(
//                       Icons.add_comment,
//                       color: Palette.gray,
//                       size: 23,
//                     ),
//                     selectedIcon: Icon(Icons.add_comment, color: Palette.main, size: 23),
//                     label: '',
//                   ),
//                   NavigationDestination(icon: Icon(Icons.chat_bubble, color: Palette.gray, size: 23), selectedIcon: Icon(Icons.chat_bubble, color: Palette.main, size: 23), label: ''),
//                   NavigationDestination(
//                     icon: Icon(Icons.view_list, color: Palette.gray, size: 23),
//                     selectedIcon: Icon(Icons.view_list, color: Palette.main, size: 23),
//                     label: '',
//                   ),
//                   NavigationDestination(icon: Icon(Icons.person, color: Palette.gray, size: 23), selectedIcon: Icon(Icons.person, color: Palette.main, size: 23), label: ''),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//


class Root extends GetView<BottomNavController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInController _signInController = Get.put(SignInController());
    final bool isLoggedIn = _signInController.isLoggedIn.value;

    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Obx(() => Scaffold(
        body: IndexedStack(
          index: controller.rootPageIndex.value,
          children: [
            HomeScreen(),
            Navigator(
              key: controller.navigatorKeyFilter,
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => FilterScreen(),
                );
              },
            ),
            ChatRoomScreen(),
            Navigator(
              key: controller.navigatorKeyPost,
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => PostScreen(),
                );
              },
            ),
            MyPageScreen(),
          ],
        ),
        bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
          child: Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white,
            border: Border.all(width: 1.0, color: Palette.lightGray),
          ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: NavigationBarTheme(
                data: const NavigationBarThemeData(
                  backgroundColor: Colors.white,
                  height: 100,
                ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    currentIndex: controller.rootPageIndex.value,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    onTap: (index){
                      if (isLoggedIn != true && index != 0) {
                        CustomSnackBar.messageSnackbar(
                          context,
                          "로그인이 필요한 메뉴입니다.",
                          EdgeInsets.only(bottom: 60.h, left: 20.w, right: 20.w),
                        );
                      }else{
                        controller.changeRootPageIndex(index);
                      }
                    },
                    items: [
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                          icon: Icon(
                            Icons.home,
                            color: Palette.gray,
                            size: 23,
                          ),
                          activeIcon: Icon(
                            Icons.home,
                            color: Palette.main,
                            size: 23,
                          ),
                          label: 'home'),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(
                          Icons.add_comment,
                          color: Palette.gray,
                          size: 23,
                        ),
                        activeIcon: Icon(Icons.add_comment, color: Palette.main, size: 23),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.white,
                          icon: Icon(Icons.chat_bubble, color: Palette.gray, size: 23),
                          activeIcon:
                          Icon(Icons.chat_bubble, color: Palette.main, size: 23),
                          label: ''),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(Icons.view_list, color: Palette.gray, size: 23),
                        activeIcon: Icon(Icons.view_list, color: Palette.main, size: 23),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.white,
                          icon: Icon(Icons.person, color: Palette.gray, size: 23),
                          activeIcon: Icon(Icons.person, color: Palette.main, size: 23),
                          label: ''),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
