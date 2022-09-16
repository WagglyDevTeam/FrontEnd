import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  String? nickName;
  @HiveField(2)
  final String? university;
  @HiveField(3)
  final int? classNumber;
  @HiveField(4)
  final String? major;
  @HiveField(5)
  final String? gender;
  @HiveField(6)
  String? profileImg;
  @HiveField(7)
  final String? introduction;
  @HiveField(8)
  String? jwtToken;

  User(
      {this.id,
      this.nickName,
      this.university,
      this.classNumber,
      this.major,
      this.gender,
      this.profileImg,
      this.introduction,
      this.jwtToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userId'],
      nickName: json['nickName'],
      university: json['university'],
      classNumber: json['classNumber'],
      major: json['major'],
      gender: json['gender'],
      profileImg: json['profileImg'],
      introduction: json['introduction'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nickName': nickName,
        'university': university,
        'classNumber': classNumber,
        'major': major,
        'gender': gender,
        'profileImg': profileImg,
        'introduction': introduction,
        'jwtToken': jwtToken,
      };

  factory User.fromDto(WagglyResponseDto dto) {
    return User(
      id: dto.datas['userId'],
      nickName: dto.datas['nickName'],
      university: dto.datas['university'],
      classNumber: dto.datas['classNumber'],
      major: dto.datas['major'],
      gender: dto.datas['gender'],
      profileImg: dto.datas['profileImg'],
      introduction: dto.datas['introduction'],
    );
  }

  void editUserNickName(String nickName){
    this.nickName = nickName;
  }

  void editUserProfileImg(String profileImg){
    this.profileImg = profileImg;
  }
}
