class SignInRequestDto{
  final String email;
  final String password;

  SignInRequestDto(
      this.email,
      this.password
      );

  Map<String, dynamic> toJson() => {
    "username": email,
    "password": password
  };
}