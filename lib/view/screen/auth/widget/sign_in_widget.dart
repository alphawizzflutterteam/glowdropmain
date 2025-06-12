import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/forget_password_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/mobile_verify_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/registerscreen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/sign_in_with_otp.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/sign_up_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/social_login_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/plans/plans_screen.dart';
import 'package:provider/provider.dart';
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

import 'otp_verification_screen.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  SignInWidgetState createState() => SignInWidgetState();
}

class SignInWidgetState extends State<SignInWidget> {
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
  String? otp;
  bool isOtpReceived = false;

  // void loginUser() async {
  //   if (_formKeyLogin!.currentState!.validate()) {
  //     _formKeyLogin!.currentState!.save();
  //
  //     String phone = _phoneController!.text.trim();
  //
  //     if (phone.isEmpty || phone.length != 10) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(getTranslated('input_valid_phone_number', context)!),
  //         backgroundColor: Colors.red,
  //       ));
  //       return;
  //     }
  //
  //     // Send OTP and go to OTP screen
  //     await getOtpFromMobileNumber();
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => EnterOtpScreen(
  //           phone: phone,
  //         ),
  //       ),
  //     );
  //   }
  // }
  bool _isLoading = false;

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

      setState(() {
        _isLoading = true;
      });

      await getOtpFromMobileNumber();

      setState(() {
        _isLoading = false;
      });

      if (isOtpReceived) {
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
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => MobileVerificationScreen(temporaryToken!)),
          //     (route) => false);
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage ?? 'An unknown error occurred'),
        backgroundColor: Colors.red,
      ));
    }
  }

  String countryCode = "+91"; // Default to India
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.marginSizeLarge),
      child: SingleChildScrollView(
        child: Form(
            key: _formKeyLogin,
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width*90/100,
                child: Text(
                  "Let's get started! Enter your details",
                  style: TextStyle(color: ColorResources.primary, fontSize: 16),
                ),
              ),
              SizedBox(height: 20),

              // Phone Input Container
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Country code
                    Text(
                      countryCode,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Divider
                    Container(height: 50, width: 2, color: Colors.grey),
                    const SizedBox(width: 10),
                    // Phone number field - Wrapped with Expanded
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Enter Mobile Number",
                          border: InputBorder.none,

                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter mobile number';
                          }
                          if (value.length != 10) {
                            return 'Mobile number must be 10 digits';
                          }
                          if (!RegExp(r'^[1-9][0-9]{9}$').hasMatch(value)) {
                            return 'Mobile number should not start with 0 and contain only digits';
                          }
                          return null; // valid input
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_passNode);
                        },
                      ),
                    ),

                  ],
                ),
              ),

              // OTP Layout - Outside the Row, as a separate widget
              // isOtpReceived == true
              //     ? otpLayout(
              //
              //       )
              //     : Container(),

              // Sign In Button
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
                        buttonText: getTranslated('SIGN_IN', context)),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpWidget(),
                    ), // Replace with your screen
                  );

                },
                child: Container(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle( color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'SignUp',
                          style: TextStyle(color: ColorResources.primary, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              )

            ])),
      ),
    );
  }

  Widget otpLayout() {
    if (isOtpReceived != true) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsetsDirectional.only(
        start: 50.0,
        end: 50.0,
      ),
      child: Center(
        child: PinFieldAutoFill(
            decoration: UnderlineDecoration(
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
              colorBuilder: FixedColorBuilder(Colors.blue),
            ),
            currentCode: otp,
            codeLength: 4,
            onCodeChanged: (String? code) {
              otp = code;
            },
            onCodeSubmitted: (String code) {
              otp = code;
            }),
      ),
    );
  }

  Future<void> getOtpFromMobileNumber() async {
    try {
      var data = {"phone": _phoneController!.text};
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
}

//
// class EnterOtpScreen extends StatefulWidget {
//   final dynamic phone;
//
//   const EnterOtpScreen({Key? key, required this.phone}) : super(key: key);
//
//   @override
//   State<EnterOtpScreen> createState() => _EnterOtpScreenState();
// }
//
// class _EnterOtpScreenState extends State<EnterOtpScreen> {
//   final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
//   final List<TextEditingController> _controllers = List.generate(
//     6,
//     (_) => TextEditingController(),
//   );
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var node in _focusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }
//
//   Widget _buildOtpBox(int index) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).requestFocus(_focusNodes[index]);
//       },
//       child: Container(
//         width: 50,
//         height: 60,
//         margin: const EdgeInsets.symmetric(horizontal: 7),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade300),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: TextField(
//           controller: _controllers[index],
//           focusNode: _focusNodes[index],
//           keyboardType: TextInputType.number,
//           autofocus: index == 0,
//           maxLength: 1,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           decoration: InputDecoration(
//             counterText: "",
//             border: InputBorder.none,
//           ),
//           onChanged: (value) {
//             if (value.isNotEmpty && index < 4) {
//               _focusNodes[index + 1].requestFocus();
//             } else if (value.isEmpty && index > 0) {
//               _focusNodes[index - 1].requestFocus();
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   LoginWithOtpModel loginBody = LoginWithOtpModel();
//
//   String? otp;
//   bool isOtpReceived = false;
//   GlobalKey<FormState>? _formKeyLogin;
//
//   void loginUser() async {
//     String phone = widget.phone!.text.trim();
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
//       print("objectooooooooo");
//
//       if (otp == null || otp!.length != 4) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Please enter valid otp"),
//           backgroundColor: Colors.red,
//         ));
//       } else {
//         print("object");
//
//         loginBody.phone = phone;
//         loginBody.otp = otp;
//         // loginBody.password = password;
//         await Provider.of<AuthProvider>(context, listen: false)
//             .loginWithOtp(loginBody, route);
//       }
//
//       //  else if (password.isEmpty) {
//       //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //     content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
//       //     backgroundColor: Colors.red,
//       //   ));
//       // }
//       // else {
//       //   // email = email.replaceAll("+91", "");
//
//       // }
//     }
//   }
//
//   route(bool isRoute, String? token, String? temporaryToken,
//       String? errorMessage, bool isPurchase) async {
//     if (isRoute) {
//       if (token == null || token.isEmpty) {
//         if (Provider.of<SplashProvider>(context, listen: false)
//             .configModel!
//             .emailVerification!) {
//           Provider.of<AuthProvider>(context, listen: false)
//               .checkEmail(widget.phone!.text.toString(), temporaryToken!)
//               .then((value) async {
//             if (value.isSuccess) {
//               Provider.of<AuthProvider>(context, listen: false)
//                   .updateEmail(widget.phone.text.toString());
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => VerificationScreen(
//                           temporaryToken, '', widget.phone.text.toString())),
//                   (route) => false);
//             }
//           });
//         } else if (Provider.of<SplashProvider>(context, listen: false)
//             .configModel!
//             .phoneVerification!) {
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => MobileVerificationScreen(temporaryToken!)),
//               (route) => false);
//         }
//       } else {
//         if (isPurchase) {
//           await Provider.of<ProfileProvider>(context, listen: false)
//               .getUserInfo(context);
//           if (context.mounted) {}
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (_) => const DashBoardScreen()),
//               (route) => false);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text("Please Purchase plan"),
//               backgroundColor: Colors.red));
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (_) => PlansScreen()),
//               (route) => false);
//         }
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(errorMessage ?? 'An unknown error occurred'),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _formKeyLogin = GlobalKey<FormState>();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: BackgroundContainer(
//         // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//         child: Form(
//           key: _formKeyLogin,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   // color: Colors.red,
//                   width: MediaQuery.of(context).size.width * 90 / 100,
//                   child: Text(
//                     "Enter 6-digit OTP sent to +919513654780",
//                     style: TextStyle(
//                       color: ColorResources.primary,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(4, (index) => _buildOtpBox(index)),
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Didn’t receive the code?  Resend",
//                         style: TextStyle(
//                           color: ColorResources.textcolor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 2), // Adjust this height as needed
//                       Container(
//                         height: 2,
//                         color: ColorResources.textcolor,
//                         width: 260,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 10),
//               Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width * 90 / 100,
//                       child: Text(
//                         "Get OTP on call",
//                         style: TextStyle(
//                           color: ColorResources.textcolor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 4), // Small spacing between text and line
//                     Container(
//                         height: 2, color: ColorResources.textcolor, width: 150),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 20),
//               CustomButton(
//                   onTap: loginUser,
//                   buttonText: getTranslated('SIGN_IN', context)),
//               // Center(
//               //   child: CustomButton(
//               //     text: "Sign Up",
//               //     onPressed: () {
//               //       Navigator.pushReplacement(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => VarifiedScreen(),
//               //         ), // Replace with your screen
//               //       );
//               //       // Add your navigation or logic here
//               //     },
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
