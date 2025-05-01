
import 'package:naukri_user/services/api_state.dart';

class BaseResponse {
  RequestState status;
  String message;
  Map<String,dynamic> responseBody;
  BaseResponse({required this.status,required this.message,required this.responseBody});
}