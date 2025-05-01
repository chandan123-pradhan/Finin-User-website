import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naukri_user/common_widgets/bottom_widget.dart';
import 'package:naukri_user/common_widgets/drop_down_widget.dart';
import 'package:naukri_user/common_widgets/text_field_widgets.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/module/auth/provider/auth_provider_controller.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:naukri_user/utils/snackbar_utils.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for each text field

    // Form key to validate the form fields
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        backgroundColor: ColorUtils.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(size: 16),
      ),
      body: Consumer<AuthProviderController>(
          builder: (context, authProviderController, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Attach the form key to Form widget
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingH4(
                      context: context, text: 'Create your Naukri profile'),
                  const SizedBox(height: 5),
                  headingH10(
                      context: context,
                      text:
                          "Search & apply to jobs from india's No. 1 Job site"),
                  const SizedBox(height: 35),
                  _buildProfilePicSelection(
                      context: context,
                      onPressed: () {
                        authProviderController.pickImage();
                      },
                      pickedImage: authProviderController.pickedFile),
                  const SizedBox(height: 40),
                  // Full Name Field
                  _buildFullField(
                      controller: authProviderController.fullNameController,
                      context: context),
                  const SizedBox(height: 20),

                  // Email Field with validation
                  _buildEmailField(
                      controller: authProviderController.emailController,
                      context: context),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headingH11(
                        context: context,
                        text:
                            "We'll send relevant jobs and updates to this email"),
                  ),

                  const SizedBox(height: 12),
                  // Email Field with validation
                  _buildSkillsWidget(
                      controller: authProviderController.skillsController,
                      context: context),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headingH11(
                        context: context,
                        text: "Add Comma Seperated if multiple skills"),
                  ),
                  const SizedBox(height: 12),
                  _buildDropDown(
                      items: authProviderController.heighestQualification,
                      selectedValue:
                          authProviderController.selectedQualification,
                      onChanged: (val) {
                        authProviderController.selectQualification(val!);
                      },
                      context: context),
                  const SizedBox(height: 20),
                  _buildDropDown(
                      items: authProviderController.prefferedShift,
                      selectedValue:
                          authProviderController.selectedPrefferedShift ?? '',
                      onChanged: (val) {
                        authProviderController.selectShift(val!);
                      },
                      context: context),
                  const SizedBox(height: 20),
                  _buildDropDown(
                      items: authProviderController.employmentType,
                      selectedValue: authProviderController.selectedJobType,
                      onChanged: (val) {
                        authProviderController.selectedEmpType(val!);
                      },
                      context: context),
                  const SizedBox(height: 20),

                  // Highest Qualification Field with validation

                  _buildPrefferedLocation(
                      controller:
                          authProviderController.prefferedLocationController,
                      context: context),
                  const SizedBox(height: 20),

                  _buildPrefferedSallary(
                      controller:
                          authProviderController.prefferedSallaryController,
                      context: context),
                  const SizedBox(height: 20),

                  // Mobile Number Field with validation
                  _buildMobileNumberField(
                      controller: authProviderController.mobileNumberController,
                      context: context),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headingH11(
                        context: context,
                        text: "Recruiters will contact you on this number"),
                  ),
                  const SizedBox(height: 12),
                  _buildDescriptionTextField(
                      controller: authProviderController.descriptionController,
                      context: context),

                  const SizedBox(height: 20),

                  // Password Field with validation
                  _buildPasswordField(
                      controller: authProviderController.passwordController,
                      context: context),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headingH11(
                        context: context,
                        text: "This helps your account stay protected"),
                  ),

                  const SizedBox(height: 20),

                  // Register Button
                  BottomWidget.getMainBottom(
                    context: context,
                    title: 'Register',
                    onPressed: () {
                      _validateAndRegister(
                          context,
                          _formKey, // Form key for validation
                          authProviderController);
                    },
                  ),
                  const SizedBox(height: 10),

                  // Terms and conditions
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      headingH10(
                          context: context,
                          text: "By registering, you agree to the "),
                      headingH10(
                          context: context,
                          text: "Terms & Conditions ",
                          color: ColorUtils.primaryBlue),
                      headingH10(context: context, text: "and "),
                      headingH10(
                          context: context,
                          text: "Privacy Policy.",
                          color: ColorUtils.primaryBlue),
                    ],
                  ),
                  const SizedBox(height: 45),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _buildProfilePicSelection(
      {required BuildContext context,
      required Function onPressed,
      XFile? pickedImage}) {
    return Center(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          onPressed();
        },
        child: Stack(
          children: [
            Container(
              height: displayHeight(context) / 6,
              width: displayHeight(context) / 6,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: ColorUtils.darkGray)),
              child: Center(
                child: pickedImage == null
                    ? ImageUtils.getImage(
                        image: ImageUtils.ProfileIcon,
                        height: displayHeight(context) / 6.99)
                    : Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(
                                  File(
                                    pickedImage.path,
                                  ),
                                ))),
                      ),
              ),
            ),
            Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // Full Name Field with validation
  _buildFullField(
      {required TextEditingController controller,
      required BuildContext context}) {
    return TextFieldWidgets.getGuiderTextField(
      context: context,
      controller: controller,
      guiderMessage: 'कृपया अपना पूरा नाम दर्ज करें।',
      title: 'Full name*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Full name is required';
        }
        return null; // No error
      },
    );
  }

  // Email Field with validation
  _buildSkillsWidget(
      {required TextEditingController controller,
      required BuildContext context}) {
    return TextFieldWidgets.getGuiderTextField(
      context: context,
      controller: controller,
      guiderMessage: 'कृपया अपनी क्षमताएँ दर्ज करें!',
      title: 'Skills*  (example:- Flutter, Dart, Programming C)',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        return null; // No error
      },
    );
  }

  // Email Field with validation
  _buildEmailField(
      {required TextEditingController controller,
      required BuildContext context}) {
    return TextFieldWidgets.getGuiderTextField(
      context: context,
      controller: controller,
      guiderMessage: 'कृपया अपना ईमेल आईडी दर्ज करें।',
      title: 'Email ID*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null; // No error
      },
    );
  }

  // Password Field with validation
  _buildPasswordField(
      {required TextEditingController controller,
      required BuildContext context}) {
    return TextFieldWidgets.getGuiderTextField(
      guiderMessage: 'कृपया 6 अंकों का पासवर्ड दर्ज करें',
      context: context,
      controller: controller,
      title: 'Create password* (Minimum 6 characters)',
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null; // No error
      },
    );
  }

  // Mobile Number Field with validation
  _buildMobileNumberField(
      {required TextEditingController controller,
      required BuildContext context}) {
    return TextFieldWidgets.getGuiderTextField(
      guiderMessage: 'कृपया मोबाइल नंबर दर्ज करें',
      context: context,
      controller: controller,
      title: 'Mobile Number*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mobile number is required';
        } else if (value.length != 10) {
          return 'Please enter a valid 10-digit mobile number';
        }
        return null; // No error
      },
    );
  }

  // Highest Qualification Field with validation
  _buildDescriptionTextField(
      {required TextEditingController controller,
      required BuildContext context}) {
    return TextFieldWidgets.getDescriptionText(
      context: context,
      controller: controller,
      title: 'Description*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Description is required';
        }
        return null; // No error
      },
    );
  }

  // Highest Qualification Field with validation
  _buildPrefferedLocation(
      {required TextEditingController controller,
      required BuildContext context}) {
    return TextFieldWidgets.getGuiderTextField(
      guiderMessage:
          'कृपया आप वह स्थान दर्ज करें जहाँ पर आप नौकरी करना चाहते हैं या इसे खाली छोड़ दें',
      context: context,
      controller: controller,
      title: 'Preffered Location (Optional)',
    );
  }

  // Highest Qualification Field with validation
  _buildPrefferedSallary(
      {required TextEditingController controller,
      required BuildContext context}) {
    return TextFieldWidgets.getGuiderTextField(
      guiderMessage: 'कृपया अपनी पसंदीदा वेतन दर्ज करें',
      context: context,
      controller: controller,
      title: 'Preffered Sallary (Optional)',
    );
  }

  _buildDropDown(
      {required List<String> items,
      required String selectedValue,
      required Function(String?) onChanged,
      required BuildContext context}) {
    return DropdownWidgets.getDropdown(
        context: context,
        items: items,
        selectedValue: selectedValue,
        onChanged: onChanged);
  }

  // Method to validate form and trigger registration using AuthProvider
  _validateAndRegister(BuildContext context, GlobalKey<FormState> formKey,
      AuthProviderController authProviderController) async {
    if (authProviderController.pickedFile == null) {
      SnackbarUtils.showErrorMsg(
          message: 'Please select profile picture', context: context);
    } else {
      // Validate the form
      if (formKey.currentState?.validate() ?? false) {
        // Form validation passed, now proceed with registration
        authProviderController.register(context: context);

        // If registration is successful, navigate to the next screen
        // Navigator.pushReplacementNamed(
        //     context, AppRoutes.completeProfilePage); // Example route
      }

    }
  }
}
