
import 'package:naukri_user/models/user_model.dart';

class UserData {
  UserData({
    required this.user,
  });
  late final UserModel user;
  
  UserData.fromJson(Map<String, dynamic> json){
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    return _data;
  }
}