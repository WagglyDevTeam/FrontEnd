import 'package:hive/hive.dart';
part 'post_search_history.g.dart';

@HiveType(typeId:3)
class PostSearchHistory {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int userId;
  @HiveField(2)
  final String keyword;

  PostSearchHistory({
    required this.id,
    required this.userId,
    required this.keyword,
  });
}