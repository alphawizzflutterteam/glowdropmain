import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/login_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/forget_password_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/mobile_verify_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/social_login_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/plans/plans_screen.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../background_screen.dart';
import 'otp_verification_screen.dart';

class SignInWithOTPWidget extends StatefulWidget {
  const SignInWithOTPWidget({Key? key}) : super(key: key);

  @override
  SignInWithOTPWidgetState createState() => SignInWithOTPWidgetState();
}

class SignInWithOTPWidgetState extends State<SignInWithOTPWidget> {
  TextEditingController? _phoneController;
  //TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _phoneController = TextEditingController();
    // _passwordController = TextEditingController();
    _phoneController!.text =
        (Provider.of<AuthProvider>(context, listen: false).getUserEmail());
    // _passwordController!.text =
    //     (Provider.of<AuthProvider>(context, listen: false).getUserPassword());
  }

  @override
  void dispose() {
    _phoneController!.dispose();
    // _passwordController!.dispose();
    super.dispose();
  }

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();
  LoginWithOtpModel loginBody = LoginWithOtpModel();

  // void loginUser() async {
  //   if (_formKeyLogin!.currentState!.validate()) {
  //     _formKeyLogin!.currentState!.save();
  //
  //     String phone = _phoneController!.text.trim();
  //
  //     // String password = _passwordController!.text.trim();
  //
  //     if (phone.isEmpty || phone.length != 10) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(getTranslated('input_valid_phone_number', context)!),
  //         backgroundColor: Colors.red,
  //       ));
  //     }
  //
  //     if (isOtpReceived == true) {
  //       if (otp == null || otp!.length != 4) {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text("Please enter valid otp"),
  //           backgroundColor: Colors.red,
  //         ));
  //       } else {
  //         loginBody.phone = phone;
  //         loginBody.otp = otp;
  //         // loginBody.password = password;
  //         await Provider.of<AuthProvider>(context, listen: false)
  //             .loginWithOtp(loginBody, route);
  //       }
  //     } else {
  //       getOtpFromMobileNumber();
  //     }
  //     //  else if (password.isEmpty) {
  //     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     //     content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
  //     //     backgroundColor: Colors.red,
  //     //   ));
  //     // }
  //     // else {
  //     //   // email = email.replaceAll("+91", "");
  //
  //     // }
  //   }
  // }
  void loginUser() async {
    if (_formKeyLogin!.currentState!.validate()) {
      _formKeyLogin!.currentState!.save();

      String phone = _phoneController!.text.trim();

      if (phone.isEmpty || phone.length != 10) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('input_valid_phone_number', context)!),
          backgroundColor: Colors.red,
        ));
        return;
      }

      // Send OTP and go to OTP screen
      await getOtpFromMobileNumber();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EnterOtpScreen(
            phone: phone,
          ),
        ),
      );
    }
  }

  route(bool isRoute, String? token, String? temporaryToken,
      String? errorMessage, bool isPurchase) async {
    if (isRoute) {
      if (token == null || token.isEmpty) {
        if (Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .emailVerification!) {
          Provider.of<AuthProvider>(context, listen: false)
              .checkEmail(_phoneController!.text.toString(), temporaryToken!)
              .then((value) async {
            if (value.isSuccess) {
              Provider.of<AuthProvider>(context, listen: false)
                  .updateEmail(_phoneController!.text.toString());
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => VerificationScreen(temporaryToken, '',
                          _phoneController!.text.toString())),
                  (route) => false);
            }
          });
        } else if (Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .phoneVerification!) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => MobileVerificationScreen(temporaryToken!)),
              (route) => false);
        }
      } else {
        if (isPurchase) {
          await Provider.of<ProfileProvider>(context, listen: false)
              .getUserInfo(context);
          if (context.mounted) {}
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashBoardScreen()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please Purchase plan"),
              backgroundColor: Colors.red));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => PlansScreen()),
              (route) => false);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.marginSizeLarge),
      child: Form(
        key: _formKeyLogin,
        child: ListView(
          padding:
              const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: Dimensions.marginSizeSmall),
              child: TextFormField(
                controller: _phoneController,
                focusNode: _emailNode,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText:
                      getTranslated('ENTER_YOUR_EMAIL_or_mobile', context),
                  prefixIcon: const Icon(Icons.email_outlined),
                  isDense: true, // Reduces height
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  counterText: "",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your mobile number";
                  } else if (value.length < 10) {
                    return "Mobile number must be 10 digits";
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passNode);
                },
              ),
            ),

            // isOtpReceived == true ? otpLayout() : Container(),

            Container(
              margin: const EdgeInsets.only(right: Dimensions.marginSizeSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) => Checkbox(
                          checkColor: ColorResources.white,
                          activeColor: Theme.of(context).primaryColor,
                          value: authProvider.isRemember,
                          onChanged: authProvider.updateRemember,
                        ),
                      ),
                      Text(getTranslated('REMEMBER', context)!,
                          style: titilliumRegular),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 30),
              child: Provider.of<AuthProvider>(context).isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : CustomButton(
                      onTap: loginUser,
                      buttonText: isOtpReceived == true
                          ? getTranslated('SIGN_IN', context)
                          : getTranslated('send_otp', context)),
            ),
          ],
        ),
      ),
    );
  }

  String? otp;
  bool isOtpReceived = false;

  // Widget otpLayout() {
  //   if (isOtpReceived != true) {
  //     return Container();
  //   }
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 15),
  //     padding: EdgeInsetsDirectional.only(
  //       start: 50.0,
  //       end: 50.0,
  //     ),
  //     child: Center(
  //       child: PinFieldAutoFill(
  //           decoration: UnderlineDecoration(
  //             textStyle: TextStyle(fontSize: 20, color: Colors.black),
  //             colorBuilder: FixedColorBuilder(Colors.blue),
  //           ),
  //           currentCode: otp,
  //           codeLength: 4,
  //           onCodeChanged: (String? code) {
  //             otp = code;
  //           },
  //           onCodeSubmitted: (String code) {
  //             otp = code;
  //           }),
  //     ),
  //   );
  // }

  Future<void> getOtpFromMobileNumber() async {
    try {
      var data = {"phone": _phoneController!.text};
      Response response = await post(
        Uri.parse(
            "https://townway.alphawizzserver.com/api/v1/auth/check-phone"),
        body: data,
      ).timeout(
        Duration(seconds: 10),
      );

      print("jahsgahgs ${data.toString()}");
      var getdata = json.decode(response.body);
      bool? error = getdata["error"];
      String? msg = getdata["message"];

      print(getdata);

      // if(widget.checkForgot == "false"){

      if (msg!.contains('Successfully')) {
        String otp = getdata['otp'].toString();
        // setSnackbar(otp.toString());
        // Fluttertoast.showToast(msg: otp.toString(),
        //     backgroundColor: colors.primary
        // );
        print("OTP : " + otp);
        setState(() {
          isOtpReceived = true;
        });
        showCustomSnackBar(msg!, context);
        // settingsProvider.setPrefrence(MOBILE, mobile!);
        // settingsProvider.setPrefrence(COUNTRY_CODE, countrycode!);
      } else {
        showCustomSnackBar(msg!, context);
      }
    } on TimeoutException catch (_) {
      showCustomSnackBar("Something went wrong", context);
    }
  }
}

class EnterOtpScreen extends StatefulWidget {
  final String phone;

  const EnterOtpScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String getOtp() {
    return _controllers.map((controller) => controller.text).join();
  }

  void verifyOtp() async {
    final otp = getOtp();
    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid 4-digit OTP"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final loginBody = LoginWithOtpModel(
      phone: widget.phone,
      otp: otp,
    );

    await Provider.of<AuthProvider>(context, listen: false)
        .loginWithOtp(loginBody, route);
  }

  void route(bool isRoute, String? token, String? temporaryToken,
      String? errorMessage, bool isPurchase) {
    if (isRoute) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashBoardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? "OTP Verification failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildOtpBox(int index) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNodes[index]);
      },
      child: Container(
        width: 50,
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          autofocus: index == 0,
          maxLength: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else if (value.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          },
        ),
      ),
    );
  }

  void loginUser() async {
    String phone = widget.phone;

    if (phone.isEmpty || phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getTranslated('input_valid_phone_number', context)!),
        backgroundColor: Colors.red,
      ));
      return;
    }

    // Send OTP and go to OTP screen
    await getOtpFromMobileNumber();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => EnterOtpScreen(
          phone: phone,
        ),
      ),
    );
  }

  bool isOtpReceived = false;

  Future<void> getOtpFromMobileNumber() async {
    try {
      var data = {"phone": widget.phone};
      Response response = await post(
        Uri.parse(
            "https://glow-drop.developmentalphawizz.com/api/v1/auth/check-phone"),
        body: data,
      ).timeout(
        Duration(seconds: 10),
      );

      print("jahsgahgs ${data.toString()}");
      var getdata = json.decode(response.body);
      bool? error = getdata["error"];
      String? msg = getdata["message"];

      print(getdata);

      // if(widget.checkForgot == "false"){
      if (msg!.contains('Successfully')) {
        String otpFromServer = getdata['otp'].toString(); // For debug/log
        print("OTP : $otpFromServer");

        // Show success message
        showCustomSnackBar(msg, context);

        // ✅ Navigate to OTP screen, passing phone number if needed
        setState(() {
          isOtpReceived = true;
        });
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => EnterOtpScreen(
        //       phone: _phoneController,
        //       // phoneNumber: _phoneController!.text,
        //     ),
        //   ),
        // );
      }
      // if (msg!.contains('Successfully')) {
      //   String otp = getdata['otp'].toString();
      //   // setSnackbar(otp.toString());
      //   // Fluttertoast.showToast(msg: otp.toString(),
      //   //     backgroundColor: colors.primary
      //   // );
      //   print("OTP : " + otp);
      //   setState(() {
      //     isOtpReceived = true;
      //   });
      //   showCustomSnackBar(msg!, context);
      //   // settingsProvider.setPrefrence(MOBILE, mobile!);
      //   // settingsProvider.setPrefrence(COUNTRY_CODE, countrycode!);
      // }
      else {
        showCustomSnackBar(msg!, context);
      }
    } on TimeoutException catch (_) {
      showCustomSnackBar("Something went wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 40),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "Enter 4-digit OTP sent to ${widget.phone}",
                  style: TextStyle(
                    color: ColorResources.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => _buildOtpBox(index)),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: loginUser,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Didn’t receive the code?  Resend",
                        style: TextStyle(
                          color: ColorResources.textcolor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        height: 2,
                        color: ColorResources.textcolor,
                        width: 260,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      "Get OTP on call",
                      style: TextStyle(
                        color: ColorResources.textcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                      height: 2, color: ColorResources.textcolor, width: 150),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomButton(
                onTap: verifyOtp,
                buttonText: 'Verify OTP',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
