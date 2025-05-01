import 'package:naukri_user/models/user_data_model.dart';

class GetProfileDetailsApiResponse {
  GetProfileDetailsApiResponse({
    required this.data,
    required this.message,
    required this.status,
  });
  late final UserData data;
  late final String message;
  late final String status;
  
  GetProfileDetailsApiResponse.fromJson(Map<String, dynamic> json){
    data = UserData.fromJson(json['data']);
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    _data['status'] = status;
    return _data;
  }
}


