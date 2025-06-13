import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/register_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/refer_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/restricted_zip_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/email_checker.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/location_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/social_login_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/plans/plans_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../more/widget/html_view_screen.dart';
import 'categoryscreen.dart';
import 'code_picker_widget.dart';
import 'otp_verification_screen.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  SignUpWidgetState createState() => SignUpWidgetState();
}

class SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referNameController = TextEditingController();
  final TextEditingController _referalcodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  GlobalKey<FormState>? _formKey;

  double? lat;
  double? long;
  String? state;
  String? city;
  String? area;
  String? pincode;

  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _referalFocus = FocusNode();
  final FocusNode _zipNode = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  RegisterModel register = RegisterModel();
  bool isEmailVerified = false;

  ReferModel? _referModel;

  bool isLoading = false;
  Future<void> getRerferData() async {
    isLoading = true;
    setState(() {});

    final uri =
        Uri.parse('${AppConstants.baseUrl}/api/v1/auth/get_user_by_referral');
    final request = http.MultipartRequest('POST', uri);
    var userid = Provider.of<AuthProvider>(context, listen: false).getAuthID();
    // Add other fields to the request if needed
    request.fields['code'] = '${_referalcodeController.text}';
    final response = await request.send();
    print("object AAAArequest ${request.fields}");
    print("object AAAArequest ${request.url}");
    // print("object AAAArequest ${response.}");

    final responseData = await http.Response.fromStream(response);
    Map<String, dynamic> responseMap = json.decode(responseData.body);
    print('Response Map: $responseMap');
    isLoading = false;
    setState(() {});
    // Fluttertoast.showToast(msg: responseMap['message']);
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      if (responseMap['status'] == true) {
        _referModel = ReferModel.fromJson(responseMap);
        print('ghjgjhfgjh${_referModel?.data.name}');
        _referNameController.text = _referModel?.data.name ?? '';
        // fundList = (responseMap['data'] as List)
        //     .map((e) => FundTransactionData.fromJson(e))
        //     .toList();
        // Navigator.pop(context);

        setState(() {});
      }
    } else {
      print('Image upload failed');
    }
  }

  addUser() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      isEmailVerified = true;

      String firstName = _firstNameController.text.trim();
      String lastName = _lastNameController.text.trim();
      String location = _locationController.text.trim();
      // String referal = _referalcodeController.text.trim();
      String zipcode = _zipCodeController.text.trim();
      String Dob = dobController.text.trim();
      String phone = _phoneController.text.trim();
      // String phoneNumber = _countryDialCode! + _phoneController.text.trim();
      String phoneNumber = _phoneController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();
      String city = _cityController.text.trim();
      String state = _stateController.text.trim();

      if (firstName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(getTranslated('first_name_field_is_required', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (lastName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('last_name_field_is_required', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (location.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      }
      // else if (EmailChecker.isNotValid(Dob)) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(getTranslated('enter_valid_email_address', context)!),
      //     backgroundColor: Colors.red,
      //   ));
      // }
      // else if (phone.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
      //     backgroundColor: Colors.red,
      //   ));
      // }
      // else if (phone.length != 10) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('Please enter a valid mobile no.'),
      //     backgroundColor: Colors.red,
      //   ));
      // }
      // else if (password.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
      //     backgroundColor: Colors.red,
      //   ));
      // }

      //  else if (zipcode.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content:
      //         Text(getTranslated('ZIPCODE_FIELD_MUST_BE_REQUIRED', context)!),
      //     backgroundColor: Colors.red,
      //   ));
      // }

      // else if (confirmPassword.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(
      //         getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)!),
      //     backgroundColor: Colors.red,
      //   ));
      // } else if (password != confirmPassword) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
      //     backgroundColor: Colors.red,
      //   ));
      // }
      // else if (referal.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //       "Referral Code Is Required",
      //       // getTranslated('PASSWORD_DID_NOT_MATCH', context)!
      //     ),
      //     backgroundColor: Colors.red,
      //   ));
      // }
      else {
        print(_longitude);
        register.fName = _firstNameController.text;
        register.lName = _lastNameController.text;
        register.email = _emailController.text;
        register.Dob = dobController.text;
        register.gender = gender;
        register.longitute = _longitude;
        register.latitute = _latitude;
        // register.friend_code = referal;
        register.phone = phoneNumber;
        register.password = _passwordController.text;
        register.zipcode = _zipCodeController.text;
        register.city = _cityController.text;
        register.state = _stateController.text;
        register.address = _addressController.text;
        register.lat = _latController.text;
        register.long = _longController.text;
        register.area = _areaController.text;
        await Provider.of<AuthProvider>(context, listen: false).registration(
          register,
          route,
        );
      }
    } else {
      isEmailVerified = false;
    }
  }

  route(
    bool isRoute,
    String? token,
    String? tempToken,
    String? errorMessage,
  ) async {
    String phone = _countryDialCode! + _phoneController.text.trim();
    if (isRoute) {
      if (Provider.of<SplashProvider>(context, listen: false)
          .configModel!
          .emailVerification!) {
        Provider.of<AuthProvider>(context, listen: false)
            .checkEmail(_emailController.text.toString(), tempToken!)
            .then((value) async {
          if (value.isSuccess) {
            Provider.of<AuthProvider>(context, listen: false)
                .updateEmail(_emailController.text.toString());
            print("verify otp-----------2");

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => VerificationScreen(
                          tempToken,
                          '',
                          _emailController.text.toString(),
                        )),
                (route) => false);
          }
        });
      } else if (Provider.of<SplashProvider>(context, listen: false)
          .configModel!
          .phoneVerification!) {
        Provider.of<AuthProvider>(context, listen: false)
            .checkPhone(phone, tempToken!)
            .then((value) async {
          if (value.isSuccess) {
            print("verify otp-----------");

            Provider.of<AuthProvider>(context, listen: false)
                .updatePhone(phone);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => VerificationScreen(
                          tempToken,
                          phone,
                          '',
                          otp: value.otp.toString(),
                        )),
                (route) => false);
          }
        });
      } else {
        await Provider.of<ProfileProvider>(context, listen: false)
            .getUserInfo(context);
        if (context.mounted) {}
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => PlansScreen(
        //               type: 1,
        //             )),
        //     (route) => false);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashBoardScreen()),
            (route) => false);
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
        _emailController.clear();
        _referalcodeController.clear();
        _passwordController.clear();
        _firstNameController.clear();
        _lastNameController.clear();
        _phoneController.clear();
        _confirmPasswordController.clear();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red));
    }
  }

  String? _countryDialCode = "+880";
  @override
  void initState() {
    super.initState();
    Provider.of<SplashProvider>(context, listen: false).configModel;
    _countryDialCode = CountryCode.fromCountryCode(
            Provider.of<SplashProvider>(context, listen: false)
                .configModel!
                .countryCode!)
        .dialCode;

    initUI();
    _formKey = GlobalKey<FormState>();
  }

  Future<void> initUI() async {
    await Provider.of<LocationProvider>(context, listen: false)
        .getRestrictedZipCode(context);
  }

//
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  String _currentAddress = 'Tap to get current location';
  dynamic? _latitude;
  dynamic? _longitude;

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _latitude = position.latitude;
      _longitude = position.longitude;

      print('Latitude: $_latitude, Longitude: $_longitude');

      List<Placemark> placemarks =
          await placemarkFromCoordinates(_latitude!, _longitude!);
      Placemark place = placemarks[0];

      String address =
          "${place.locality}, ${place.administrativeArea}, ${place.country}";

      setState(() {
        _currentAddress = address;
        _locationController.text =
            address; // Update the TextField with the address
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child:
                Image.asset("assets/images/background.png", fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/images/userdetails.png",
                      width: MediaQuery.of(context).size.width * 0.8,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [],
                    ),
                    const Text(
                      "First Name",
                      style: TextStyle(
                        color: ColorResources.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          hintText: "Enter your full name",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    const Text(
                      "Last Name",
                      style: TextStyle(
                        color: ColorResources.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          hintText: "Enter your full name",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        color: ColorResources.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: "Enter your Email",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        color: ColorResources.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          hintText: "Enter your Phone Number",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Gender",
                      style: TextStyle(
                        color: ColorResources.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildGenderOption("Female"),
                        const SizedBox(width: 16),
                        _buildGenderOption("Male"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Date of Birth",
                      style: TextStyle(
                        color: ColorResources.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: dobController,
                        readOnly: true,
                        onTap: _selectDate,
                        textAlignVertical:
                            TextAlignVertical.center, // Center vertically
                        decoration: InputDecoration(
                          hintText: "07 May 2025",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 2,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                              color: ColorResources.primary,
                            ),
                            onPressed: _selectDate,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Address",
                      style: TextStyle(
                        color: ColorResources.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _locationController,
                        readOnly: true,
                        onTap: _getCurrentLocation,
                        textAlignVertical:
                            TextAlignVertical.center, // Center vertically
                        decoration: InputDecoration(
                          hintText: "VijayNagar, Indore,Madhya Pradesh",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 2,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.location_on_outlined,
                              color: ColorResources.primary,
                            ),
                            onPressed: _getCurrentLocation,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      // Fixed width
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorResources.white,
                          side: BorderSide(
                            width: 2.0,
                            color: ColorResources.primary,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Skip",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: ColorResources.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          // left: Dimensions.marginSizeLarge,
                          // right: Dimensions.marginSizeLarge,
                          bottom: Dimensions.marginSizeLarge,
                          top: Dimensions.marginSizeLarge),
                      child: Provider.of<AuthProvider>(context).isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          : CustomButton(
                              radius: 30,
                              onTap: addUser,
                              buttonText: getTranslated('SIGN_UP', context)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String gender = 'Male';

  Widget _buildGenderOption(String label) {
    bool isSelected = gender == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = label;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 40 / 100,
        height: MediaQuery.of(context).size.height * 5 / 100,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorResources.primary
              : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorResources.primary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : ColorResources.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.check, color: Colors.white, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}

//   Widget build(BuildContext context) {
//     return ListView(
//       padding:
//           const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
//       children: [
//         Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // for first and last name
//               Container(
//                 margin: const EdgeInsets.only(
//                     left: Dimensions.marginSizeDefault,
//                     right: Dimensions.marginSizeDefault),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: CustomTextField(
//                       hintText: getTranslated('FIRST_NAME', context),
//                       textInputType: TextInputType.name,
//                       focusNode: _fNameFocus,
//                       nextNode: _lNameFocus,
//                       isPhoneNumber: false,
//                       prefixIcon: const Icon(Icons.person_outline_rounded),
//                       capitalization: TextCapitalization.words,
//                       controller: _firstNameController,
//                     )),
//                     const SizedBox(width: Dimensions.paddingSizeDefault),
//                     Expanded(
//                         child: CustomTextField(
//                       hintText: getTranslated('LAST_NAME', context),
//                       focusNode: _lNameFocus,
//                       nextNode: _emailFocus,
//                       prefixIcon: const Icon(Icons.person_outline_rounded),
//                       capitalization: TextCapitalization.words,
//                       controller: _lastNameController,
//                     )),
//                   ],
//                 ),
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(
//                     left: Dimensions.marginSizeDefault,
//                     right: Dimensions.marginSizeDefault,
//                     top: Dimensions.marginSizeSmall),
//                 child: CustomTextField(
//                   hintText: getTranslated('ENTER_YOUR_EMAIL', context),
//                   prefixIcon: const Icon(Icons.email_outlined),
//                   focusNode: _emailFocus,
//                   nextNode: _phoneFocus,
//                   textInputType: TextInputType.emailAddress,
//                   controller: _emailController,
//                 ),
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(
//                     left: Dimensions.marginSizeDefault,
//                     right: Dimensions.marginSizeDefault,
//                     top: Dimensions.marginSizeSmall),
//                 child: Row(children: [
//                   IgnorePointer(
//                     child: CodePickerWidget(
//                       onChanged: (CountryCode countryCode) {
//                         _countryDialCode = countryCode.dialCode;
//                       },
//                       initialSelection: _countryDialCode,
//                       favorite: [_countryDialCode!],
//                       showDropDownButton: true,
//                       padding: EdgeInsets.zero,
//                       showFlagMain: true,
//                       textStyle: TextStyle(
//                           color:
//                               Theme.of(context).textTheme.displayLarge!.color),
//                     ),
//                   ),
//                   Expanded(
//                       child: CustomTextField(
//                     hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
//                     prefixIcon: const Icon(Icons.phone),
//                     controller: _phoneController,
//                     focusNode: _phoneFocus,
//                     nextNode: _referalFocus,
//                     isPhoneNumber: true,
//                     textInputAction: TextInputAction.next,
//                     textInputType: TextInputType.phone,
//                   )),
//                 ]),
//               ),
//               // Row(
//               //   children: [
//               //     Expanded(
//               //       child: Container(
//               //         margin: const EdgeInsets.only(
//               //             left: Dimensions.marginSizeDefault,
//               //             right: Dimensions.marginSizeDefault,
//               //             top: Dimensions.marginSizeSmall),
//               //         child: CustomTextField(
//               //           hintText: getTranslated('ENTER_YOUR_REFERAl', context),
//               //           prefixIcon: const Icon(Icons.discount),
//               //           focusNode: _referalFocus,
//               //           isPhoneNumber: true,
//               //           nextNode: _zipNode,
//               //           textInputType: TextInputType.phone,
//               //           controller: _referalcodeController,
//               //         ),
//               //       ),
//               //     ),
//               //     InkWell(
//               //         onTap: () {
//               //           getRerferData();
//               //         },
//               //         child: Icon(Icons.search)),
//               //     SizedBox(
//               //       width: 10,
//               //     )
//               //   ],
//               // ),
//               //
//               // Container(
//               //   margin: const EdgeInsets.only(
//               //       left: Dimensions.marginSizeDefault,
//               //       right: Dimensions.marginSizeDefault,
//               //       top: Dimensions.marginSizeSmall),
//               //   child: CustomTextField(
//               //     hintText: 'Refer Name',
//               //     isReadOnly: true,
//               //     prefixIcon: const Icon(Icons.person),
//               //     // focusNode: _emailFocus,
//               //     // nextNode: _phoneFocus,
//               //     textInputType: TextInputType.emailAddress,
//               //     controller: _referNameController,
//               //   ),
//               // ),
//
//               // Padding(
//               //   padding: const EdgeInsets.only(left: 20),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.start,
//               //     children: [
//               //       _referModel == null
//               //           ? SizedBox()
//               //           : Text(_referModel?.data.name ?? ''),
//               //     ],
//               //   ),
//               // ),
//
//               // const SizedBox(height: Dimensions.paddingSizeDefaultAddress),
//               // Text(
//               //   getTranslated('zip', context)!,
//               //   style: robotoRegular.copyWith(color: ColorResources.getHint(context)),
//               // ),
//               // const SizedBox(height: Dimensions.paddingSizeSmall),
//               Consumer<LocationProvider>(
//                   builder: (context, locationProvider, child) {
//                 return Container(
//                   margin: const EdgeInsets.only(
//                       left: Dimensions.marginSizeDefault,
//                       right: Dimensions.marginSizeDefault,
//                       top: Dimensions.marginSizeSmall),
//                   decoration: BoxDecoration(
//                     border: null,
//                     color: Theme.of(context).highlightColor,
//                     borderRadius: BorderRadius.circular(6),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           spreadRadius: 1,
//                           blurRadius: 3,
//                           offset:
//                               const Offset(0, 1)) // changes position of shadow
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       InkWell(
//                         child: Container(
//                           margin: const EdgeInsets.only(
//                               left: Dimensions.marginSizeDefault,
//                               right: Dimensions.marginSizeDefault,
//                               top: Dimensions.marginSizeSmall),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.location_on_outlined,
//                                 size: 20,
//                               ),
//                               SizedBox(
//                                 width: 15,
//                               ),
//                               Expanded(
//                                   child: Text(
//                                 _addressController.text == ''
//                                     ? 'Address'
//                                     : _addressController.text,
//                                 style: TextStyle(fontSize: 16),
//                               )),
//                             ],
//                           ),
//                           width: MediaQuery.sizeOf(context).width,
//                           height: 50,
//                           // CustomTextField(
//                           //   hintText:'Address',
//                           //   isReadOnly: true,
//                           //   prefixIcon: const Icon(Icons.location_on_outlined),
//                           //   // focusNode: _emailFocus,
//                           //   // nextNode: _phoneFocus,
//                           //   textInputType: TextInputType.text,
//                           //   controller: _addressController,
//                           // ),
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PlacePicker(
//                                 selectInitialPosition: true,
//                                 apiKey: Platform.isAndroid
//                                     ? ""
//                                     : "",
//                                 onPlacePicked: (result) {
//                                   print(
//                                       'Full Address: ${result.formattedAddress}');
//
//                                   // Extract components from address
//                                   for (var component
//                                       in result.addressComponents!) {
//                                     if (component.types.contains(
//                                         'administrative_area_level_1')) {
//                                       state = component.longName; // State
//                                       _stateController.text =
//                                           component.longName; // State
//                                     } else if (component.types
//                                         .contains('locality')) {
//                                       city = component.longName; // City
//                                       _cityController.text =
//                                           component.longName; // City
//                                     } else if (component.types
//                                             .contains('sublocality_level_1') ||
//                                         component.types
//                                             .contains('neighborhood')) {
//                                       area = component.longName; // Area
//                                       _areaController.text =
//                                           component.longName; // Area
//                                     } else if (component.types
//                                         .contains('postal_code')) {
//                                       pincode = component.longName; // Pincode
//                                       _zipCodeController.text =
//                                           component.longName; // Pincode
//                                     }
//                                   }
//
//                                   print('State: $state');
//                                   print('City: $city');
//                                   print('Area: $area');
//                                   print('Pincode: $pincode');
//
//                                   setState(() {
//                                     _addressController.text =
//                                         result.formattedAddress.toString();
//                                     lat = result.geometry!.location.lat;
//                                     _latController.text = result
//                                         .geometry!.location.lat
//                                         .toString();
//                                     _longController.text = result
//                                         .geometry!.location.lng
//                                         .toString();
//                                   });
//                                   Navigator.of(context).pop();
//                                 },
//                                 initialPosition:
//                                     const LatLng(22.719568, 75.857727),
//                                 useCurrentLocation: true,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       //
//                       // InkWell(
//                       //
//                       //   child: CustomTextField(
//                       //     hintText: 'Address',
//                       //     textInputAction: TextInputAction.next,
//                       //     focusNode: _zipNode,
//                       //     nextNode: _passwordFocus,
//                       //     controller: _addressController,
//                       //   ),
//                       //   onTap: () {
//                       //     Navigator.push(
//                       //       context,
//                       //       MaterialPageRoute(
//                       //         builder: (context) => PlacePicker(
//                       //           apiKey: Platform.isAndroid
//                       //               ? ""
//                       //               : "",
//                       //           onPlacePicked: (result) {
//                       //             print('Full Address: ${result.formattedAddress}');
//                       //
//                       //             // Extract components from address
//                       //             for (var component in result.addressComponents!) {
//                       //               if (component.types.contains('administrative_area_level_1')) {
//                       //                 state = component.longName; // State
//                       //                 _stateController.text = component.longName; // State
//                       //               } else if (component.types.contains('locality')) {
//                       //                 city = component.longName; // City
//                       //                 _cityController.text = component.longName; // City
//                       //               } else if (component.types.contains('sublocality_level_1') ||
//                       //                   component.types.contains('neighborhood')) {
//                       //                 area = component.longName; // Area
//                       //                 _areaController.text = component.longName; // Area
//                       //               } else if (component.types.contains('postal_code')) {
//                       //                 pincode = component.longName; // Pincode
//                       //                 _zipCodeController.text = component.longName; // Pincode
//                       //               }
//                       //             }
//                       //
//                       //             print('State: $state');
//                       //             print('City: $city');
//                       //             print('Area: $area');
//                       //             print('Pincode: $pincode');
//                       //
//                       //             setState(() {
//                       //               _addressController.text = result.formattedAddress.toString();
//                       //               lat = result.geometry!.location.lat;
//                       //               _latController.text = result.geometry!.location.lat.toString();
//                       //               _longController.text = result.geometry!.location.lng.toString();
//                       //             });
//                       //             Navigator.of(context).pop();
//                       //           },
//                       //           initialPosition: const LatLng(22.719568, 75.857727),
//                       //           useCurrentLocation: true,
//                       //         ),
//                       //       ),
//                       //     );
//                       //   },
//                       // )
//                       // Provider.of<LocationProvider>(context, listen: false)
//                       //             .registerZipList
//                       //             .length ==
//                       //         0
//                       //     ? CustomTextField(
//                       //         hintText: getTranslated('zip', context),
//                       //         textInputAction: TextInputAction.next,
//                       //         focusNode: _zipNode,
//                       //         nextNode: _passwordFocus,
//                       //         controller: _zipCodeController,
//                       //       )
//                       //     : Row(
//                       //         children: [
//                       //           Expanded(
//                       //             child: DropdownButtonHideUnderline(
//                       //               child: DropdownButton2<RegisterZipModel>(
//                       //                 isExpanded: true,
//                       //                 hint: Text(
//                       //                   'Select Zip Code',
//                       //                   style: TextStyle(
//                       //                     fontSize: 14,
//                       //                     color: Theme.of(context).hintColor,
//                       //                   ),
//                       //                 ),
//                       //                 items: locationProvider.registerZipList
//                       //                     .map((item) => DropdownMenuItem(
//                       //                           value: item,
//                       //                           child: Text(
//                       //                             item.zipcode ?? '',
//                       //                             style: const TextStyle(
//                       //                               fontSize: 14,
//                       //                             ),
//                       //                           ),
//                       //                         ))
//                       //                     .toList(),
//                       //                 value: locationProvider.selectedZip,
//                       //                 onChanged: (value) {
//                       //                   setState(() async {
//                       //                     locationProvider.selectedZip = value;
//                       //                     _zipCodeController.text =
//                       //                         value?.zipcode ?? '';
//                       //
//                       //                     _zipCodeController.text =
//                       //                         value!.zipcode!;
//                       //
//                       //                     await Provider.of<LocationProvider>(
//                       //                             context,
//                       //                             listen: false)
//                       //                         .getDeliveryRestrictedCityByZip(
//                       //                             context, value.id!);
//                       //
//                       //                     if (Provider.of<LocationProvider>(
//                       //                                 context,
//                       //                                 listen: false)
//                       //                             .stateCityData !=
//                       //                         null) {
//                       //                       _stateController.text =
//                       //                           Provider.of<LocationProvider>(
//                       //                                   context,
//                       //                                   listen: false)
//                       //                               .stateCityData!
//                       //                               .data!
//                       //                               .state
//                       //                               .toString();
//                       //                       _cityController.text =
//                       //                           Provider.of<LocationProvider>(
//                       //                                   context,
//                       //                                   listen: false)
//                       //                               .stateCityData!
//                       //                               .data!
//                       //                               .city
//                       //                               .toString();
//                       //                     }
//                       //                   });
//                       //                 },
//                       //                 buttonStyleData: const ButtonStyleData(
//                       //                   padding: EdgeInsets.symmetric(
//                       //                       horizontal: 16),
//                       //                   height: 40,
//                       //                   width: 200,
//                       //                 ),
//                       //                 dropdownStyleData:
//                       //                     const DropdownStyleData(
//                       //                   maxHeight: 200,
//                       //                 ),
//                       //                 menuItemStyleData:
//                       //                     const MenuItemStyleData(
//                       //                   height: 40,
//                       //                 ),
//                       //                 dropdownSearchData: DropdownSearchData(
//                       //                   searchController: searchController,
//                       //                   searchInnerWidgetHeight: 50,
//                       //                   // searchInnerWidget: Container(
//                       //                   //   height: 55,
//                       //                   //   padding: const EdgeInsets.only(
//                       //                   //     top: 8,
//                       //                   //     bottom: 4,
//                       //                   //     right: 8,
//                       //                   //     left: 8,
//                       //                   //   ),
//                       //                   //   child: Container(
//                       //                   //     height: 50,
//                       //                   //     child: Expanded(
//                       //                   //       child: TextFormField(
//                       //                   //         keyboardType:
//                       //                   //             TextInputType.number,
//                       //                   //         expands: true,
//                       //                   //         maxLines: null,
//                       //                   //         maxLength: 6,
//                       //                   //         controller: searchController,
//                       //                   //         decoration: InputDecoration(
//                       //                   //           isDense: true,
//                       //                   //           contentPadding:
//                       //                   //               const EdgeInsets
//                       //                   //                   .symmetric(
//                       //                   //             horizontal: 10,
//                       //                   //             vertical: 8,
//                       //                   //           ),
//                       //                   //           hintText:
//                       //                   //               'Search for zipcode...',
//                       //                   //           hintStyle: const TextStyle(
//                       //                   //               fontSize: 12),
//                       //                   //           counterText: '',
//                       //                   //           counterStyle:
//                       //                   //               TextStyle(fontSize: 0),
//                       //                   //           border: OutlineInputBorder(
//                       //                   //             borderRadius:
//                       //                   //                 BorderRadius.circular(
//                       //                   //                     8),
//                       //                   //           ),
//                       //                   //         ),
//                       //                   //       ),
//                       //                   //     ),
//                       //                   //   ),
//                       //                   // ),
//                       //
//                       //                   searchInnerWidget: Container(
//                       //                     height: 55,
//                       //                     padding: const EdgeInsets.only(
//                       //                       top: 8,
//                       //                       bottom: 4,
//                       //                       right: 8,
//                       //                       left: 8,
//                       //                     ),
//                       //                     child: Column(
//                       //                       children: [
//                       //                         Expanded(
//                       //                           child: TextFormField(
//                       //                             keyboardType:
//                       //                                 TextInputType.number,
//                       //                             expands: true,
//                       //                             maxLines: null,
//                       //                             maxLength: 6,
//                       //                             controller: searchController,
//                       //                             decoration: InputDecoration(
//                       //                               isDense: true,
//                       //                               contentPadding:
//                       //                                   const EdgeInsets
//                       //                                       .symmetric(
//                       //                                 horizontal: 10,
//                       //                                 vertical: 8,
//                       //                               ),
//                       //                               hintText:
//                       //                                   'Search for zipcode...',
//                       //                               hintStyle: const TextStyle(
//                       //                                   fontSize: 12),
//                       //                               counterText: '',
//                       //                               counterStyle:
//                       //                                   TextStyle(fontSize: 0),
//                       //                               border: OutlineInputBorder(
//                       //                                 borderRadius:
//                       //                                     BorderRadius.circular(
//                       //                                         8),
//                       //                               ),
//                       //                             ),
//                       //                           ),
//                       //                         ),
//                       //                       ],
//                       //                     ),
//                       //                   ),
//                       //
//                       //                   searchMatchFn: (item, searchValue) {
//                       //                     return item.value!.zipcode
//                       //                         .toString()
//                       //                         .contains(searchValue);
//                       //                   },
//                       //                 ),
//                       //                 //This to clear the search value when you close the menu
//                       //                 onMenuStateChange: (isOpen) {
//                       //                   if (!isOpen) {
//                       //                     searchController.clear();
//                       //                   }
//                       //                 },
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ],
//                       //       ),
//                       // Padding(
//                       //     padding: const EdgeInsets.only(right: 10),
//                       //     child: Container(
//                       //       height: 60,
//                       //       decoration: BoxDecoration(
//                       //         border: Border.all(
//                       //             color:
//                       //                 Color.fromARGB(255, 204, 204, 204)),
//                       //         borderRadius: BorderRadius.circular(8),
//                       //       ),
//                       //       child: DropdownButtonHideUnderline(
//                       //         child: DropdownButton2<RegisterZipModel>(
//                       //           isExpanded: true,
//                       //           hint: Text(
//                       //             'Select Zip Code',
//                       //             style: TextStyle(
//                       //               fontSize: 14,
//                       //               color: Theme.of(context).hintColor,
//                       //               fontWeight: FontWeight.bold,
//                       //             ),
//                       //           ),
//                       //           items: [
//                       //             DropdownMenuItem(
//                       //               enabled: false,
//                       //               child: Container(
//                       //                 padding: EdgeInsets.all(8.0),
//                       //                 child: TextField(
//                       //                   controller: searchController,
//                       //                   decoration: InputDecoration(
//                       //                     hintText: 'Search',
//                       //                     border: OutlineInputBorder(
//                       //                       borderRadius:
//                       //                           BorderRadius.circular(8.0),
//                       //                     ),
//                       //                   ),
//                       //                   onChanged: (value) {
//                       //                     // Filter the list based on the search query
//                       //                     setState(() {
//                       //                       locationProvider
//                       //                               .filteredZipList =
//                       //                           locationProvider
//                       //                               .registerZipList
//                       //                               .where((zip) {
//                       //                         return zip.zipcode!
//                       //                             .toLowerCase()
//                       //                             .contains(
//                       //                                 value.toLowerCase());
//                       //                       }).toList();
//                       //                     });
//                       //                   },
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //             ...locationProvider.filteredZipList
//                       //                 .map((RegisterZipModel zip) {
//                       //               return DropdownMenuItem(
//                       //                 value: zip,
//                       //                 child: Text(
//                       //                   zip.zipcode!,
//                       //                   style:
//                       //                       const TextStyle(fontSize: 14),
//                       //                 ),
//                       //               );
//                       //             }).toList(),
//                       //           ],
//                       //           value: locationProvider.selectedZip,
//                       //           onChanged:
//                       //               (RegisterZipModel? newValue) async {
//                       //             setState(() {
//                       //               locationProvider.selectedZip = newValue;
//                       //             });
//                       //
//                       //             if (newValue != null) {
//                       //               _zipCodeController.text =
//                       //                   newValue.zipcode!;
//                       //
//                       //               await Provider.of<LocationProvider>(
//                       //                       context,
//                       //                       listen: false)
//                       //                   .getDeliveryRestrictedCityByZip(
//                       //                       context, newValue.id!);
//                       //
//                       //               if (Provider.of<LocationProvider>(
//                       //                           context,
//                       //                           listen: false)
//                       //                       .stateCityData !=
//                       //                   null) {
//                       //                 _stateController.text =
//                       //                     Provider.of<LocationProvider>(
//                       //                             context,
//                       //                             listen: false)
//                       //                         .stateCityData!
//                       //                         .data!
//                       //                         .state
//                       //                         .toString();
//                       //                 _cityController.text =
//                       //                     Provider.of<LocationProvider>(
//                       //                             context,
//                       //                             listen: false)
//                       //                         .stateCityData!
//                       //                         .data!
//                       //                         .city
//                       //                         .toString();
//                       //               }
//                       //             }
//                       //           },
//                       //           buttonStyleData: const ButtonStyleData(
//                       //             padding:
//                       //                 EdgeInsets.symmetric(horizontal: 16),
//                       //             height: 40,
//                       //             width: double.infinity,
//                       //           ),
//                       //           dropdownStyleData: const DropdownStyleData(
//                       //             maxHeight: 500,
//                       //           ),
//                       //           menuItemStyleData: const MenuItemStyleData(
//                       //             height: 40,
//                       //           ),
//                       //           onMenuStateChange: (isOpen) {
//                       //             if (!isOpen) {
//                       //               // searchController.clear();
//                       //               // setState(() {
//                       //               //   locationProvider.filteredZipList =
//                       //               //       locationProvider.registerZipList;
//                       //               // });
//                       //
//                       //               if (!isOpen) {
//                       //                 searchController.clear();
//                       //                 locationProvider.filterVendors(
//                       //                     searchController.text);
//                       //               }
//                       //             }
//                       //           },
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ),
//
//                       // Padding(
//                       //         padding:
//                       //             const EdgeInsets.symmetric(horizontal: 8.0),
//                       //         child: DropdownSearch<RegisterZipModel>(
//                       //           items: locationProvider.registerZipList,
//                       //           itemAsString: (RegisterZipModel u) =>
//                       //               u.zipcode!,
//                       //           onChanged: (value) async {
//                       //             _zipCodeController.text = value!.zipcode!;
//                       //
//                       //             await Provider.of<LocationProvider>(context,
//                       //                     listen: false)
//                       //                 .getDeliveryRestrictedCityByZip(
//                       //                     context, value.id!);
//                       //
//                       //             if (Provider.of<LocationProvider>(context,
//                       //                         listen: false)
//                       //                     .stateCityData !=
//                       //                 null) {
//                       //               _stateController.text =
//                       //                   Provider.of<LocationProvider>(context,
//                       //                           listen: false)
//                       //                       .stateCityData!
//                       //                       .data!
//                       //                       .state
//                       //                       .toString();
//                       //               _cityController.text =
//                       //                   Provider.of<LocationProvider>(context,
//                       //                           listen: false)
//                       //                       .stateCityData!
//                       //                       .data!
//                       //                       .city
//                       //                       .toString();
//                       //             }
//                       //           },
//                       //           dropdownDecoratorProps:
//                       //               const DropDownDecoratorProps(
//                       //             dropdownSearchDecoration: InputDecoration(
//                       //                 labelText: "zip",
//                       //                 border: InputBorder.none),
//                       //           ),
//                       //         ),
//                       //       ),
//                     ],
//                   ),
//                 );
//               }),
//
//               Container(
//                 margin: const EdgeInsets.only(
//                     left: Dimensions.marginSizeDefault,
//                     right: Dimensions.marginSizeDefault,
//                     top: Dimensions.marginSizeSmall),
//                 child: CustomTextField(
//                   hintText: getTranslated('ENTER_YOUR_STATE', context),
//                   isReadOnly: true,
//                   prefixIcon: const Icon(Icons.location_city),
//                   // focusNode: _emailFocus,
//                   // nextNode: _phoneFocus,
//                   textInputType: TextInputType.text,
//                   controller: _stateController,
//                 ),
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(
//                     left: Dimensions.marginSizeDefault,
//                     right: Dimensions.marginSizeDefault,
//                     top: Dimensions.marginSizeSmall),
//                 child: CustomTextField(
//                   isReadOnly: true,
//                   hintText: getTranslated('ENTER_YOUR_CITY', context),
//                   prefixIcon: const Icon(Icons.location_city),
//                   // focusNode: _emailFocus,
//                   // nextNode: _phoneFocus,
//                   textInputType: TextInputType.text,
//                   controller: _cityController,
//                 ),
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(
//                     left: Dimensions.marginSizeDefault,
//                     right: Dimensions.marginSizeDefault,
//                     top: Dimensions.marginSizeSmall),
//                 child: CustomPasswordTextField(
//                   hintTxt: getTranslated('PASSWORD', context),
//                   prefixIcon: const Icon(Icons.lock_open_outlined),
//                   controller: _passwordController,
//                   focusNode: _passwordFocus,
//                   nextNode: _confirmPasswordFocus,
//                   textInputAction: TextInputAction.next,
//                 ),
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(
//                     left: Dimensions.marginSizeDefault,
//                     right: Dimensions.marginSizeDefault,
//                     top: Dimensions.marginSizeSmall),
//                 child: CustomPasswordTextField(
//                   hintTxt: getTranslated('RE_ENTER_PASSWORD', context),
//                   prefixIcon: const Icon(Icons.lock_open_outlined),
//                   controller: _confirmPasswordController,
//                   focusNode: _confirmPasswordFocus,
//                   textInputAction: TextInputAction.done,
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         Container(
//           margin: const EdgeInsets.only(
//               left: Dimensions.marginSizeLarge,
//               right: Dimensions.marginSizeLarge,
//               bottom: Dimensions.marginSizeLarge,
//               top: Dimensions.marginSizeLarge),
//           child: Provider.of<AuthProvider>(context).isLoading
//               ? Center(
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       Theme.of(context).primaryColor,
//                     ),
//                   ),
//                 )
//               : CustomButton(
//                   onTap: addUser,
//                   buttonText: getTranslated('SIGN_UP', context)),
//         ),
//
//         const SocialLoginWidget(),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: Dimensions.fontSizeDefault),
//           child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => HtmlViewScreen(
//                               title: getTranslated('terms_condition', context),
//                               url: Provider.of<SplashProvider>(context,
//                                       listen: false)
//                                   .configModel!
//                                   .termsConditions,
//                             )));
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(getTranslated('terms_condition', context)!,
//                       style: TextStyle(color: Theme.of(context).primaryColor)),
//                   const SizedBox(
//                     width: 2,
//                   ),
//                   Text("&",
//                       style: TextStyle(color: Theme.of(context).primaryColor)),
//                   SizedBox(
//                     width: 3,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => HtmlViewScreen(
//                             title: getTranslated('privacy_policy', context),
//                             url: Provider.of<SplashProvider>(context,
//                                     listen: false)
//                                 .configModel!
//                                 .privacyPolicy,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Text(getTranslated('privacy_policy', context)!,
//                         style:
//                             TextStyle(color: Theme.of(context).primaryColor)),
//                   ),
//                 ],
//               )),
//         ),
//
//         // for skip for now
//         Provider.of<AuthProvider>(context).isLoading
//             ? const SizedBox()
//             : const Center(
//                 child: Column(
//                 children: [
//                   //       Row(
//                   //       mainAxisAlignment: MainAxisAlignment.center,
//                   //       crossAxisAlignment: CrossAxisAlignment.center,
//                   //       children: [
//                   //         TextButton(
//                   //             onPressed: () => Navigator.pushReplacement(
//                   //                 context,
//                   //                 MaterialPageRoute(
//                   //                     builder: (_) => const DashBoardScreen())),
//                   //             child: Text(getTranslated('SKIP_FOR_NOW', context)!,
//                   //                 style: titilliumRegular.copyWith(
//                   //                     fontSize: Dimensions.fontSizeDefault,
//                   //                     color: ColorResources.getPrimary(context)))),
//                   //         Icon(
//                   //           Icons.arrow_forward,
//                   //           size: 15,
//                   //           color: Theme.of(context).primaryColor,
//                   //         )
//                   //       ],
//                   // ),
//                 ],
//               )),
//       ],
//     );
//   }
// }
