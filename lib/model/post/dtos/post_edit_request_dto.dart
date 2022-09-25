import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class PostEditRequestDto{
  final String title;
  final String description;
  final String college;
  final List<MultipartFile> file;
  final List<String> deleteTargetUrl;

  PostEditRequestDto(this.title, this.description, this.college, this.file, this.deleteTargetUrl);

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "college": college,
    "file": file,
    "hashtags": deleteTargetUrl,
  };
}