import 'package:flutter/material.dart';
import 'package:naukri_user/models/base_response.dart';
import 'package:naukri_user/models/create_alert_model.dart';
import 'package:naukri_user/models/user_model.dart';
import 'package:naukri_user/module/alerts/repositories/alert_repository.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/services/api_state.dart';
import 'package:naukri_user/utils/loading_utils.dart';
import 'package:naukri_user/utils/snackbar_utils.dart';
import 'package:provider/provider.dart';

class AlertProvider extends ChangeNotifier {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  AlertRepository alertRepository = new AlertRepository();

  Future<bool> createAlert(context) async {
    LoadingUtils.showLoadingDialog(context);
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: false);
    UserModel userModel =
        dashboardProvider.getProfileDetailsApiResponse!.data.user;

    CreateAlertModel createAlertModel = CreateAlertModel(
        skills: userModel.skills,
        email: userModel.emailId,
        userName: userModel.fullName,
        mobileNumber: userModel.mobileNumber,
        location: locationController.text,
        description: descriptionController.text,
        jobTitle: jobTitleController.text);
    BaseResponse baseResponse =
        await alertRepository.createAlert(createAlertModel: createAlertModel);
    LoadingUtils.dismissLoadingDialog(context);
    switch (baseResponse.status) {
      case RequestState.success:
        clearFields();
        return true;

      default:
        SnackbarUtils.showErrorMsg(
            message: baseResponse.responseBody['message'], context: context);
        return false;
    }
  }

  void clearFields() {
    jobTitleController.clear();
    locationController.clear();
    descriptionController.clear();
  }
}
