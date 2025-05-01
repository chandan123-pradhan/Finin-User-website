import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/bottom_widget.dart';
import 'package:naukri_user/common_widgets/text_field_widgets.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart';
import 'package:naukri_user/module/auth/provider/auth_provider_controller.dart';

class PhoneVerificationPage extends StatefulWidget {
  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  bool? isMobile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.of(context).size.width/1;

    isMobile = width < 600;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _opacityAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isMobile!? _mobileView() : _webview()
      
    );
  }

  void _generateOtp(
      BuildContext context, AuthProviderController authProviderController) {
    if (_formKey.currentState?.validate() ?? false) {
      authProviderController.generateOtp(
        context: context,
        phone: _phoneController.text,
      );
    }
    _phoneController.clear();
  }

  Widget _buildPhoneField(BuildContext context) {
    return TextFieldWidgets.getTextField(
      context: context,
      controller: _phoneController,
      onCompleteEditing: () {},
      title: 'Enter phone number',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
      inputType: TextInputType.number,
    );
  }

  _googleButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png",
                height: 25,
                width: 25,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Continue with Google",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _mobileView() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1535957998253-26ae1ef29506?q=80&w=3136&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height / 2.7,
                  width: MediaQuery.of(context).size.width / 1,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      child: Icon(Icons.keyboard_arrow_left),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Consumer<AuthProviderController>(
                    builder: (context, authProvider, child) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20),
                            ImageUtils.getImage(
                              image: ImageUtils.AppLogoImage,
                              height: 60,
                              width: 60,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Your trust, our commitment.",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Log in or sign up",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 25),
                            _buildPhoneField(context),
                            SizedBox(height: 10.0),
                            Consumer<AuthProviderController>(
                              builder: (context, authProvider, child) {
                                return BottomWidget.getMainBottom(
                                  context: context,
                                  title: 'Login',
                                  onPressed: () =>
                                      _generateOtp(context, authProvider),
                                );
                              },
                            ),
                            SizedBox(height: 15),
                            Text(
                              "OR",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 15),
                            _googleButton(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _webview() {
    return Scaffold(
      body: Container(
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
                child: Column(
                  children: [
                    Center(
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Consumer<AuthProviderController>(
                            builder: (context, authProvider, child) {
                              return Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 20),
                                    ImageUtils.getImage(
                                      image: ImageUtils.AppLogoImage,
                                      height: 60,
                                      width: 60,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Your trust, our commitment.",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Log in or sign up",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                    _buildPhoneField(context),
                                    SizedBox(height: 10.0),
                                    Consumer<AuthProviderController>(
                                      builder: (context, authProvider, child) {
                                        return BottomWidget.getMainBottom(
                                          context: context,
                                          title: 'Login',
                                          onPressed: () =>
                                              _generateOtp(context, authProvider),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      "OR",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    _googleButton(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



}
