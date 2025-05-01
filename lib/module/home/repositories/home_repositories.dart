import 'package:naukri_user/local_storage/share_pref_key.dart';
import 'package:naukri_user/local_storage/shared_pref.dart';
import 'package:naukri_user/models/base_response.dart';
import 'package:naukri_user/services/web_services.dart';
import 'package:naukri_user/services/web_services_constant.dart';

class HomeRepositories {
  final WebServices _webServices = WebServices();

  Future<BaseResponse> getJobDetails({required String jobId}) async {
    String url =
        WebServicesConstant.baseUrl + WebServicesConstant.jobDetails;
    String token = await SharedPref.getString(key: SharePrefKey.authToken);
    Map<String, dynamic> params = {'job_id': jobId};
    BaseResponse baseResponse =
        await _webServices.postMethod(url: url, authToken: token, body: params);
    return baseResponse;
  }
  Future<BaseResponse> applyJob({required String jobId}) async {
    String url =
        WebServicesConstant.baseUrl + WebServicesConstant.applyJobs;
    String token = await SharedPref.getString(key: SharePrefKey.authToken);
    Map<String, dynamic> params = {'job_id': jobId};
    BaseResponse baseResponse =
        await _webServices.postMethod(url: url, authToken: token, body: params);
    return baseResponse;
  }
}
