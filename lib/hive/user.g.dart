// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      nickName: fields[1] as String?,
      university: fields[2] as String?,
      classNumber: fields[3] as int?,
      major: fields[4] as String?,
      gender: fields[5] as String?,
      profileImg: fields[6] as String?,
      introduction: fields[7] as String?,
      jwtToken: fields[8] as String?,
      deviceToken: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nickName)
      ..writeByte(2)
      ..write(obj.university)
      ..writeByte(3)
      ..write(obj.classNumber)
      ..writeByte(4)
      ..write(obj.major)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.profileImg)
      ..writeByte(7)
      ..write(obj.introduction)
      ..writeByte(8)
      ..write(obj.jwtToken)
      ..writeByte(9)
      ..write(obj.deviceToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
