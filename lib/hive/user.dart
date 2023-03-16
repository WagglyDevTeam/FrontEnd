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
  String? college;
  @HiveField(6)
  final String? gender;
  @HiveField(7)
  String? profileImg;
  @HiveField(8)
  final String? introduction;
  @HiveField(9)
  String? jwtToken;


  User(
      {this.id,
      this.nickName,
      this.university,
      this.classNumber,
      this.major,
        this.college,
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
      college: json['college'],
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
    'college': college,
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
      college: dto.datas['college'],
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
