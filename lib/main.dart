import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:waggly/components/myPage/active/my_post_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waggly/components/myPage/active/request_list.dart';
import 'package:waggly/components/myPage/setting/index.dart';
import 'package:waggly/components/notification/notification.dart';
import 'package:waggly/controller/home/home_controller.dart';
import 'package:waggly/controller/post/post_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/hive/search_history.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/screens/chat/chat.dart';
import 'package:waggly/screens/chat/chat_edit.dart';
import 'package:waggly/screens/chat/chat_room_screen.dart';
import 'package:waggly/screens/chat/chat_search.dart';
import 'package:waggly/screens/groupChat/group_chat_create.dart';
import 'package:waggly/screens/user/find_password.dart';
import 'package:waggly/screens/index.dart';
import 'package:waggly/screens/user/my_page.dart';
import 'package:waggly/screens/post/post_home.dart';
import 'package:waggly/screens/user/sign_in.dart';
import 'package:waggly/screens/post/write.dart';
import 'package:waggly/components/myPage/profileImg/profile_img.dart';
import 'package:waggly/components/myPage/active/index.dart';
import 'controller/notification/AppController.dart';
import 'screens/post/post_detail_screen.dart';
import 'screens/post/post_college_List.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  // Push Notification
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String? encryptionKey = await secureStorage.read(key: 'encryptionKey');
  if (encryptionKey == null) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'encryptionKey', value: base64UrlEncode(key));
    encryptionKey = await secureStorage.read(key: 'encryptionKey');
  }

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SearchHistoryAdapter());
  await Hive.openBox<User>("user", encryptionCipher: HiveAesCipher(base64Url.decode(encryptionKey!)));
  await Hive.openBox<SearchHistory>('searchHistory', encryptionCipher: HiveAesCipher(base64Url.decode(encryptionKey)));
  Get.put(HomeController());
  Get.put(SignInController());
  runApp(HeroApp());
}

class HeroApp extends StatelessWidget {
  HeroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'waggly',
          home: MyApp(),
          initialRoute: "/",
          getPages: [
            GetPage(name: "/", page: () => Screen(), transition: Transition.rightToLeft),
            GetPage(
                name: "/home",
                page: () => Screen(),
                transition: Transition.rightToLeft,
                binding: BindingsBuilder<SignInController>(() {
                  Get.put(() {
                    return SignInController();
                  });
                })),
            GetPage(name: "/post", page: () => PostScreen(), transition: Transition.rightToLeft),
            GetPage(
              name: '/postCollege/:param',
              page: () => PostCollegeList(),
              transition: Transition.rightToLeft,
              transitionDuration: const Duration(milliseconds: 350),
              curve: Curves.fastOutSlowIn,
            ),
            GetPage(
              name: '/postDetail/:param',
              page: () => PostDetail(),
              transition: Transition.rightToLeft,
              transitionDuration: const Duration(milliseconds: 350),
              curve: Curves.fastOutSlowIn,
            ),
            GetPage(name: "/chat", page: () => ChatScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/myPage", page: () => MyPageScreen(), transition: Transition.rightToLeft),
            GetPage(
                name: "/chatEdit",
                page: () => ChatEditScreen(),
                transition: Transition.rightToLeft,
                binding: BindingsBuilder<SignInController>(() {
                  Get.put(() {
                    return SignInController();
                  });
                })),
            GetPage(name: "/signInPage", page: () => SignInScreen(), transition: Transition.rightToLeft),
            GetPage(
              name: "/writePage",
              page: () => WritePage("write"),
              transition: Transition.rightToLeft,
              binding: BindingsBuilder<PostController>(() {
                Get.reload<PostController>();
              }),
            ),
            GetPage(name: "/editPage", page: () => WritePage("edit"), transition: Transition.rightToLeft),
            GetPage(name: "/profileImg", page: () => ProfileImgScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/active", page: () => ActiveScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/setting", page: () => SettingScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/notification", page: () => NotificationScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/myPostsList", page: () => MyPostListScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/myRequestList", page: () => RequestScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/findPassword", page: () => FindPasswordScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/chatRoom", page: () => ChatRoomScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/chatCreate", page: () => GroupChatCreatePage(), transition: Transition.rightToLeft),
            GetPage(name: "/chatSearch", page: () => ChatSearchScreen(), transition: Transition.rightToLeft)
          ],
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AppController c = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: c.initialize(),
        builder: (context, snapshot) {
          return Screen();
        },
      ),
    );
  }
}

// stless
