class PostRequestDto {
  final String title;
  final String content;
  final String college;
  final bool isAnonymous;

  PostRequestDto(this.title, this.content, this.college, this.isAnonymous);

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
