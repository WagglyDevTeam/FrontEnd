class DeviceTokenRequestDto {
  final String deviceToken;

  DeviceTokenRequestDto(this.deviceToken);

  Map<String, dynamic> toJson() => {"deviceToken": deviceToken};
}
