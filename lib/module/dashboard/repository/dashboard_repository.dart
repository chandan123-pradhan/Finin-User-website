import 'package:naukri_user/local_storage/share_pref_key.dart';
import 'package:naukri_user/local_storage/shared_pref.dart';
import 'package:naukri_user/models/base_response.dart';
import 'package:naukri_user/services/web_services.dart';
import 'package:naukri_user/services/web_services_constant.dart';

class DashboardRepository {
  final WebServices _webServices=WebServices();
  Future<BaseResponse>getProfileDetails()async{
    String url=WebServicesConstant.baseUrl+WebServicesConstant.getProfileDetails;
    String token=await SharedPref.getString(key: SharePrefKey.authToken);
    BaseResponse baseResponse=await _webServices.getMethod(url: url,authToken: token);
    return baseResponse;
  }

  Future<BaseResponse>getJobs()async{
    String url=WebServicesConstant.baseUrl+WebServicesConstant.getJobs;
    String token=await SharedPref.getString(key: SharePrefKey.authToken);
    BaseResponse baseResponse=await _webServices.getMethod(url: url,authToken: token);
    return baseResponse;
  }

    Future<BaseResponse>getAppliedJobs()async{
    String url=WebServicesConstant.baseUrl+WebServicesConstant.getAppliedJob;
    String token=await SharedPref.getString(key: SharePrefKey.authToken);
    BaseResponse baseResponse=await _webServices.getMethod(url: url,authToken: token);
    return baseResponse;
  }

   Future<BaseResponse>searchJobs(String querry)async{
    String url=WebServicesConstant.baseUrl+WebServicesConstant.getJobs;
    String token=await SharedPref.getString(key: SharePrefKey.authToken);
    BaseResponse baseResponse=await _webServices.postMethod(url: url,authToken: token,
    body: {'title':querry}
    );
    return baseResponse;
  }

}