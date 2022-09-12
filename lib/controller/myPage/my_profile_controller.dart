import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/model/myPage/my_profile_introduction_model.dart';
import 'package:waggly/model/myPage/my_profile_model.dart';
import 'package:waggly/model/myPage/my_profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waggly/model/post/post_provider.dart';

class MyProfileController extends GetxController {
  final SignInController signInController = SignInController();
  final MyProfileProvider _myProfileProvider = MyProfileProvider();
  final nicknameBtn = false.obs;
  final bioBtn = false.obs;
  final cameraBtn = false.obs;

  var profilePic = [].obs;
  final nickname = "".obs;
  var bio = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await getMyProfile();
    await getMyIntroduction();
  }

  Future<void> getMyProfile() async {
    var box = Hive.box<User>('user');
    var name = box.get('user')?.nickName!;
    nickname.value = name!;
    var profilePic = box.get('user')?.profileImg!;
    print(profilePic);
  }

  Future<void> getMyIntroduction() async {
    var box = Hive.box<User>('user');
    var userIntroduction = box.get('user')?.introduction;
    print(box.get('user')?.introduction!);
    bio.value = userIntroduction!;
  }

  Future<void> changeUserProfile(ProfileData profileData) async {
    FormData form = FormData(profileData.toJson());
    await _myProfileProvider.modifyProfile(form);
  }

  Future<void> changeUserIntroduction(Bio bio) async {
    Response response = await _myProfileProvider.putIntroduction(bio.toJson());
    dynamic body = response.body;
    var box = Hive.box<User>('user');
    User userData = User(
        id: box.get('user')?.id,
        nickName: box.get('user')?.nickName,
        university: box.get('user')?.university,
        classNumber: box.get('user')?.classNumber,
        major: box.get('user')?.major,
        gender: box.get('user')?.gender,
        profileImg: box.get('user')?.profileImg,
        jwtToken: box.get('user')?.jwtToken,
        introduction: body['datas']['userIntroduction']);
    print(userData);
    await box.putAt(0, userData);
    await getMyIntroduction();
  }

  Future pickImage() async {
    try {
      final profilePic =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (profilePic == null) return;

      final imageTemp = (profilePic.path);
      debugPrint('data: $imageTemp');

      //setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
  }
}
