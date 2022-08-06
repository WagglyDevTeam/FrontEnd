enum CollegeType {
  engineering,
  social,
  nature,
  artsports,
  medical,
}

class PostRequestDto {
  final String title;
  final String description;
  final String college;
  final bool? isAnonymous;

  PostRequestDto(this.title, this.description, this.college, this.isAnonymous);

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "college": college,
        "isAnonymous": isAnonymous ?? false
      };
}
