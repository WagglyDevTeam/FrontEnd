class WagglyResponsePaginationDto {
  final int? code;
  final String? message;
  final dynamic status;
  final int? totalCount;
  final int? totalPage;
  final dynamic datas;

  WagglyResponsePaginationDto({
    this.code,
    this.message,
    this.status,
    this.totalCount,
    this.totalPage,
    this.datas,
  });

  factory WagglyResponsePaginationDto.fromJson(Map<String, dynamic> json) {
    return WagglyResponsePaginationDto(
      code: json["code"],
      message: json["message"],
      status: json["status"],
      totalCount: json["totalCount"],
      totalPage: json["totalPage"],
      datas: json["datas"],
    );
  }
}
