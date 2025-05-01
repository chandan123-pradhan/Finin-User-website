import 'package:flutter/material.dart';
import 'package:naukri_user/utils/image_utils.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent, // Transparent background
      contentPadding: EdgeInsets.zero, // Remove padding around content
      content: Center(
        child: ImageUtils.getLottie(file: ImageUtils.loadingLottie,
        height: 60,
        width: 60
        )
      ),
    );
   
  }

  
}