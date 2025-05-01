import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/bottom_widget.dart';
import 'package:naukri_user/common_widgets/text_field_widgets.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/module/auth/provider/auth_provider_controller.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus
              ?.unfocus(), // Dismiss keyboard on tap
          child: LayoutBuilder(builder: (context, c) {
            double width = displayWeight(context);

            return width < 600 ? _mobileView() : _webView();
          }),
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email"),
        SizedBox(
          height: 10.0,
        ),
        TextFieldWidgets.getTextField(
          context: context,
          controller: _emailController,
          onCompleteEditing: () {},
          title: 'Enter email ID',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                .hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Password"),
        SizedBox(
          height: 10.0,
        ),
        TextFieldWidgets.getTextField(
          context: context,
          controller: _passwordController,
          title: 'Password',
          onCompleteEditing: () {},
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _validateAndLogin(AuthProviderController authProvider) {
    if (_formKey.currentState?.validate() ?? false) {
      authProvider.login(
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
    }
  }

  _mobileView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              headingH4(
                text: 'Unlock Your Dream Job',
                context: context,
              ),
              const SizedBox(height: 8),
              headingH10(
                text:
                    'Sign in to connect with top employers and opportunities!',
                context: context,
              ),
              const SizedBox(height: 50),
              _buildEmailField(context),
              const SizedBox(height: 30),
              _buildPasswordField(context),
              const SizedBox(height: 10),
              Container(
                width: displayWeight(context) / 1,
                alignment: Alignment.centerRight,
                child: headingH10(
                  text: 'Forgot password',
                  context: context,
                  isHyperLink: true,
                ),
              ),
              const SizedBox(height: 50),
              Consumer<AuthProviderController>(
                builder: (context, authProvider, child) {
                  return BottomWidget.getMainBottom(
                    context: context,
                    title: 'Login',
                    onPressed: () => _validateAndLogin(authProvider),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  headingH10(context: context, text: "Don't have an account? "),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.regisePage),
                    child: headingH10(
                      context: context,
                      text: " Register for free",
                      color: ColorUtils.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.phoneVerificationPage);
                },
                child: Container(
                  width: displayWeight(context) / 1,
                  alignment: Alignment.center,
                  child: headingH10(
                    text: 'Login with phone number.',
                    context: context,
                    isHyperLink: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _webView() {
    return 
    
    Container(
      height: displayHeight(context),
      width: displayWeight(context),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageUtils.authBgImage), fit: BoxFit.fill)),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      headingH4(
                        text: 'Unlock Your Dream Job',
                        context: context,
                      ),
                      const SizedBox(height: 8),
                      headingH10(
                        text:
                            'Sign in to connect with top employers and opportunities!',
                        context: context,
                      ),
                      const SizedBox(height: 40),
                      _buildEmailField(context),
                      const SizedBox(height: 24),
                      _buildPasswordField(context),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: headingH10(
                          text: 'Forgot password',
                          context: context,
                          isHyperLink: true,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Consumer<AuthProviderController>(
                        builder: (context, authProvider, child) {
                          return BottomWidget.getMainBottom(
                            context: context,
                            title: 'Login',
                            onPressed: () => _validateAndLogin(authProvider),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          headingH10(
                              context: context,
                              text: "Don't have an account? "),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.regisePage),
                            child: headingH10(
                              context: context,
                              text: " Register for free",
                              color: ColorUtils.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.phoneVerificationPage);
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: headingH10(
                            text: 'Login with phone number.',
                            context: context,
                            isHyperLink: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
