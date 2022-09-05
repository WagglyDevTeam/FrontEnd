import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/model/myPage/dtos/ProfileImgDto.dart';
import 'package:waggly/model/myPage/my_profile_introduction_model.dart';
import 'package:waggly/model/myPage/my_profile_model.dart';
import 'package:waggly/model/myPage/my_profile_provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/post/dtos/waggly_response_dto.dart';

class MyProfileController extends GetxController {
  final MyProfileProvider _myProfileProvider = MyProfileProvider();
  final picker = ImagePicker();
  final nicknameBtn = false.obs;
  final bioBtn = false.obs;
  final cameraBtn = false.obs;
  var profilePic = "".obs;
  final nickname = "".obs;
  var university = "".obs;
  final major = "".obs;
  var bio = "".obs;
  final uploadProfileImg = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await getMyProfile();
    await getMyIntroduction();
    print(nickname.value);
  }

  Future<void> getMyProfile() async {
    var getBox = Hive.box<User>('user').get('user');
    var name = getBox?.nickName!;
    var university = getBox?.university!;
    var major = getBox?.major;
    var profileImg = getBox?.profileImg;
    nickname.value = name!;
    this.university.value = university!;
    this.major.value = major!;
    profilePic.value = profileImg!;
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
    var box = Hive.box<User>('user');
    var user = box.get('user');
    // Hive 에 저장된 User 객체안의 nickName을 변경후에 Controller에서 저장중인 nickName도 같이 변경해준다!
    user?.editUserNickName(profileData.nickname);
    box.put('user',user!);
    var changeName = box.get('user')?.nickName!;
    nickname.value = changeName!;
    //

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
      // final test =
      //     await ImagePicker().pickImage(source: ImageSource.gallery);
      final test = await picker.pickImage(source: ImageSource.gallery);

      if (test == null) return;

      uploadProfileImg.value = test.path;
      final FormData formData = FormData({
        'profileImg' : MultipartFile(File(uploadProfileImg.value), filename: test.name)
      });

      Response response = await _myProfileProvider.uploadProfileImg(formData);
      dynamic body = response.body;
      WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);

      // Hive 에 저장된 User 객체안의 nickName을 변경후에 Controller에서 저장중인 nickName도 같이 변경해준다!
      var box = Hive.box<User>('user');
      var user = box.get('user');
      var changeProfileImg = wagglyResponseDto.datas['profileImg'];
      user?.editUserProfileImg(changeProfileImg);
      box.put('user',user!);
      profilePic.value = changeProfileImg;

      print(response.statusCode);
      print(wagglyResponseDto.datas['profileImg']);
      //setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
  }
}
