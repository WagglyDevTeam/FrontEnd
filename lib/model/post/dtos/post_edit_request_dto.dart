import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class PostEditRequestDto{
  final String title;
  final String description;
  final String college;
  final List<MultipartFile> file;
  final List<String> deleteTargetUrl;
  final bool? isAnonymous;

  PostEditRequestDto(this.title, this.description, this.college, this.file, this.deleteTargetUrl, this.isAnonymous);

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "college": college,
    "file": file,
    "deleteTargetUrl": deleteTargetUrl,
    "isAnonymous": isAnonymous ?? false
  };
}