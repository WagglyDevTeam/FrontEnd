import 'package:hive/hive.dart';
part 'search_history.g.dart';

@HiveType(typeId: 1)
class SearchHistory {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int userId;
  @HiveField(2)
  final String keyword;

  SearchHistory({
    required this.id,
    required this.userId,
    required this.keyword,
  });
}
