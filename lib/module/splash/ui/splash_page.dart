import 'package:flutter/material.dart';
import 'package:naukri_user/module/splash/provider/splash_provider_controller.dart';
import 'package:provider/provider.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:naukri_user/utils/string_utils.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = displayHeight(context);
    final double width = displayWeight(context);

    // Start splash screen logic by calling the startSplash method
    Provider.of<SplashProviderController>(context, listen: false).startSplash(context);
    
    return Consumer<SplashProviderController>(
      builder: (context, notifier, child) {
       
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header with Naukri Title
              _buildHeader(height, context),

              // Logo Image
              _buildLogo(height, width),

              // Tagline or description text
              _buildTagline(height, context),
            ],
          ),
        );
      },
    );
  }

  // Header Section
  Widget _buildHeader(double height, context) {
    return Container(
      height: height / 4,
      alignment: Alignment.center,
      child: headingH1(
        text: StringUtils.NaukriTitle,
        context: context,
      ),
    );
  }

  // Logo Section
  Widget _buildLogo(double height, double width) {
    return Container(
      height: height / 3,
      alignment: Alignment.center,
      child: ImageUtils.getImage(
        image: ImageUtils.AppLogoImage,
        height: height / 3,
        width: width / 2.5,
      ),
    );
  }

  // Tagline Section
  Widget _buildTagline(double height, context) {
    return Container(
      height: height / 4,
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: headingH3(
          text: StringUtils.GetJobInMin,
          context: context,
        ),
      ),
    );
  }
}
