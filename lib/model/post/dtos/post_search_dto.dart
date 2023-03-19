

class PostSearchRequestDto{
  String? keyword;
  int? page;
  int? size;

  PostSearchRequestDto({this.keyword, this.page, this.size});
  factory PostSearchRequestDto.fromJson(Map<String, dynamic> json) => PostSearchRequestDto(
    keyword: json["keyword"],
    page: json["page"],
    size: json["size"],
  );
  Map<String, dynamic> toJson() => {
    "keyword": keyword,
    "page" : page,
    "size" : size,
  };
}