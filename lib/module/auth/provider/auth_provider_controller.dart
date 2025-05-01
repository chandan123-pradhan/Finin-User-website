import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naukri_user/local_storage/share_pref_key.dart';
import 'package:naukri_user/local_storage/shared_pref.dart';
import 'package:naukri_user/models/base_response.dart';
import 'package:naukri_user/models/register_model.dart';
import 'package:naukri_user/module/auth/repository/auth_repository.dart';
import 'package:naukri_user/module/auth/ui/otp_page.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/services/api_state.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:naukri_user/utils/helper_methods.dart';
import 'package:naukri_user/utils/loading_utils.dart';
import 'package:naukri_user/utils/snackbar_utils.dart';

class AuthProviderController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController prefferedLocationController = TextEditingController();
  TextEditingController prefferedSallaryController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  String selectedPrefferedShift = 'Day Shift';
  String selectedJobType = 'Full Time';
  TextEditingController descriptionController = TextEditingController();
  String selectedQualification = 'Graduate (BA/BSC/B.COM)';
  XFile? pickedFile;
  List<String> heighestQualification = [
    '10th Pass',
    '12th Pass',
    'Graduate (BA/BSC/B.COM)',
    'Computer Science Graduate(B.C.A)',
    "Engineering(B.TECH)",
  ];
  List<String> prefferedShift = ['Day Shift', 'Night Shift', 'Day/Night Shift'];
  List<String> employmentType = ['Full Time', 'Part Time', 'Full/Part Time'];

  // State variable to track the employment details
  List<Map<String, String>> employmentDetails = [
    {
      'employer_name': '',
      'designation': '',
      'start_date': '',
      'end_date': '',
    },
  ];

  AuthRepository authRepository = AuthRepository();

  // Login function (no changes here)
  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    LoadingUtils.showLoadingDialog(context);
    // Form validation passed, now proceed with login
    BaseResponse? baseResponse =
        await AuthRepository().callLoginApi(email: email, password: password);
    LoadingUtils.dismissLoadingDialog(context);
    switch (baseResponse!.status) {
      case RequestState.success:
        SnackbarUtils.showSuccessMsg(
            message: baseResponse.responseBody['message'], context: context);
        _saveConfigDataAndNavigate(
            baseResponse: baseResponse, context: context, phone: "");
        break;
      default:
        SnackbarUtils.showErrorMsg(
            message: baseResponse.responseBody['message'], context: context);
        break;
    }
    // Simulate a login process (you can replace this with your API logic)
  }

  Future<void> generateOtp(
      {required BuildContext context,
      required phone,
      bool fromOtp = false}) async {
    LoadingUtils.showLoadingDialog(context);
    BaseResponse? baseResponse =
        await AuthRepository().callGenerateOtpApi(phone: phone);
    LoadingUtils.dismissLoadingDialog(context);
    switch (baseResponse!.status) {
      case RequestState.success:
        SnackbarUtils.showSuccessMsg(
            message: baseResponse.responseBody['message'], context: context);
        if (fromOtp == false) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpPage(phoneNumber: phone)));
        }
        break;
      default:
        SnackbarUtils.showErrorMsg(
            message: baseResponse.responseBody['message'], context: context);
        break;
    }
  }

  Future<void> verifyOtp(
      {required BuildContext context,
      required phone,
      required otp,
      bool fromRegister = false}) async {
    LoadingUtils.showLoadingDialog(context);
    BaseResponse? baseResponse = await AuthRepository()
        .callVerifyOtpApi(phone: phone.toString(), otp: otp.toString(),fromRegister:fromRegister);
    LoadingUtils.dismissLoadingDialog(context);
    switch (baseResponse!.status) {
      case RequestState.success:
        SnackbarUtils.showSuccessMsg(
            message: baseResponse.responseBody['message'], context: context);
        if (fromRegister == true) {
          Navigator.pushReplacementNamed(
              context, AppRoutes.completeProfilePage);
        } else {
          _saveConfigDataAndNavigate(
              baseResponse: baseResponse,
              context: context,
              isRegster: false,
              phone: phone);
        }
        break;
      default:
        SnackbarUtils.showErrorMsg(
            message: baseResponse.responseBody['message'], context: context);
        break;
    }
  }

  Future<void> register({required BuildContext context}) async {
    LoadingUtils.showLoadingDialog(context);

    RegisterModel registerModel = RegisterModel(
        fullName: fullNameController.text,
        emailId: emailController.text,
        heighestQualification: selectedQualification,
        password: passwordController.text,
        confirmPassword: passwordController.text,
        mobileNumber: mobileNumberController.text,
        profilePic: File(pickedFile!.path),
        prefferedLocation: prefferedLocationController.text,
        prefferedSallary: prefferedSallaryController.text,
        skills: skillsController.text,
        prefferedShift: selectedPrefferedShift,
        empType: selectedJobType,
        description: descriptionController.text);
    // Form validation passed, now proceed with login
    BaseResponse? baseResponse =
        await AuthRepository().callSignupApi(registerModel: registerModel);
    LoadingUtils.dismissLoadingDialog(context);
    switch (baseResponse!.status) {
      case RequestState.success:
        SnackbarUtils.showSuccessMsg(
            message: baseResponse.responseBody['message'], context: context);
        _saveConfigDataAndNavigate(
          baseResponse: baseResponse,
          context: context,
          isRegster: true,
          phone: mobileNumberController.text,
        );
        break;
      default:
        SnackbarUtils.showErrorMsg(
            message: baseResponse.responseBody['message'], context: context);
        break;
    }
  }

  void submitPreviousEmployment(context) async {
    print(employmentDetails);
    BaseResponse baseResponse =
        await authRepository.updateEmploymentDetails(data: employmentDetails);
    switch (baseResponse!.status) {
      case RequestState.success:
        SnackbarUtils.showSuccessMsg(
            message: baseResponse.responseBody['message'], context: context);
        DashboardProvider().initConfig(context);
        Navigator.pop(context);
        break;
      default:
        SnackbarUtils.showErrorMsg(
            message: baseResponse.responseBody['message'], context: context);
        break;
    }
  }

  _saveConfigDataAndNavigate(
      {required BaseResponse baseResponse,
      required BuildContext context,
      required String? phone,
      bool isRegster = false}) {
    SharedPref.saveString(
        key: SharePrefKey.authToken,
        value: baseResponse.responseBody['data']['token']);
    if (isRegster) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OtpPage(phoneNumber: phone)));
    } else {
      // Navigator.pushReplacementNamed(context, AppRoutes.dashboardPage); 
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
    }
  }

  // Add a new employment detail entry
  void addEmploymentDetail() {
    employmentDetails.add({
      'employer_name': '',
      'designation': '',
      'start_date': '',
      'end_date': '',
    });
    notifyListeners();
  }

  // Remove a set of employment details at a particular index
  void removeEmploymentDetail(int index) {
    employmentDetails.removeAt(index);
    notifyListeners();
  }

  // Update any field of a particular employment detail
  void updateField(int index, String field, String value) {
    employmentDetails[index][field] = value;
    notifyListeners();
  }

  // Optionally, we could provide specific methods for updating dates, but the general updateField can handle this.
  // For example, you can use these to update the From Date and To Date directly.
  void updateFromDate(int index, String date) {
    employmentDetails[index]['start_date'] = date;
    notifyListeners();
  }

  void updateToDate(int index, String date) {
    employmentDetails[index]['end_date'] = date;
    notifyListeners();
  }

  // Function to validate the dates
  bool isValidDateRange(int index) {
    String fromDate = employmentDetails[index]['start_date'] ?? '';
    String toDate = employmentDetails[index]['end_date'] ?? '';
    if (fromDate.isNotEmpty && toDate.isNotEmpty) {
      DateTime from = DateTime.parse(fromDate);
      DateTime to = DateTime.parse(toDate);
      return to.isAfter(from); // Ensure toDate is after fromDate
    }
    return true;
  }

  pickImage() async {
    pickedFile = await HelperMethods.pickImage(ImageSource.gallery);
    notifyListeners();
  }

  selectShift(String val) {
    selectedPrefferedShift = val;
    notifyListeners();
  }

  selectedEmpType(String val) {
    selectedJobType = val;
    notifyListeners();
  }

  selectQualification(String val) {
    selectedQualification = val;
    notifyListeners();
  }
}
