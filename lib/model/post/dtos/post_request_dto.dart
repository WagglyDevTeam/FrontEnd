import 'package:get/get.dart';

class PostRequestDto {
  final String title;
  final String description;
  final String college;
  final bool? isAnonymous;
  final List<MultipartFile>? file;

  PostRequestDto(this.title, this.description, this.college, this.isAnonymous, this.file);

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "college": college,
        "isAnonymous": isAnonymous ?? false,
        "file": file ?? <MultipartFile>[],
      };
}
