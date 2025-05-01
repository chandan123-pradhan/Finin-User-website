import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/bottom_widget.dart';
import 'package:naukri_user/common_widgets/confirmation_poup.dart';
import 'package:naukri_user/common_widgets/text_field_widgets.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/module/alerts/providers/alert_provider.dart';
import 'package:naukri_user/module/auth/provider/auth_provider_controller.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart'; // Import Provider package

class CreateAlertPage extends StatelessWidget {
  const CreateAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    // Create TextEditingControllers for email and password

    // GlobalKey for Form validation
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: ColorUtils.lightGray,
      appBar: AppBar(
        backgroundColor: ColorUtils.lightGray,
        elevation: 0,
        centerTitle: true,
        title: headingH4(context: context, text: 'Create Alert'),
      ),
      body: Consumer<AlertProvider>(builder: (context, alertProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildEmailField(context, alertProvider.jobTitleController),
                  const SizedBox(height: 40),
                  _buildPasswordField(
                      context, alertProvider.locationController),
                  const SizedBox(height: 40),
                  _buildDescriptionTextField(
                      context, alertProvider.descriptionController),
                  const SizedBox(height: 60),
                  BottomWidget.getMainBottom(
                      context: context,
                      title: 'Submit',
                      onPressed: () {
                        _validateAndCreateAlert(
                            context, _formKey, alertProvider);
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _showConfirmationPopup(context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AlertCreateConfirmationPopup();
        });
  }

  _buildEmailField(BuildContext context, TextEditingController controller) {
    return TextFieldWidgets.getTextField(
      context: context,
      controller: controller,
      title: 'Job title',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  _buildPasswordField(BuildContext context, TextEditingController controller) {
    return TextFieldWidgets.getTextField(
      context: context,
      controller: controller,
      title: 'Location',
      obscureText: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter location';
        }
        return null;
      },
    );
  }

  _buildDescriptionTextField(
      BuildContext context, TextEditingController controller) {
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

  _buildSkill(BuildContext context, TextEditingController controller) {
    return TextFieldWidgets.getTextField(
      context: context,
      controller: controller,
      title: 'Skills',
      obscureText: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter skills';
        }
        return null;
      },
    );
  }

  _validateAndCreateAlert(BuildContext context, GlobalKey<FormState> formKey,
      AlertProvider alertProvider) async {
    if (formKey.currentState?.validate() ?? false) {
      bool result = await alertProvider.createAlert(context);
      if (result) {
        _showConfirmationPopup(context);
      }
    }
  }
}
