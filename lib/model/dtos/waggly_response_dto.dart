class WagglyResponseDto {
  final int? code;
  final String? message;
  final String? status;
  final dynamic datas;

  WagglyResponseDto({
    this.code,
    this.message,
    this.status,
    this.datas,
  });

  factory WagglyResponseDto.fromJson(Map<String, dynamic> json) {
    return WagglyResponseDto(
      code: json["code"],
      message: json["msg"],
      status: json["status"],
      datas: json["datas"],
    );
  }
}
