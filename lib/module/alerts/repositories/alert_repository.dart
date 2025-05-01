import 'package:naukri_user/local_storage/share_pref_key.dart';
import 'package:naukri_user/local_storage/shared_pref.dart';
import 'package:naukri_user/models/base_response.dart';
import 'package:naukri_user/models/create_alert_model.dart';
import 'package:naukri_user/services/web_services.dart';
import 'package:naukri_user/services/web_services_constant.dart';

class AlertRepository {
  Future<BaseResponse> createAlert({required CreateAlertModel createAlertModel}) async {
    String token = await SharedPref.getString(key: SharePrefKey.authToken);
    
  Map<String,dynamic> body={
    'skills':createAlertModel.skills,
    'email':createAlertModel.email,
    'user_name':createAlertModel.userName,
    'mobile_number':createAlertModel.mobileNumber,
    'location':createAlertModel.location,
    'description':createAlertModel.description,
    'job_title':createAlertModel.jobTitle
  };



    
    String url = WebServicesConstant.baseUrl +
        WebServicesConstant.createAlert;
    return WebServices().postMethod(url: url, body: body, authToken: token);
  }
}