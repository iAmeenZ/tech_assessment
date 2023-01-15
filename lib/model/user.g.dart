// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyUserHiveAdapter extends TypeAdapter<MyUserHive> {
  @override
  final int typeId = 0;

  @override
  MyUserHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyUserHive(
      themeModeString: fields[0] as String,
      attendances: (fields[1] as List).cast<Attendance>(),
      isTimeAgo: fields[2] as bool,
      isNewUser: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MyUserHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.themeModeString)
      ..writeByte(1)
      ..write(obj.attendances)
      ..writeByte(2)
      ..write(obj.isTimeAgo)
      ..writeByte(3)
      ..write(obj.isNewUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyUserHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
