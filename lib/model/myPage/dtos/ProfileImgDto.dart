import 'package:get/get.dart';

class ProfileImgDto{
  final MultipartFile profileImg;

  ProfileImgDto(
      this.profileImg
      );

  Map<String, dynamic> toJson() => {
    "profileImg": profileImg,
  };
}