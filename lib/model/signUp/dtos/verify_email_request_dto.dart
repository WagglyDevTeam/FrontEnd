class VerifyEmailReqeustDto {
  final String email;
  final String certiNum;

  VerifyEmailReqeustDto(
    this.email,
    this.certiNum,
  );

  Map<String, dynamic> toJson() => {
        "email": email,
        "certiNum": certiNum,
      };
}
