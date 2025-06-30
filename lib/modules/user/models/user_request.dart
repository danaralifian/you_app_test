import 'package:you_app/modules/user/models/user.dart';

class UserRequest {
  final UserModel data;

  UserRequest({required this.data});

  Map<String, dynamic> toJson() {
    return data.toJson();
  }
}
