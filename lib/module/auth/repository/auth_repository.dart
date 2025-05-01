import 'dart:convert';

import 'package:naukri_user/local_storage/share_pref_key.dart';
import 'package:naukri_user/local_storage/shared_pref.dart';
import 'package:naukri_user/models/base_response.dart';
import 'package:naukri_user/models/register_model.dart';
import 'package:naukri_user/services/web_services.dart';
import 'package:naukri_user/services/web_services_constant.dart';
import 'package:naukri_user/services/web_services_params.dart';

class AuthRepository {
  Future<BaseResponse?> callLoginApi(
      {required String email, required String password}) async {
    Map<String, dynamic> body = {
      WebServicesParams.emailId: email,
      WebServicesParams.password: password
    };
    String url =
        WebServicesConstant.baseUrl + WebServicesConstant.loginRouteUrl;
    return WebServices().postMethod(url: url, body: body);
  }

  Future<BaseResponse?> callGenerateOtpApi({required String phone}) async {
    Map<String, dynamic> body = {
      WebServicesParams.phone: phone,
    };
    String url =
        WebServicesConstant.baseUrl + WebServicesConstant.generateOtpUrl;
    return WebServices().postMethod(url: url, body: body);
  }

  Future<BaseResponse?> callVerifyOtpApi(
      {required String phone,
      required String otp,
      required bool fromRegister}) async {
    Map<String, dynamic> body = {
      WebServicesParams.phone: phone,
      WebServicesParams.otp: otp,
    };
    String url;
    if (fromRegister == true) {
      url = WebServicesConstant.baseUrl + WebServicesConstant.verifyOtpUrl;
    } else {
      url = WebServicesConstant.baseUrl + WebServicesConstant.loginViaOtp;
    }
    return WebServices().postMethod(url: url, body: body);
  }

  Future<BaseResponse?> callSignupApi(
      {required RegisterModel registerModel}) async {
    Map<String, dynamic> body = {
      WebServicesParams.emailId: registerModel.emailId,
      WebServicesParams.password: registerModel.password,
      WebServicesParams.confirmPassword: registerModel.confirmPassword,
      WebServicesParams.fullName: registerModel.fullName,
      WebServicesParams.heighestQualification:
          registerModel.heighestQualification,
      WebServicesParams.mobileNumber: registerModel.mobileNumber,
      WebServicesParams.prefferedLocation: registerModel.prefferedLocation,
      WebServicesParams.prefferedSallary: registerModel.prefferedSallary,
      WebServicesParams.prefferedShift: registerModel.prefferedShift,
      WebServicesParams.employmentType: registerModel.empType,
      WebServicesParams.description: registerModel.description,
      WebServicesParams.skills: registerModel.skills
    };
    String url =
        WebServicesConstant.baseUrl + WebServicesConstant.registerRouteUrl;
    return WebServices()
        .postMethod(url: url, body: body, file: registerModel.profilePic);
  }

  Future<BaseResponse> updateEmploymentDetails({required List data}) async {
    String token = await SharedPref.getString(key: SharePrefKey.authToken);
    Map<String, dynamic> body = {'employment_history': data};

    String url = WebServicesConstant.baseUrl +
        WebServicesConstant.updateEmploymentDetails;
    return WebServices().postMethod(url: url, body: body, authToken: token);
  }
}
