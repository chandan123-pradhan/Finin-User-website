import 'package:flutter/material.dart';
import 'package:naukri_user/module/alerts/ui/create_alert_page.dart';
import 'package:naukri_user/module/auth/ui/complete_profile.dart';
import 'package:naukri_user/module/auth/ui/login_page.dart';
import 'package:naukri_user/module/auth/ui/phone_verification_page.dart';
import 'package:naukri_user/module/auth/ui/register_page.dart';
import 'package:naukri_user/module/home/ui/find_job.dart';
import 'package:naukri_user/module/home/ui/home_page.dart';
import 'package:naukri_user/module/job_details/ui/job_details_page.dart';
import 'package:naukri_user/module/profile_details/ui/profile_detail_page.dart';
import 'package:naukri_user/module/splash/ui/splash_page.dart';
import 'package:naukri_user/module/dashboard/ui/dashboard_page.dart'; // Example home page

class AppRoutes {
  static const String splashPage = '/';
  static const String loginPage = '/login';
  static const String regisePage = '/register_page';
  static const String completeProfilePage = '/complete_profile_page';
  static const String dashboardPage = '/dashboard';
  static const String jobDetailsPage = '/job_details';
  static const String finJobsPage = '/find_jobs';
  static const String createAlert = '/create_alert';
  static const String phoneVerificationPage = '/phone_verification_page';
  static const String profileDetailPage = '/profile_detail_page';
  static const String homePage='/home';


  static Map<String, WidgetBuilder> get routes {
    return {
      splashPage: (context) => const SplashPage(),
      loginPage: (context) => const LoginPage(),
      regisePage: (context) => const SignupPage(),
      completeProfilePage: (context) => const CompleteProfilePage(),
      dashboardPage: (context) => const DashboardPage(),
      // Route for JobDetailsPage (Without parameters)
      finJobsPage: (context) => const FindJobPage(),
      createAlert: (context) => const CreateAlertPage(),
      phoneVerificationPage: (context) =>  PhoneVerificationPage(),
      profileDetailPage: (context) => const ProfileDetailPage(),
      homePage:(context)=>const HomePage()
    };
  }

  // Updated function to handle passing jobId as parameter
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case jobDetailsPage:
        final String jobId = settings.arguments as String; // Extract jobId from arguments
        return MaterialPageRoute(
          builder: (context) => JobDetailsPage(jobId: jobId),  // Pass the jobId to the JobDetailsPage
        );
      // Add other routes here...
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
