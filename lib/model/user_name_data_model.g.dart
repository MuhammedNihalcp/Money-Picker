// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_name_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNameModelAdapter extends TypeAdapter<UserNameModel> {
  @override
  final int typeId = 4;

  @override
  UserNameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNameModel(
      username: fields[0] as String,
    )..id = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, UserNameModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
