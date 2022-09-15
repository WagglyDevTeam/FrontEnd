import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:waggly/components/myPage/active/my_post_list.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:waggly/components/myPage/active/request_list.dart';
import 'package:waggly/components/notification/notification.dart';
import 'package:waggly/controller/home/home_controller.dart';
import 'package:waggly/controller/myPage/my_profile_controller.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/hive/search_history.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/screens/chat.dart';
import 'package:waggly/screens/chat_edit.dart';
import 'package:waggly/screens/group_chat_create.dart';
import 'package:waggly/screens/index.dart';
import 'package:waggly/screens/my_page.dart';
import 'package:waggly/screens/post.dart';
import 'package:waggly/screens/sign_in.dart';
import 'package:waggly/screens/write.dart';
import 'package:waggly/components/myPage/profileImg/profile_img.dart';
import 'package:waggly/components/myPage/active/index.dart';
import 'package:waggly/components/myPage/active/my_post_list.dart';

import 'components/Post/post_affiliation.dart';
import 'components/Post/post_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
  const HeroApp({Key? key}) : super(key: key);

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
              name: '/postCollege/:collegeName',
              page: () => PostAffiliation(),
              transition: Transition.rightToLeft,
              transitionDuration: const Duration(milliseconds: 350),
              curve: Curves.fastOutSlowIn,
            ),
            GetPage(
              name: '/postDetail/:postId',
              page: () => PostDetail(),
              transition: Transition.rightToLeft,
              transitionDuration: const Duration(milliseconds: 350),
              curve: Curves.fastOutSlowIn,
            ),
            GetPage(name: "/chat", page: () => ChatScreen(), transition: Transition.rightToLeft),
            GetPage(
                name: "/myPage",
                page: () => MyPageScreen(),
                transition: Transition.rightToLeft,
                binding: BindingsBuilder<MyProfileController>(() {
                  Get.put(() {
                    return MyProfileController();
                  });
                })),
            GetPage(name: "/chatEdit", page: () => ChatEditScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/signInPage", page: () => SignInScreen(), transition: Transition.rightToLeft),
            GetPage(
                name: "/writePage",
                // page: () => WritePage(),
                // 그룹채팅방 만들기 페이지가 갈 곳이 없어서 임시로 여기에 라우팅 해둠
                page: () => GroupChatCreatePage(),
                transition: Transition.rightToLeft),
            GetPage(name: "/profileImg", page: () => ProfileImgScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/active", page: () => ActiveScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/notification", page: () => NotificationScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/myPostsList", page: () => MyPostListScreen(), transition: Transition.rightToLeft),
            GetPage(name: "/myRequestList", page: () => RequestScreen(), transition: Transition.rightToLeft),
          ],
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Screen(),
    );
  }
}

// stless
