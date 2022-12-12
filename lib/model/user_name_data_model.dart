import 'package:hive_flutter/hive_flutter.dart';
part 'user_name_data_model.g.dart';

@HiveType(typeId: 4)
class UserNameModel extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(1)
  String? id;

  UserNameModel({
    required this.username,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
  updateusername(String name) async {
    username = name;
    save();
  }
}
