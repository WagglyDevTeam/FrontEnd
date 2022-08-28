class SignUpRequestDto {
  final String email;
  final String password;
  final String nickname;
  final String university;
  final String classNumber;
  final String major;
  final String gender;
  //
  SignUpRequestDto(
    this.email,
    this.password,
    this.nickname,
    this.university,
    this.classNumber,
    this.major,
    this.gender,
  );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "nickname": nickname,
        "university": university,
        "classNumber": int.parse(classNumber),
        "major": int.parse(major),
        "gender": gender,
      };
}
