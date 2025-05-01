import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/bottom_widget.dart';
import 'package:naukri_user/module/auth/provider/auth_provider_controller.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  String? phoneNumber;
  bool? fromRegister;
  OtpPage({Key? key, required this.phoneNumber, this.fromRegister = false})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  Timer? _timer;
  int _start = 60;

  bool? isMobile;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    _startTimer();
  }

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.of(context).size.width/1;

    isMobile = width < 600;
  }

  void _startTimer() {
    pinController.clear();
    _timer?.cancel();
    setState(() => _start = 60);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() => _start--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return isMobile!? _mobileView() : _webview();
   
   
    
  }

  void _verifyOtp(
      BuildContext context, AuthProviderController authProviderController) {
    if (pinController.text.isNotEmpty) {
      authProviderController.verifyOtp(
        context: context,
        phone: widget.phoneNumber,
        otp: pinController.text,
        fromRegister: widget.fromRegister ?? false,
      );
    }
    _startTimer();
  }



    _mobileView() {
       const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle:
          const TextStyle(fontSize: 22, color: Color.fromRGBO(30, 60, 87, 1)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );

    return 
    
    Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        iconTheme: IconThemeData(size: 16),
        title: Text(
          "OTP Verification",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
      ),
      body: 
      
      
      Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 4.0),
              Text('We\'ve sent a verification code to',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              Text('+91 ${widget.phoneNumber}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 30.0),
              Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: (value) =>
                        (value ?? "").isEmpty ? 'Enter the pin first.' : null,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) => debugPrint('onCompleted: $pin'),
                    onChanged: (value) => debugPrint('onChanged: $value'),
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent)),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Consumer<AuthProviderController>(
                  builder: (context, authProvider, child) {
                return _start > 0
                    ? Text('Resend OTP in $_start seconds.',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey))
                    : TextButton(
                        onPressed: () {
                          authProvider.generateOtp(
                              context: context,
                              phone: widget.phoneNumber,
                              fromOtp: true);
                          _startTimer();
                        },
                        child: Text("Resend OTP",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue)),
                      );
              }),
              Spacer(),
              Consumer<AuthProviderController>(
                builder: (context, authProvider, child) {
                  return BottomWidget.getMainBottom(
                    context: context,
                    title: 'Validate',
                    onPressed: () {
                      focusNode.unfocus();
                      formKey.currentState!.validate();
                      _verifyOtp(context, authProvider);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ));
   
  
  
  }

  _webview() {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle:
          const TextStyle(fontSize: 22, color: Color.fromRGBO(30, 60, 87, 1)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      body: 
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
              child: 
              
               Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 4.0),
              Text('We\'ve sent a verification code to',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              Text('+91 ${widget.phoneNumber}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 30.0),
              Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: (value) =>
                        (value ?? "").isEmpty ? 'Enter the pin first.' : null,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) => debugPrint('onCompleted: $pin'),
                    onChanged: (value) => debugPrint('onChanged: $value'),
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent)),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Consumer<AuthProviderController>(
                  builder: (context, authProvider, child) {
                return _start > 0
                    ? Text('Resend OTP in $_start seconds.',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey))
                    : TextButton(
                        onPressed: () {
                          authProvider.generateOtp(
                              context: context,
                              phone: widget.phoneNumber,
                              fromOtp: true);
                          _startTimer();
                        },
                        child: Text("Resend OTP",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue)),
                      );
              }),
              // Spacer(),
              const SizedBox(height: 30,),
              Consumer<AuthProviderController>(
                builder: (context, authProvider, child) {
                  return BottomWidget.getMainBottom(
                    context: context,
                    title: 'Validate',
                    onPressed: () {
                      focusNode.unfocus();
                      formKey.currentState!.validate();
                      _verifyOtp(context, authProvider);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ))
   
  
           
            ),
          ),
        ),
      
    );
  }


}
