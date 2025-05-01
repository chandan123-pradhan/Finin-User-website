import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naukri_user/models/base_response.dart';
import 'package:naukri_user/models/response/get_job_details_api_response.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/module/home/repositories/home_repositories.dart';
import 'package:naukri_user/services/api_state.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:naukri_user/utils/loading_utils.dart';
import 'package:naukri_user/utils/music_utils.dart';
import 'package:naukri_user/utils/snackbar_utils.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepositories _homeRepositories = HomeRepositories();
  GetJobDetailsApiResponse? getJobDetailsApiResponse;
  bool isloading = true;

  void getJobDetails(
      {required String jobId, required BuildContext context}) async {
        isloading=true;
        notifyListeners();
    BaseResponse baseResponse =
        await _homeRepositories.getJobDetails(jobId: jobId);
    isloading = false;
    switch (baseResponse.status) {
      case RequestState.success:
        getJobDetailsApiResponse =
            GetJobDetailsApiResponse.fromJson(baseResponse.responseBody);

        break;

      default:
        Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
        break;
    }
    notifyListeners();
  }

  void applyJob({required String jobId, required BuildContext context}) async {
    try {
      LoadingUtils.showLoadingDialog(context);
      BaseResponse baseResponse =
          await _homeRepositories.applyJob(jobId: jobId);
      LoadingUtils.dismissLoadingDialog(context);
      isloading = false;
      switch (baseResponse.status) {
        case RequestState.success:
          MusicUtils().success();
          SnackbarUtils.showSuccessMsg(
              message: baseResponse.responseBody['message'], context: context);
          Navigator.pop(context);
          break;
        case RequestState.unautherized:
           Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
           break;
        default:
          SnackbarUtils.showErrorMsg(
              message: baseResponse.responseBody['message'], context: context);
          break;
      }
     
    } catch (e) {
      LoadingUtils.dismissLoadingDialog(context);
    }
  }

  @override
  void dispose() {
    getJobDetailsApiResponse = null;
    isloading = true;
    // TODO: implement dispose
    super.dispose();
  }
}
