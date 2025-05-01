import 'package:flutter/material.dart';
import 'package:naukri_user/module/alerts/providers/alert_provider.dart';
import 'package:naukri_user/module/auth/provider/auth_provider_controller.dart';
import 'package:naukri_user/module/auth/ui/complete_profile.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/module/home/provider/home_provider.dart';
import 'package:naukri_user/module/splash/provider/splash_provider_controller.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:provider/provider.dart'; // Import the provider package

void main() {
  runApp(
    // Wrap the entire app in ChangeNotifierProvider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProviderController()),
        ChangeNotifierProvider(create: (context) => AuthProviderController()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
         ChangeNotifierProvider(create: (context) => AlertProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Naukri App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splashPage,
      onGenerateRoute:
          AppRoutes.generateRoute, // Use generateRoute for dynamic routing
      routes: AppRoutes.routes,
    );
  }
}
