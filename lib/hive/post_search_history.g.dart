
part of 'post_search_history.dart';

class PostHistoryAdapter extends TypeAdapter<PostSearchHistory>{
  @override
  final int typeId =3;

  @override
  PostSearchHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostSearchHistory(
      id: fields[0] as int,
      userId: fields[1] as int,
      keyword: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PostSearchHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.keyword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is PostHistoryAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}