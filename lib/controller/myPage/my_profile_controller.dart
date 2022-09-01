import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/model/myPage/my_profile_introduction_model.dart';
import 'package:waggly/model/myPage/my_profile_model.dart';
import 'package:waggly/model/myPage/my_profile_provider.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileController extends GetxController {
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
    print(box.get('user')?.jwtToken);
    var profilePic = box.get('user')?.profileImg!;
    print(profilePic);
  }

  Future<void> getMyIntroduction() async {
    print('1');
    var box = Hive.box<User>('user');
    print('2');
    var userIntroduction = box.get('user')?.introduction;
    print(userIntroduction);
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
    box.add(body);
    print(body);
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
