import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/user_info_model.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/widget/sign_out_confirmation_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/model/response/restricted_zip_model.dart';
import '../../../downloads_path_provider_28.dart';
import '../../../provider/location_provider.dart';
import '../../basewidget/show_custom_snakbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _referalFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _zipNode = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  bool _isProgress = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referalController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  File? file;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void _choose() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  _updateUserAccount() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String phoneNumber = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel!
                .fName ==
            _firstNameController.text &&
        Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel!
                .lName ==
            _lastNameController.text &&
        Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel!
                .phone ==
            _phoneController.text &&
        file == null &&
        _passwordController.text.isEmpty &&
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Change something to update'),
          backgroundColor: ColorResources.red));
    } else if (firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    }
    // else if (email.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)!),
    //       backgroundColor: ColorResources.red));
    // }
    // else if (phoneNumber.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
    //       backgroundColor: ColorResources.red));
    // } else if ((password.isNotEmpty && password.length < 6) ||
    //     (confirmPassword.isNotEmpty && confirmPassword.length < 6)) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text('Password should be at least 6 character'),
    //       backgroundColor: ColorResources.red));
    // } else if (password != confirmPassword) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
    //       backgroundColor: ColorResources.red));
    // }
    else {
      UserInfoModel updateUserInfoModel =
          Provider.of<ProfileProvider>(context, listen: false).userInfoModel!;
      updateUserInfoModel.method = 'put';
      updateUserInfoModel.fName = _firstNameController.text;
      updateUserInfoModel.lName = _lastNameController.text;
      updateUserInfoModel.phone = _phoneController.text;
      updateUserInfoModel.zipcode = _zipCodeController.text;
      updateUserInfoModel.state = _stateController.text;
      updateUserInfoModel.city = _cityController.text;
      updateUserInfoModel.area = _areaController.text;
      updateUserInfoModel.address = _addressController.text;
      updateUserInfoModel.lat = _latController.text;
      updateUserInfoModel.long = _longController.text;
      print('fsafsafsafasf111${_zipCodeController.text}');
      String pass = _passwordController.text;

      await Provider.of<ProfileProvider>(context, listen: false)
          .updateUserInfo(
        updateUserInfoModel,
        pass,
        file,
        Provider.of<AuthProvider>(context, listen: false).getUserToken(),
      )
          .then((response) {
        if (response.isSuccess) {
          Provider.of<ProfileProvider>(context, listen: false)
              .getUserInfo(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Updated Successfully'),
              backgroundColor: Colors.green));
          _passwordController.clear();
          _confirmPasswordController.clear();
          setState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.message!), backgroundColor: Colors.red));
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LocationProvider>(context, listen: false)
        .getRestrictedZipCode(context)
        .then((value) {
      RegisterZipModel registerZipModel =
          Provider.of<LocationProvider>(context, listen: false)
              .registerZipList
              .firstWhere((element) =>
                  element.zipcode ==
                  Provider.of<ProfileProvider>(context, listen: false)
                      .userInfoModel!
                      .zipcode);
      if (registerZipModel != null) {
        Provider.of<LocationProvider>(context, listen: false)
            .setZipCodeSelected(registerZipModel);
      }
      var data = Provider.of<ProfileProvider>(context, listen: false);
      _firstNameController.text = data.userInfoModel!.fName ?? '';
      _lastNameController.text = data.userInfoModel!.lName ?? '';
      _emailController.text = data.userInfoModel!.email!;
      _referalController.text = data.userInfoModel!.referral_code ?? '';
      _phoneController.text = data.userInfoModel!.phone ?? '';
      _zipCodeController.text = data.userInfoModel!.zipcode ?? '';
      _stateController.text = data.userInfoModel?.state ?? "";
      _cityController.text = data.userInfoModel?.city ?? "";
      _addressController.text = data.userInfoModel?.address ?? "";
      _latController.text = data.userInfoModel?.lat ?? "";
      _longController.text = data.userInfoModel?.long ?? "";
      _areaController.text = data.userInfoModel?.area ?? "";
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldKey,
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          // Provider.of<
          //     LocationProvider>(
          //     context,
          //     listen: false)
          //     .setZipCodeSelected(registerZipModel)
          if (kDebugMode) {
            print('wallet amount===>${profile.userInfoModel!.walletBalance}');
          }

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/homeappbar.png",
                  fit: BoxFit.cover,
                  height: 120,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 100),
              //   child: Image.asset(
              //     Images.toolbarBackground,
              //     fit: BoxFit.fill,
              //     height: 500,
              //     color: Provider.of<ThemeProvider>(context).darkTheme
              //         ? Colors.black
              //         : Color(0xff0007a3),
              //   ),
              // ),
              Container(
                // color: Colors.red,
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                height: 80, // Set a fixed height for proper alignment
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: CupertinoNavigationBarBackButton(
                    //     onPressed: () => Navigator.of(context).pop(),
                    //     color: Theme.of(context).primaryColor,
                    //   ),
                    // ),
                    Center(
                      child: Text(
                        getTranslated('PROFILE', context)!,
                        style: titilliumRegular.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
// SizedBox(height: 20,),
              Container(
                // padding: const EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 108.0),
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: Dimensions.marginSizeExtraLarge),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border.all(color: Colors.white, width: 3),
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: file == null
                                      ? FadeInImage.assetNetwork(
                                          placeholder: Images.placeholder,
                                          width: Dimensions.profileImageSize,
                                          height: Dimensions.profileImageSize,
                                          fit: BoxFit.cover,
                                          image:
                                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${profile.userInfoModel!.image}',
                                          imageErrorBuilder: (c, o, s) =>
                                              Image.asset(Images.placeholder,
                                                  width: Dimensions
                                                      .profileImageSize,
                                                  height: Dimensions
                                                      .profileImageSize,
                                                  fit: BoxFit.cover),
                                        )
                                      : Image.file(file!,
                                          width: Dimensions.profileImageSize,
                                          height: Dimensions.profileImageSize,
                                          fit: BoxFit.fill),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -10,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        ColorResources.lightSkyBlue,
                                    radius: 14,
                                    child: IconButton(
                                      onPressed: _choose,
                                      padding: const EdgeInsets.all(0),
                                      icon: const Icon(Icons.edit,
                                          color: ColorResources.white,
                                          size: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          '${profile.userInfoModel!.fName} ${profile.userInfoModel!.lName ?? ''}',
                          style: titilliumSemiBold.copyWith(
                              color: ColorResources.black, fontSize: 20.0),
                        )
                      ],
                    ),
                    const SizedBox(height: Dimensions.marginSizeDefault),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                    Dimensions.marginSizeDefault),
                                topRight: Radius.circular(
                                    Dimensions.marginSizeDefault),
                              )),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Container(
                                color: Theme.of(context).primaryColor,
                                margin: const EdgeInsets.only(
                                    left: Dimensions.marginSizeDefault,
                                    right: Dimensions.marginSizeDefault),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            getTranslated(
                                                'FIRST_NAME', context)!,
                                            style: titilliumRegular),
                                        const SizedBox(
                                            height: Dimensions.marginSizeSmall),
                                        CustomTextField(
                                          textInputType: TextInputType.name,
                                          prefixIcon: const Icon(Icons.person,
                                              color: ColorResources.primary,
                                              size: 20),
                                          focusNode: _fNameFocus,
                                          nextNode: _lNameFocus,
                                          hintText:
                                              profile.userInfoModel!.fName ??
                                                  '',
                                          controller: _firstNameController,
                                        ),
                                      ],
                                    )),
                                    const SizedBox(
                                        width: Dimensions.paddingSizeDefault),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            getTranslated(
                                                'LAST_NAME', context)!,
                                            style: titilliumRegular),
                                        const SizedBox(
                                            height: Dimensions.marginSizeSmall),
                                        CustomTextField(
                                          prefixIcon: const Icon(Icons.person,
                                              color: ColorResources.primary,
                                              size: 20),
                                          textInputType: TextInputType.name,
                                          focusNode: _lNameFocus,
                                          nextNode: _emailFocus,
                                          hintText:
                                              profile.userInfoModel!.lName,
                                          controller: _lastNameController,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),

                              Container(
                                color: Theme.of(context).primaryColor,
                                margin: const EdgeInsets.only(
                                    top: Dimensions.marginSizeDefault,
                                    left: Dimensions.marginSizeDefault,
                                    right: Dimensions.marginSizeDefault),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getTranslated('EMAIL', context)!,
                                        style: titilliumRegular),
                                    const SizedBox(
                                        height: Dimensions.marginSizeSmall),
                                    CustomTextField(
                                      isReadOnly: false,
                                      prefixIcon: const Icon(
                                          Icons.alternate_email,
                                          color: ColorResources.primary,
                                          size: 20),
                                      textInputType: TextInputType.emailAddress,
                                      focusNode: _emailFocus,
                                      isEnable: false,
                                      nextNode: _referalFocus,
                                      fillColor: Theme.of(context)
                                          .hintColor
                                          .withOpacity(.12),
                                      hintText:
                                          profile.userInfoModel!.email ?? '',
                                      controller: _emailController,
                                    ),
                                  ],
                                ),
                              ),

                              // Container(
                              //   margin: const EdgeInsets.only(
                              //     top: Dimensions.marginSizeDefault,
                              //     left: Dimensions.marginSizeDefault,
                              //     right: Dimensions.marginSizeDefault),
                              //   child: Column(children: [
                              //     InkWell(
                              //       onTap: (){
                              //         Share.share("Your referral code is ${profile.userInfoModel!.referral_code}");
                              //       },
                              //       child: Row(children: [
                              //           const SizedBox(width: Dimensions.marginSizeExtraSmall,),
                              //           Text(getTranslated('referral_code', context)!, style: titilliumRegular)
                              //         ],
                              //       ),
                              //     ),
                              //     const SizedBox(height: Dimensions.marginSizeSmall),
                              //
                              //     InkWell(
                              //       onTap: (){
                              //         Share.share("Your referral code is ${profile.userInfoModel!.referral_code}");
                              //       },
                              //       child: CustomTextField(textInputType: TextInputType.emailAddress,
                              //         focusNode: _referalFocus,
                              //         isEnable : false,
                              //         nextNode: _phoneFocus,
                              //         fillColor: Theme.of(context).hintColor.withOpacity(.12),
                              //         hintText: profile.userInfoModel!.referral_code ?? '',
                              //         controller: _referalController,
                              //       ),
                              //     ),
                              //   ],
                              //   ),
                              // ),

                              Container(
                                color: Theme.of(context).primaryColor,
                                margin: const EdgeInsets.only(
                                    top: Dimensions.marginSizeDefault,
                                    left: Dimensions.marginSizeDefault,
                                    right: Dimensions.marginSizeDefault),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getTranslated('PHONE_NO', context)!,
                                        style: titilliumRegular),
                                    const SizedBox(
                                        height: Dimensions.marginSizeSmall),
                                    CustomTextField(
                                      isReadOnly: true,
                                      prefixIcon: const Icon(Icons.dialpad,
                                          color: ColorResources.primary,
                                          size: 20),
                                      textInputType: TextInputType.phone,
                                      focusNode: _phoneFocus,
                                      fillColor: Theme.of(context)
                                          .hintColor
                                          .withOpacity(.12),
                                      hintText:
                                          profile.userInfoModel!.phone ?? "",
                                      nextNode: _addressFocus,
                                      controller: _phoneController,
                                      isPhoneNumber: true,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // InkWell(
                              //   child: Padding(
                              //     padding:
                              //         const EdgeInsets.only(left: 8, right: 8),
                              //     child: Card(
                              //       elevation: null,
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(8)),
                              //       child: Container(
                              //         //
                              //         // margin: const EdgeInsets.only(
                              //         //     left: Dimensions.marginSizeDefault,
                              //         //     right: Dimensions.marginSizeDefault,
                              //         //     top: Dimensions.marginSizeSmall),
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           borderRadius: BorderRadius.circular(8),
                              //         ),
                              //         child: Row(
                              //           children: [
                              //             Icon(
                              //               Icons.location_on_outlined,
                              //               size: 20,
                              //             ),
                              //             SizedBox(
                              //               width: 15,
                              //             ),
                              //             Expanded(
                              //                 child: Text(
                              //               _addressController.text == ''
                              //                   ? 'Address'
                              //                   : _addressController.text,
                              //               style: TextStyle(fontSize: 16),
                              //             )),
                              //           ],
                              //         ),
                              //         width: MediaQuery.sizeOf(context).width,
                              //         height: 50,
                              //         // CustomTextField(
                              //         //   hintText:'Address',
                              //         //   isReadOnly: true,
                              //         //   prefixIcon: const Icon(Icons.location_on_outlined),
                              //         //   // focusNode: _emailFocus,
                              //         //   // nextNode: _phoneFocus,
                              //         //   textInputType: TextInputType.text,
                              //         //   controller: _addressController,
                              //         // ),
                              //       ),
                              //     ),
                              //   ),
                              //   onTap: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => PlacePicker(
                              //           apiKey: Platform.isAndroid
                              //               ? ""
                              //               : "",
                              //           onPlacePicked: (result) {
                              //             _addressController.text =
                              //                 result.formattedAddress ?? '';
                              //             print(
                              //                 'Full Address: ${result.formattedAddress}');

                              //             // Extract components from address
                              //             for (var component
                              //                 in result.addressComponents!) {
                              //               if (component.types.contains(
                              //                   'administrative_area_level_1')) {
                              //                 _stateController.text =
                              //                     component.longName; // State
                              //               } else if (component.types
                              //                   .contains('locality')) {
                              //                 _cityController.text =
                              //                     component.longName; // City
                              //               } else if (component.types.contains(
                              //                       'sublocality_level_1') ||
                              //                   component.types
                              //                       .contains('neighborhood')) {
                              //                 _areaController.text =
                              //                     component.longName; // Area
                              //               } else if (component.types
                              //                   .contains('postal_code')) {
                              //                 _zipCodeController.text =
                              //                     component.longName; // Pincode
                              //               }
                              //             }

                              //             print(
                              //                 'State: ${_stateController.text}');
                              //             print(
                              //                 'City: ${_cityController.text}');
                              //             print(
                              //                 'Area: ${_areaController.text}');
                              //             print(
                              //                 'Pincode: ${_zipCodeController.text}');
                              //             // _addressController.text = result.formattedAddress.toString();
                              //             // lat = result.geometry!.location.lat;
                              //             _latController.text = result
                              //                 .geometry!.location.lat
                              //                 .toString();
                              //             _longController.text = result
                              //                 .geometry!.location.lng
                              //                 .toString();
                              //             // setState(() {
                              //             //
                              //             // });
                              //             Navigator.of(context).pop();
                              //           },
                              //           initialPosition:
                              //               const LatLng(22.719568, 75.857727),
                              //           useCurrentLocation: true,
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                              // Consumer<LocationProvider>(
                              //     builder: (context, locationProvider, child) {
                              //   return Container(
                              //     margin: const EdgeInsets.only(
                              //         left: Dimensions.marginSizeDefault,
                              //         right: Dimensions.marginSizeDefault,
                              //         top: Dimensions.marginSizeSmall),
                              //     decoration: BoxDecoration(
                              //       border: null,
                              //       color: Theme.of(context).highlightColor,
                              //       borderRadius: BorderRadius.circular(6),
                              //       boxShadow: [
                              //         BoxShadow(
                              //             color: Colors.grey.withOpacity(0.1),
                              //             spreadRadius: 1,
                              //             blurRadius: 3,
                              //             offset: const Offset(
                              //                 0, 1)) // changes position of shadow
                              //       ],
                              //     ),
                              //     child: Column(
                              //       children: [
                              //         Provider.of<LocationProvider>(context,
                              //                         listen: false)
                              //                     .registerZipList
                              //                     .length ==
                              //                 0
                              //             ? CustomTextField(
                              //                 hintText:
                              //                     getTranslated('zip', context),
                              //                 textInputAction:
                              //                     TextInputAction.next,
                              //                 focusNode: _zipNode,
                              //                 nextNode: _passwordFocus,
                              //                 controller: _zipCodeController,
                              //               )
                              //             : Padding(
                              //                 padding: const EdgeInsets.symmetric(
                              //                     horizontal: 8.0),
                              //                 child: DropdownSearch<
                              //                     RegisterZipModel>(
                              //                   selectedItem:
                              //                       locationProvider.zipSelected,
                              //                   items: locationProvider
                              //                       .registerZipList,
                              //                   itemAsString:
                              //                       (RegisterZipModel u) =>
                              //                           u.zipcode!,
                              //                   onChanged: (value) async {
                              //                     _zipCodeController.text =
                              //                         value!.zipcode!;
                              //                     print('fsafsafsafasf${_zipCodeController.text}');
                              //                     await Provider.of<
                              //                                 LocationProvider>(
                              //                             context,
                              //                             listen: false)
                              //                         .getDeliveryRestrictedCityByZip(
                              //                             context, value!.id!);
                              //
                              //                     if (Provider.of<LocationProvider>(
                              //                                 context,
                              //                                 listen: false)
                              //                             .stateCityData !=
                              //                         null) {
                              //                       _stateController
                              //                           .text = Provider.of<
                              //                                   LocationProvider>(
                              //                               context,
                              //                               listen: false)
                              //                           .stateCityData!
                              //                           .data!
                              //                           .state
                              //                           .toString()!;
                              //                       _cityController
                              //                           .text = Provider.of<
                              //                                   LocationProvider>(
                              //                               context,
                              //                               listen: false)
                              //                           .stateCityData!
                              //                           .data!
                              //                           .city
                              //                           .toString()!;
                              //                     }
                              //                   },
                              //                   dropdownDecoratorProps:
                              //                       const DropDownDecoratorProps(
                              //                     dropdownSearchDecoration:
                              //                         InputDecoration(
                              //                             labelText: "Zip",
                              //                             border:
                              //                                 InputBorder.none),
                              //                   ),
                              //                 ),
                              //               ),
                              //       ],
                              //     ),
                              //   );
                              // }),

                              Container(
                                margin: const EdgeInsets.only(
                                    left: Dimensions.marginSizeDefault,
                                    right: Dimensions.marginSizeDefault,
                                    top: Dimensions.marginSizeSmall),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        getTranslated(
                                            'ENTER_YOUR_ADDRESS', context)!,
                                        style: titilliumRegular),
                                    const SizedBox(
                                        height: Dimensions.marginSizeSmall),
                                    CustomTextField(
                                      hintText: getTranslated(
                                          'ENTER_YOUR_ADDRESS', context),
                                      prefixIcon:
                                          const Icon(Icons.location_city),
                                      // focusNode: _emailFocus,
                                      // nextNode: _phoneFocus,
                                      textInputType: TextInputType.text,
                                      controller: _addressController,
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.only(
                                    left: Dimensions.marginSizeDefault,
                                    right: Dimensions.marginSizeDefault,
                                    top: Dimensions.marginSizeSmall),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          getTranslated(
                                              'ENTER_YOUR_STATE', context)!,
                                          style: titilliumRegular),
                                      const SizedBox(
                                          height: Dimensions.marginSizeSmall),
                                      CustomTextField(
                                        hintText: getTranslated(
                                            'ENTER_YOUR_STATE', context),
                                        prefixIcon:
                                            const Icon(Icons.location_city),
                                        // focusNode: _emailFocus,
                                        // nextNode: _phoneFocus,
                                        textInputType: TextInputType.text,
                                        controller: _stateController,
                                      )
                                    ]),
                              ),

                              Container(
                                margin: const EdgeInsets.only(
                                    left: Dimensions.marginSizeDefault,
                                    right: Dimensions.marginSizeDefault,
                                    top: Dimensions.marginSizeSmall),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        getTranslated(
                                            'ENTER_YOUR_CITY', context)!,
                                        style: titilliumRegular),
                                    const SizedBox(
                                        height: Dimensions.marginSizeSmall),
                                    CustomTextField(
                                      // isReadOnly: true,
                                      hintText: getTranslated(
                                          'ENTER_YOUR_CITY', context),
                                      prefixIcon:
                                          const Icon(Icons.location_city),
                                      // focusNode: _emailFocus,
                                      // nextNode: _phoneFocus,
                                      textInputType: TextInputType.text,
                                      controller: _cityController,
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.only(
                                    top: Dimensions.marginSizeDefault,
                                    left: Dimensions.marginSizeDefault,
                                    right: Dimensions.marginSizeDefault),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getTranslated('PASSWORD', context)!,
                                        style: titilliumRegular),
                                    const SizedBox(
                                        height: Dimensions.marginSizeSmall),
                                    CustomPasswordTextField(
                                      prefixIcon: const Icon(
                                        Icons.password,
                                        color: ColorResources.primary,
                                      ),
                                      controller: _passwordController,
                                      focusNode: _passwordFocus,
                                      nextNode: _confirmPasswordFocus,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.only(
                                    top: Dimensions.marginSizeDefault,
                                    left: Dimensions.marginSizeDefault,
                                    right: Dimensions.marginSizeDefault),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        getTranslated(
                                            'RE_ENTER_PASSWORD', context)!,
                                        style: titilliumRegular),
                                    const SizedBox(
                                        height: Dimensions.marginSizeSmall),
                                    CustomPasswordTextField(
                                      prefixIcon: const Icon(
                                        Icons.password,
                                        color: ColorResources.primary,
                                      ),
                                      controller: _confirmPasswordController,
                                      focusNode: _confirmPasswordFocus,
                                      textInputAction: TextInputAction.done,
                                    ),
                                    const SizedBox(
                                        height: Dimensions.marginSizeSmall),
                                    // downloadInvoice(profile),
                                    const SizedBox(
                                        height: Dimensions.paddingSizeLarge),
                                    InkWell(
                                      onTap: () => showAnimatedDialog(
                                          context,
                                          SignOutConfirmationDialog(
                                            isDelete: true,
                                            customerId:
                                                profile.userInfoModel!.id,
                                          ),
                                          isFlip: true),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              alignment: Alignment.center,
                                              height: Dimensions.iconSizeSmall,
                                              child:
                                                  Image.asset(Images.delete)),
                                          const SizedBox(
                                            width:
                                                Dimensions.paddingSizeDefault,
                                          ),
                                          Text(
                                            getTranslated(
                                                'delete_account', context)!,
                                            style: robotoRegular.copyWith(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.marginSizeLarge,
                                          vertical: Dimensions.marginSizeSmall),
                                      child: !Provider.of<ProfileProvider>(
                                                  context)
                                              .isLoading
                                          ? CustomButton(
                                              onTap: _updateUserAccount,
                                              buttonText: getTranslated(
                                                  'UPDATE_ACCOUNT', context))
                                          : Center(
                                              child: CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Theme.of(context)
                                                              .primaryColor))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.marginSizeLarge,
                          vertical: Dimensions.marginSizeSmall),
                      child: !Provider.of<ProfileProvider>(context).isLoading
                          ? CustomButton1(
                              onTap: _updateUserAccount,
                              buttonText:
                                  getTranslated('UPDATE_ACCOUNT', context))
                          : Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor))),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  downloadInvoice(ProfileProvider profile) {
    return Card(
      elevation: 0,
      child: InkWell(
          child: ListTile(
            dense: true,
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).primaryColor,
            ),
            leading: Icon(
              Icons.receipt,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Download Id Card",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Theme.of(context).colorScheme.surfaceTint),
            ),
          ),
          onTap: () async {
            try {
              DateTime date = DateFormat('yyyy-MM-dd')
                  .parse(profile.userInfoModel!.plan_expire_date!);
              if (date.isBefore(DateTime.now())) {
                showCustomSnackBar("Please purchase plan", Get.context!);
              } else {
                _launchUrl(Uri.parse(profile.userInfoModel!.certificate!));
              }
            } catch (e) {
              showCustomSnackBar("Please purchase plan", Get.context!);
              print(e);
            }

//             final plugin = DeviceInfoPlugin();
//             final android = await plugin.androidInfo;
//             print("++++++++++++");
//             var status = android.version.sdkInt! < 33
//                 ? await Permission.storage.request()
//                 : PermissionStatus.granted;
//
//             // status = await Permission.storage.request();
//             //await Permission.storage.request();
//             print("++++++++++++${status}");
//             if (status == PermissionStatus.granted) {
//               if (mounted) {
//                 setState(() {
//                   _isProgress = true;
//                 });
//               }
//               var targetPath;
//
//               if (Platform.isIOS) {
//                 var target = await getApplicationDocumentsDirectory();
//                 targetPath = target.path.toString();
//               } else {
//                 var downloadsDirectory =
//                     await getApplicationDocumentsDirectory();
//                 // = await DownloadsPathProvider.downloadsDirectory;
//                 targetPath = downloadsDirectory!.path.toString();
//               }
//
//               var targetFileName = "Invoice_${"widget.model!.id"}";
//               var generatedPdfFile, filePath;
//
//               try {
//                 generatedPdfFile =
//                     await FlutterHtmlToPdf.convertFromHtmlContent("""
// <!DOCTYPE html>
// <html>
// <head>
//   <style>
//   table, th, td {
//     border: 1px solid black;
//     border-collapse: collapse;
//   }
//   th, td, p {
//     padding: 5px;
//     text-align: left;
//   }
//   </style>
// </head>
//   <body>
//     <h2>PDF Generated with flutter_html_to_pdf plugin</h2>
//     <table style="width:100%">
//       <caption>Sample HTML Table</caption>
//       <tr>
//         <th>Month</th>
//         <th>Savings</th>
//       </tr>
//       <tr>
//         <td>January</td>
//         <td>100</td>
//       </tr>
//       <tr>
//         <td>February</td>
//         <td>50</td>
//       </tr>
//     </table>
//     <p>Image loaded from web</p>
//     <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
//   </body>
// </html>
// """, targetPath, targetFileName);
//                 filePath = generatedPdfFile.path;
//               } on Exception {
//                 //  filePath = targetPath + "/" + targetFileName + ".html";
//                 generatedPdfFile =
//                     await FlutterHtmlToPdf.convertFromHtmlContent("""
// <!DOCTYPE html>
// <html>
// <head>
//   <style>
//   table, th, td {
//     border: 1px solid black;
//     border-collapse: collapse;
//   }
//   th, td, p {
//     padding: 5px;
//     text-align: left;
//   }
//   </style>
// </head>
//   <body>
//     <h2>PDF Generated with flutter_html_to_pdf plugin</h2>
//     <table style="width:100%">
//       <caption>Sample HTML Table</caption>
//       <tr>
//         <th>Month</th>
//         <th>Savings</th>
//       </tr>
//       <tr>
//         <td>January</td>
//         <td>100</td>
//       </tr>
//       <tr>
//         <td>February</td>
//         <td>50</td>
//       </tr>
//     </table>
//     <p>Image loaded from web</p>
//     <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
//   </body>
// </html>
// """, targetPath, targetFileName);
//                 filePath = generatedPdfFile.path;
//               }
//
//               if (mounted) {
//                 setState(() {
//                   _isProgress = false;
//                 });
//               }
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text(
//                   "Invoice Path $targetFileName",
//                   textAlign: TextAlign.center,
//                   style:
//                       TextStyle(color: Theme.of(context).colorScheme.onError),
//                 ),
//                 action: SnackBarAction(
//                     label: "View",
//                     textColor: Theme.of(context).colorScheme.primary,
//                     onPressed: () async {
//                       final result = await OpenFilex.open(filePath);
//                       print("object${result.message}");
//                     }),
//                 backgroundColor:
//                     Theme.of(context).colorScheme.onSecondaryContainer,
//                 elevation: 1.0,
//               ));
//             }
          }),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    print("object $url");
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $url';
  }
}
// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
// import 'package:flutter_sixvalley_ecommerce/data/model/response/user_info_model.dart';
//
// import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
// import 'package:flutter_sixvalley_ecommerce/main.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
// import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
// import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
// import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_password_textfield.dart';
// import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';
// import 'package:flutter_sixvalley_ecommerce/view/screen/more/widget/sign_out_confirmation_dialog.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:share/share.dart';
//
// import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../data/model/response/restricted_zip_model.dart';
// import '../../../downloads_path_provider_28.dart';
// import '../../../provider/location_provider.dart';
// import '../../basewidget/show_custom_snakbar.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   ProfileScreenState createState() => ProfileScreenState();
// }
//
// class ProfileScreenState extends State<ProfileScreen> {
//   final FocusNode _fNameFocus = FocusNode();
//   final FocusNode _lNameFocus = FocusNode();
//   final FocusNode _emailFocus = FocusNode();
//   final FocusNode _referalFocus = FocusNode();
//   final FocusNode _phoneFocus = FocusNode();
//   final FocusNode _zipNode = FocusNode();
//   final FocusNode _addressFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//   final FocusNode _confirmPasswordFocus = FocusNode();
//   bool _isProgress = false;
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _referalController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   final TextEditingController _zipCodeController = TextEditingController();
//   final TextEditingController _latController = TextEditingController();
//   final TextEditingController _longController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _areaController = TextEditingController();
//
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//
//   File? file;
//   final picker = ImagePicker();
//   final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
//       GlobalKey<ScaffoldMessengerState>();
//
//   void _choose() async {
//     final pickedFile = await picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 50,
//         maxHeight: 500,
//         maxWidth: 500);
//     setState(() {
//       if (pickedFile != null) {
//         file = File(pickedFile.path);
//       } else {
//         if (kDebugMode) {
//           print('No image selected.');
//         }
//       }
//     });
//   }
//
//   _updateUserAccount() async {
//     String firstName = _firstNameController.text.trim();
//     String lastName = _lastNameController.text.trim();
//     String email = _emailController.text.trim();
//     String phoneNumber = _phoneController.text.trim();
//     String password = _passwordController.text.trim();
//     String confirmPassword = _confirmPasswordController.text.trim();
//
//     // if (Provider.of<ProfileProvider>(context, listen: false)
//     //             .userInfoModel!
//     //             .fName ==
//     //         _firstNameController.text &&
//     //     Provider.of<ProfileProvider>(context, listen: false)
//     //             .userInfoModel!
//     //             .lName ==
//     //         _lastNameController.text &&
//     //     Provider.of<ProfileProvider>(context, listen: false)
//     //             .userInfoModel!
//     //             .phone ==
//     //         _phoneController.text &&
//     //     file == null &&
//     //     _passwordController.text.isEmpty &&
//     //     _confirmPasswordController.text.isEmpty) {
//     //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//     //       content: Text('Change something to update'),
//     //       backgroundColor: ColorResources.red));
//     // } else
//     if (firstName.isEmpty || lastName.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)!),
//           backgroundColor: ColorResources.red));
//     } else if (email.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)!),
//           backgroundColor: ColorResources.red));
//     } else if (phoneNumber.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
//           backgroundColor: ColorResources.red));
//     } else if ((password.isNotEmpty && password.length < 6) ||
//         (confirmPassword.isNotEmpty && confirmPassword.length < 6)) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Password should be at least 6 character'),
//           backgroundColor: ColorResources.red));
//     } else if (password != confirmPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
//           backgroundColor: ColorResources.red));
//     } else {
//       UserInfoModel updateUserInfoModel =
//           Provider.of<ProfileProvider>(context, listen: false).userInfoModel!;
//       updateUserInfoModel.method = 'put';
//       updateUserInfoModel.fName = _firstNameController.text;
//       updateUserInfoModel.lName = _lastNameController.text;
//       updateUserInfoModel.phone = _phoneController.text;
//       updateUserInfoModel.zipcode = _zipCodeController.text;
//       updateUserInfoModel.state = _stateController.text;
//       updateUserInfoModel.city = _cityController.text;
//       updateUserInfoModel.area = _areaController.text;
//       updateUserInfoModel.address = _addressController.text;
//       updateUserInfoModel.lat = _latController.text;
//       updateUserInfoModel.long = _longController.text;
//       print('fsafsafsafasf111${_zipCodeController.text}');
//       String pass = _passwordController.text;
//
//       await Provider.of<ProfileProvider>(context, listen: false)
//           .updateUserInfo(
//         updateUserInfoModel,
//         pass,
//         file,
//         Provider.of<AuthProvider>(context, listen: false).getUserToken(),
//       )
//           .then((response) {
//         if (response.isSuccess) {
//           Provider.of<ProfileProvider>(context, listen: false)
//               .getUserInfo(context);
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: Text('Updated Successfully'),
//               backgroundColor: Colors.green));
//           _passwordController.clear();
//           _confirmPasswordController.clear();
//           setState(() {});
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text(response.message!), backgroundColor: Colors.red));
//         }
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Provider.of<LocationProvider>(context, listen: false)
//         .getRestrictedZipCode(context)
//         .then((value) {
//       RegisterZipModel registerZipModel =
//           Provider.of<LocationProvider>(context, listen: false)
//               .registerZipList
//               .firstWhere((element) =>
//                   element.zipcode ==
//                   Provider.of<ProfileProvider>(context, listen: false)
//                       .userInfoModel!
//                       .zipcode);
//       if (registerZipModel != null) {
//         Provider.of<LocationProvider>(context, listen: false)
//             .setZipCodeSelected(registerZipModel);
//       }
//       var data = Provider.of<ProfileProvider>(context, listen: false);
//       _firstNameController.text = data.userInfoModel!.fName ?? '';
//       _lastNameController.text = data.userInfoModel!.lName ?? '';
//       _emailController.text = data.userInfoModel!.email!;
//       _referalController.text = data.userInfoModel!.referral_code ?? '';
//       _phoneController.text = data.userInfoModel!.phone ?? '';
//       _zipCodeController.text = data.userInfoModel!.zipcode ?? '';
//       _stateController.text = data.userInfoModel?.state ?? "";
//       _cityController.text = data.userInfoModel?.city ?? "";
//       _addressController.text = data.userInfoModel?.address ?? "";
//       _latController.text = data.userInfoModel?.lat ?? "";
//       _longController.text = data.userInfoModel?.long ?? "";
//       _areaController.text = data.userInfoModel?.area ?? "";
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Consumer<ProfileProvider>(
//         builder: (context, profile, child) {
//           // Provider.of<
//           //     LocationProvider>(
//           //     context,
//           //     listen: false)
//           //     .setZipCodeSelected(registerZipModel)
//           if (kDebugMode) {
//             print('wallet amount===>${profile.userInfoModel!.walletBalance}');
//           }
//
//           return Stack(
//             clipBehavior: Clip.none,
//
//             children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               "assets/images/homeappbar.png",
//               fit: BoxFit.cover,
//               height: 100,
//             ),
//           ),
//               // Padding(
//               //   padding: const EdgeInsets.only(bottom: 100),
//               //   child: Image.asset(
//               //     Images.toolbarBackground,
//               //     fit: BoxFit.fill,
//               //     height: 500,
//               //     color: Provider.of<ThemeProvider>(context).darkTheme
//               //         ? Colors.black
//               //         : Color(0xff0007a3),
//               //   ),
//               // ),
//               Container(
//                 color: Colors.red,
//                 padding: const EdgeInsets.only(top: 35, left: 15),
//                 child: Row(children: [
//                   CupertinoNavigationBarBackButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     color: ColorResources.primary,
//                   ),
//                   const SizedBox(width: 10),
//                   Text(getTranslated('PROFILE', context)!,
//                       style: titilliumRegular.copyWith(
//                           fontSize: 20, color: Colors.white),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis),
//                 ]),
//               ),
//               Container(
//                 padding: const EdgeInsets.only(top: 55),
//                 child: Column(
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(
//                               top: Dimensions.marginSizeExtraLarge),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).cardColor,
//                             border: Border.all(color: Colors.white, width: 3),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(50),
//                                 child: file == null
//                                     ? FadeInImage.assetNetwork(
//                                         placeholder: Images.placeholder,
//                                         width: Dimensions.profileImageSize,
//                                         height: Dimensions.profileImageSize,
//                                         fit: BoxFit.cover,
//                                         image:
//                                             '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${profile.userInfoModel!.image}',
//                                         imageErrorBuilder: (c, o, s) =>
//                                             Image.asset(Images.placeholder,
//                                                 width:
//                                                     Dimensions.profileImageSize,
//                                                 height:
//                                                     Dimensions.profileImageSize,
//                                                 fit: BoxFit.cover),
//                                       )
//                                     : Image.file(file!,
//                                         width: Dimensions.profileImageSize,
//                                         height: Dimensions.profileImageSize,
//                                         fit: BoxFit.fill),
//                               ),
//                               Positioned(
//                                 bottom: 0,
//                                 right: -10,
//                                 child: CircleAvatar(
//                                   backgroundColor: ColorResources.lightSkyBlue,
//                                   radius: 14,
//                                   child: IconButton(
//                                     onPressed: _choose,
//                                     padding: const EdgeInsets.all(0),
//                                     icon: const Icon(Icons.edit,
//                                         color: ColorResources.white, size: 18),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Text(
//                           '${profile.userInfoModel!.fName} ${profile.userInfoModel!.lName ?? ''}',
//                           style: titilliumSemiBold.copyWith(
//                               color: ColorResources.white, fontSize: 20.0),
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: Dimensions.marginSizeDefault),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: ColorResources.getIconBg(context),
//                             borderRadius: const BorderRadius.only(
//                               topLeft:
//                                   Radius.circular(Dimensions.marginSizeDefault),
//                               topRight:
//                                   Radius.circular(Dimensions.marginSizeDefault),
//                             )),
//                         child: ListView(
//                           physics: const BouncingScrollPhysics(),
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   left: Dimensions.marginSizeDefault,
//                                   right: Dimensions.marginSizeDefault),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                       child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(Icons.person,
//                                               color: ColorResources
//                                                   .primary,
//                                               size: 20),
//                                           const SizedBox(
//                                               width: Dimensions
//                                                   .marginSizeExtraSmall),
//                                           Text(
//                                               getTranslated(
//                                                   'FIRST_NAME', context)!,
//                                               style: titilliumRegular)
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                           height: Dimensions.marginSizeSmall),
//                                       CustomTextField(
//                                         textInputType: TextInputType.name,
//                                         focusNode: _fNameFocus,
//                                         nextNode: _lNameFocus,
//                                         hintText:
//                                             profile.userInfoModel!.fName ?? '',
//                                         controller: _firstNameController,
//                                       ),
//                                     ],
//                                   )),
//                                   const SizedBox(
//                                       width: Dimensions.paddingSizeDefault),
//                                   Expanded(
//                                       child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(Icons.person,
//                                               color: ColorResources
//                                                   .primary,
//                                               size: 20),
//                                           const SizedBox(
//                                               width: Dimensions
//                                                   .marginSizeExtraSmall),
//                                           Text(
//                                               getTranslated(
//                                                   'LAST_NAME', context)!,
//                                               style: titilliumRegular)
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                           height: Dimensions.marginSizeSmall),
//                                       CustomTextField(
//                                         textInputType: TextInputType.name,
//                                         focusNode: _lNameFocus,
//                                         nextNode: _emailFocus,
//                                         hintText: profile.userInfoModel!.lName,
//                                         controller: _lastNameController,
//                                       ),
//                                     ],
//                                   )),
//                                 ],
//                               ),
//                             ),
//
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   top: Dimensions.marginSizeDefault,
//                                   left: Dimensions.marginSizeDefault,
//                                   right: Dimensions.marginSizeDefault),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.alternate_email,
//                                           color: ColorResources.getLightSkyBlue(
//                                               context),
//                                           size: 20),
//                                       const SizedBox(
//                                         width: Dimensions.marginSizeExtraSmall,
//                                       ),
//                                       Text(getTranslated('EMAIL', context)!,
//                                           style: titilliumRegular)
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                       height: Dimensions.marginSizeSmall),
//                                   CustomTextField(
//                                     textInputType: TextInputType.emailAddress,
//                                     focusNode: _emailFocus,
//                                     isEnable: false,
//                                     nextNode: _referalFocus,
//                                     fillColor: Theme.of(context)
//                                         .hintColor
//                                         .withOpacity(.12),
//                                     hintText:
//                                         profile.userInfoModel!.email ?? '',
//                                     controller: _emailController,
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             // Container(
//                             //   margin: const EdgeInsets.only(
//                             //     top: Dimensions.marginSizeDefault,
//                             //     left: Dimensions.marginSizeDefault,
//                             //     right: Dimensions.marginSizeDefault),
//                             //   child: Column(children: [
//                             //     InkWell(
//                             //       onTap: (){
//                             //         Share.share("Your referral code is ${profile.userInfoModel!.referral_code}");
//                             //       },
//                             //       child: Row(children: [
//                             //           const SizedBox(width: Dimensions.marginSizeExtraSmall,),
//                             //           Text(getTranslated('referral_code', context)!, style: titilliumRegular)
//                             //         ],
//                             //       ),
//                             //     ),
//                             //     const SizedBox(height: Dimensions.marginSizeSmall),
//                             //
//                             //     InkWell(
//                             //       onTap: (){
//                             //         Share.share("Your referral code is ${profile.userInfoModel!.referral_code}");
//                             //       },
//                             //       child: CustomTextField(textInputType: TextInputType.emailAddress,
//                             //         focusNode: _referalFocus,
//                             //         isEnable : false,
//                             //         nextNode: _phoneFocus,
//                             //         fillColor: Theme.of(context).hintColor.withOpacity(.12),
//                             //         hintText: profile.userInfoModel!.referral_code ?? '',
//                             //         controller: _referalController,
//                             //       ),
//                             //     ),
//                             //   ],
//                             //   ),
//                             // ),
//
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   top: Dimensions.marginSizeDefault,
//                                   left: Dimensions.marginSizeDefault,
//                                   right: Dimensions.marginSizeDefault),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.dialpad,
//                                           color: ColorResources.getLightSkyBlue(
//                                               context),
//                                           size: 20),
//                                       const SizedBox(
//                                           width:
//                                               Dimensions.marginSizeExtraSmall),
//                                       Text(getTranslated('PHONE_NO', context)!,
//                                           style: titilliumRegular)
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                       height: Dimensions.marginSizeSmall),
//                                   CustomTextField(
//                                     isReadOnly: true,
//                                     textInputType: TextInputType.phone,
//                                     focusNode: _phoneFocus,
//                                     hintText:
//                                         profile.userInfoModel!.phone ?? "",
//                                     nextNode: _addressFocus,
//                                     controller: _phoneController,
//                                     isPhoneNumber: true,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             InkWell(
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 8, right: 8),
//                                 child: Card(
//                                   elevation: null,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Container(
//                                     //
//                                     // margin: const EdgeInsets.only(
//                                     //     left: Dimensions.marginSizeDefault,
//                                     //     right: Dimensions.marginSizeDefault,
//                                     //     top: Dimensions.marginSizeSmall),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.location_on_outlined,
//                                           size: 20,
//                                         ),
//                                         SizedBox(
//                                           width: 15,
//                                         ),
//                                         Expanded(
//                                             child: Text(
//                                           _addressController.text == ''
//                                               ? 'Address'
//                                               : _addressController.text,
//                                           style: TextStyle(fontSize: 16),
//                                         )),
//                                       ],
//                                     ),
//                                     width: MediaQuery.sizeOf(context).width,
//                                     height: 50,
//                                     // CustomTextField(
//                                     //   hintText:'Address',
//                                     //   isReadOnly: true,
//                                     //   prefixIcon: const Icon(Icons.location_on_outlined),
//                                     //   // focusNode: _emailFocus,
//                                     //   // nextNode: _phoneFocus,
//                                     //   textInputType: TextInputType.text,
//                                     //   controller: _addressController,
//                                     // ),
//                                   ),
//                                 ),
//                               ),
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => PlacePicker(
//                                       apiKey: Platform.isAndroid
//                                           ? ""
//                                           : "",
//                                       onPlacePicked: (result) {
//                                         _addressController.text =
//                                             result.formattedAddress ?? '';
//                                         print(
//                                             'Full Address: ${result.formattedAddress}');
//
//                                         // Extract components from address
//                                         for (var component
//                                             in result.addressComponents!) {
//                                           if (component.types.contains(
//                                               'administrative_area_level_1')) {
//                                             _stateController.text =
//                                                 component.longName; // State
//                                           } else if (component.types
//                                               .contains('locality')) {
//                                             _cityController.text =
//                                                 component.longName; // City
//                                           } else if (component.types.contains(
//                                                   'sublocality_level_1') ||
//                                               component.types
//                                                   .contains('neighborhood')) {
//                                             _areaController.text =
//                                                 component.longName; // Area
//                                           } else if (component.types
//                                               .contains('postal_code')) {
//                                             _zipCodeController.text =
//                                                 component.longName; // Pincode
//                                           }
//                                         }
//
//                                         print(
//                                             'State: ${_stateController.text}');
//                                         print('City: ${_cityController.text}');
//                                         print('Area: ${_areaController.text}');
//                                         print(
//                                             'Pincode: ${_zipCodeController.text}');
//                                         // _addressController.text = result.formattedAddress.toString();
//                                         // lat = result.geometry!.location.lat;
//                                         _latController.text = result
//                                             .geometry!.location.lat
//                                             .toString();
//                                         _longController.text = result
//                                             .geometry!.location.lng
//                                             .toString();
//                                         // setState(() {
//                                         //
//                                         // });
//                                         Navigator.of(context).pop();
//                                       },
//                                       initialPosition:
//                                           const LatLng(22.719568, 75.857727),
//                                       useCurrentLocation: true,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                             // Consumer<LocationProvider>(
//                             //     builder: (context, locationProvider, child) {
//                             //   return Container(
//                             //     margin: const EdgeInsets.only(
//                             //         left: Dimensions.marginSizeDefault,
//                             //         right: Dimensions.marginSizeDefault,
//                             //         top: Dimensions.marginSizeSmall),
//                             //     decoration: BoxDecoration(
//                             //       border: null,
//                             //       color: Theme.of(context).highlightColor,
//                             //       borderRadius: BorderRadius.circular(6),
//                             //       boxShadow: [
//                             //         BoxShadow(
//                             //             color: Colors.grey.withOpacity(0.1),
//                             //             spreadRadius: 1,
//                             //             blurRadius: 3,
//                             //             offset: const Offset(
//                             //                 0, 1)) // changes position of shadow
//                             //       ],
//                             //     ),
//                             //     child: Column(
//                             //       children: [
//                             //         Provider.of<LocationProvider>(context,
//                             //                         listen: false)
//                             //                     .registerZipList
//                             //                     .length ==
//                             //                 0
//                             //             ? CustomTextField(
//                             //                 hintText:
//                             //                     getTranslated('zip', context),
//                             //                 textInputAction:
//                             //                     TextInputAction.next,
//                             //                 focusNode: _zipNode,
//                             //                 nextNode: _passwordFocus,
//                             //                 controller: _zipCodeController,
//                             //               )
//                             //             : Padding(
//                             //                 padding: const EdgeInsets.symmetric(
//                             //                     horizontal: 8.0),
//                             //                 child: DropdownSearch<
//                             //                     RegisterZipModel>(
//                             //                   selectedItem:
//                             //                       locationProvider.zipSelected,
//                             //                   items: locationProvider
//                             //                       .registerZipList,
//                             //                   itemAsString:
//                             //                       (RegisterZipModel u) =>
//                             //                           u.zipcode!,
//                             //                   onChanged: (value) async {
//                             //                     _zipCodeController.text =
//                             //                         value!.zipcode!;
//                             //                     print('fsafsafsafasf${_zipCodeController.text}');
//                             //                     await Provider.of<
//                             //                                 LocationProvider>(
//                             //                             context,
//                             //                             listen: false)
//                             //                         .getDeliveryRestrictedCityByZip(
//                             //                             context, value!.id!);
//                             //
//                             //                     if (Provider.of<LocationProvider>(
//                             //                                 context,
//                             //                                 listen: false)
//                             //                             .stateCityData !=
//                             //                         null) {
//                             //                       _stateController
//                             //                           .text = Provider.of<
//                             //                                   LocationProvider>(
//                             //                               context,
//                             //                               listen: false)
//                             //                           .stateCityData!
//                             //                           .data!
//                             //                           .state
//                             //                           .toString()!;
//                             //                       _cityController
//                             //                           .text = Provider.of<
//                             //                                   LocationProvider>(
//                             //                               context,
//                             //                               listen: false)
//                             //                           .stateCityData!
//                             //                           .data!
//                             //                           .city
//                             //                           .toString()!;
//                             //                     }
//                             //                   },
//                             //                   dropdownDecoratorProps:
//                             //                       const DropDownDecoratorProps(
//                             //                     dropdownSearchDecoration:
//                             //                         InputDecoration(
//                             //                             labelText: "Zip",
//                             //                             border:
//                             //                                 InputBorder.none),
//                             //                   ),
//                             //                 ),
//                             //               ),
//                             //       ],
//                             //     ),
//                             //   );
//                             // }),
//
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   left: Dimensions.marginSizeDefault,
//                                   right: Dimensions.marginSizeDefault,
//                                   top: Dimensions.marginSizeSmall),
//                               child: CustomTextField(
//                                 hintText:
//                                     getTranslated('ENTER_YOUR_STATE', context),
//                                 isReadOnly: true,
//                                 prefixIcon: const Icon(Icons.location_city),
//                                 // focusNode: _emailFocus,
//                                 // nextNode: _phoneFocus,
//                                 textInputType: TextInputType.text,
//                                 controller: _stateController,
//                               ),
//                             ),
//
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   left: Dimensions.marginSizeDefault,
//                                   right: Dimensions.marginSizeDefault,
//                                   top: Dimensions.marginSizeSmall),
//                               child: CustomTextField(
//                                 isReadOnly: true,
//                                 hintText:
//                                     getTranslated('ENTER_YOUR_CITY', context),
//                                 prefixIcon: const Icon(Icons.location_city),
//                                 // focusNode: _emailFocus,
//                                 // nextNode: _phoneFocus,
//                                 textInputType: TextInputType.text,
//                                 controller: _cityController,
//                               ),
//                             ),
//
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   top: Dimensions.marginSizeDefault,
//                                   left: Dimensions.marginSizeDefault,
//                                   right: Dimensions.marginSizeDefault),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.lock_open,
//                                           color: ColorResources.getPrimary(
//                                               context),
//                                           size: 20),
//                                       const SizedBox(
//                                           width:
//                                               Dimensions.marginSizeExtraSmall),
//                                       Text(getTranslated('PASSWORD', context)!,
//                                           style: titilliumRegular)
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                       height: Dimensions.marginSizeSmall),
//                                   CustomPasswordTextField(
//                                     controller: _passwordController,
//                                     focusNode: _passwordFocus,
//                                     nextNode: _confirmPasswordFocus,
//                                     textInputAction: TextInputAction.next,
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   top: Dimensions.marginSizeDefault,
//                                   left: Dimensions.marginSizeDefault,
//                                   right: Dimensions.marginSizeDefault),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.lock_open,
//                                           color: ColorResources.getPrimary(
//                                               context),
//                                           size: 20),
//                                       const SizedBox(
//                                           width:
//                                               Dimensions.marginSizeExtraSmall),
//                                       Text(
//                                           getTranslated(
//                                               'RE_ENTER_PASSWORD', context)!,
//                                           style: titilliumRegular)
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                       height: Dimensions.marginSizeSmall),
//                                   CustomPasswordTextField(
//                                     controller: _confirmPasswordController,
//                                     focusNode: _confirmPasswordFocus,
//                                     textInputAction: TextInputAction.done,
//                                   ),
//                                   const SizedBox(
//                                       height: Dimensions.marginSizeSmall),
//                                   // downloadInvoice(profile),
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeLarge),
//                                   InkWell(
//                                     onTap: () => showAnimatedDialog(
//                                         context,
//                                         SignOutConfirmationDialog(
//                                           isDelete: true,
//                                           customerId: profile.userInfoModel!.id,
//                                         ),
//                                         isFlip: true),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                             alignment: Alignment.center,
//                                             height: Dimensions.iconSizeSmall,
//                                             child: Image.asset(Images.delete)),
//                                         const SizedBox(
//                                           width: Dimensions.paddingSizeDefault,
//                                         ),
//                                         Text(
//                                           getTranslated(
//                                               'delete_account', context)!,
//                                           style: robotoRegular.copyWith(),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: Dimensions.marginSizeLarge,
//                           vertical: Dimensions.marginSizeSmall),
//                       child: !Provider.of<ProfileProvider>(context).isLoading
//                           ? CustomButton(
//                               onTap: _updateUserAccount,
//                               buttonText:
//                                   getTranslated('UPDATE_ACCOUNT', context))
//                           : Center(
//                               child: CircularProgressIndicator(
//                                   valueColor: AlwaysStoppedAnimation<Color>(
//                                       Theme.of(context).primaryColor))),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   downloadInvoice(ProfileProvider profile) {
//     return Card(
//       elevation: 0,
//       child: InkWell(
//           child: ListTile(
//             dense: true,
//             trailing: Icon(
//               Icons.keyboard_arrow_right,
//               color: Theme.of(context).primaryColor,
//             ),
//             leading: Icon(
//               Icons.receipt,
//               color: Theme.of(context).primaryColor,
//             ),
//             title: Text(
//               "Download Id Card",
//               style: Theme.of(context)
//                   .textTheme
//                   .subtitle2!
//                   .copyWith(color: Theme.of(context).colorScheme.surfaceTint),
//             ),
//           ),
//           onTap: () async {
//             try {
//               DateTime date = DateFormat('yyyy-MM-dd')
//                   .parse(profile.userInfoModel!.plan_expire_date!);
//               if (date.isBefore(DateTime.now())) {
//                 showCustomSnackBar("Please purchase plan", Get.context!);
//               } else {
//                 _launchUrl(Uri.parse(profile.userInfoModel!.certificate!));
//               }
//             } catch (e) {
//               showCustomSnackBar("Please purchase plan", Get.context!);
//               print(e);
//             }
//
// //             final plugin = DeviceInfoPlugin();
// //             final android = await plugin.androidInfo;
// //             print("++++++++++++");
// //             var status = android.version.sdkInt! < 33
// //                 ? await Permission.storage.request()
// //                 : PermissionStatus.granted;
// //
// //             // status = await Permission.storage.request();
// //             //await Permission.storage.request();
// //             print("++++++++++++${status}");
// //             if (status == PermissionStatus.granted) {
// //               if (mounted) {
// //                 setState(() {
// //                   _isProgress = true;
// //                 });
// //               }
// //               var targetPath;
// //
// //               if (Platform.isIOS) {
// //                 var target = await getApplicationDocumentsDirectory();
// //                 targetPath = target.path.toString();
// //               } else {
// //                 var downloadsDirectory =
// //                     await getApplicationDocumentsDirectory();
// //                 // = await DownloadsPathProvider.downloadsDirectory;
// //                 targetPath = downloadsDirectory!.path.toString();
// //               }
// //
// //               var targetFileName = "Invoice_${"widget.model!.id"}";
// //               var generatedPdfFile, filePath;
// //
// //               try {
// //                 generatedPdfFile =
// //                     await FlutterHtmlToPdf.convertFromHtmlContent("""
// // <!DOCTYPE html>
// // <html>
// // <head>
// //   <style>
// //   table, th, td {
// //     border: 1px solid black;
// //     border-collapse: collapse;
// //   }
// //   th, td, p {
// //     padding: 5px;
// //     text-align: left;
// //   }
// //   </style>
// // </head>
// //   <body>
// //     <h2>PDF Generated with flutter_html_to_pdf plugin</h2>
// //     <table style="width:100%">
// //       <caption>Sample HTML Table</caption>
// //       <tr>
// //         <th>Month</th>
// //         <th>Savings</th>
// //       </tr>
// //       <tr>
// //         <td>January</td>
// //         <td>100</td>
// //       </tr>
// //       <tr>
// //         <td>February</td>
// //         <td>50</td>
// //       </tr>
// //     </table>
// //     <p>Image loaded from web</p>
// //     <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
// //   </body>
// // </html>
// // """, targetPath, targetFileName);
// //                 filePath = generatedPdfFile.path;
// //               } on Exception {
// //                 //  filePath = targetPath + "/" + targetFileName + ".html";
// //                 generatedPdfFile =
// //                     await FlutterHtmlToPdf.convertFromHtmlContent("""
// // <!DOCTYPE html>
// // <html>
// // <head>
// //   <style>
// //   table, th, td {
// //     border: 1px solid black;
// //     border-collapse: collapse;
// //   }
// //   th, td, p {
// //     padding: 5px;
// //     text-align: left;
// //   }
// //   </style>
// // </head>
// //   <body>
// //     <h2>PDF Generated with flutter_html_to_pdf plugin</h2>
// //     <table style="width:100%">
// //       <caption>Sample HTML Table</caption>
// //       <tr>
// //         <th>Month</th>
// //         <th>Savings</th>
// //       </tr>
// //       <tr>
// //         <td>January</td>
// //         <td>100</td>
// //       </tr>
// //       <tr>
// //         <td>February</td>
// //         <td>50</td>
// //       </tr>
// //     </table>
// //     <p>Image loaded from web</p>
// //     <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
// //   </body>
// // </html>
// // """, targetPath, targetFileName);
// //                 filePath = generatedPdfFile.path;
// //               }
// //
// //               if (mounted) {
// //                 setState(() {
// //                   _isProgress = false;
// //                 });
// //               }
// //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                 content: Text(
// //                   "Invoice Path $targetFileName",
// //                   textAlign: TextAlign.center,
// //                   style:
// //                       TextStyle(color: Theme.of(context).colorScheme.onError),
// //                 ),
// //                 action: SnackBarAction(
// //                     label: "View",
// //                     textColor: Theme.of(context).colorScheme.primary,
// //                     onPressed: () async {
// //                       final result = await OpenFilex.open(filePath);
// //                       print("object${result.message}");
// //                     }),
// //                 backgroundColor:
// //                     Theme.of(context).colorScheme.onSecondaryContainer,
// //                 elevation: 1.0,
// //               ));
// //             }
//           }),
//     );
//   }
//
//   Future<void> _launchUrl(Uri url) async {
//     print("object $url");
//     await canLaunchUrl(url)
//         ? await launchUrl(url)
//         : throw 'Could not launch $url';
//   }
// }
