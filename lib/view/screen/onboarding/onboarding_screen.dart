import 'package:flutter/material.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/onboarding_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

import '../../../utill/color_resources.dart';
import '../../basewidget/button/custom_button.dart';
import '../background_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  OnBoardingScreen({Key? key,
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  }) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Provider.of<OnBoardingProvider>(context, listen: false).initBoardingList(context);


    double height = MediaQuery.of(context).size.height;

    return
      Scaffold(
        extendBodyBehindAppBar: true, // This allows content to extend behind app bar

        body: Stack(
        children: [ // Background image fills the whole screen
          SizedBox.expand(
            child: Container(
              child: Image.asset(
                "assets/images/background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 130,),
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/logo_image.png",
                      // width: 200, // adjust as needed
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 80 / 100,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Glow starts here – Your beauty, your way with GlowDrop!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: ColorResources.primary,
                          // Use your custom color here
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),

                  Center(
                    child: CustomButton(
                      text: "Get Started",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => loginFirstView()), // Replace with your screen
                        );
                        // Add your navigation or logic here
                      },
                    ),

                  )
                ]

            ),
          ),
        ],
      ),
    );
    //   Scaffold(
    //   body: Stack(
    //     clipBehavior: Clip.none,
    //     children: [
    //       Provider.of<ThemeProvider>(context).darkTheme ? const SizedBox() : SizedBox(
    //         width: double.infinity,
    //         height: double.infinity,
    //         child: Image.asset(Images.background, fit: BoxFit.fill),
    //       ),
    //       Consumer<OnBoardingProvider>(
    //         builder: (context, onBoardingList, child) => ListView(
    //           children: [
    //             SizedBox(
    //               height: height*0.7,
    //               child: PageView.builder(
    //                 itemCount: onBoardingList.onBoardingList.length,
    //                 controller: _pageController,
    //                 itemBuilder: (context, index) {
    //                   return Padding(
    //                     padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
    //                     child: Column(
    //                       children: [
    //                         Image.asset(onBoardingList.onBoardingList[index].imageUrl, height: height*0.5),
    //                         Text(onBoardingList.onBoardingList[index].title, style: titilliumBold.copyWith(fontSize: height*0.035), textAlign: TextAlign.center),
    //                         Text(onBoardingList.onBoardingList[index].description, textAlign: TextAlign.center, style: titilliumRegular.copyWith(
    //                           fontSize: height*0.015,
    //                         )),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //                 onPageChanged: (index) {
    //                   onBoardingList.changeSelectIndex(index);
    //                 },
    //               ),
    //             ),
    //             Column(
    //               children: [
    //                 const SizedBox(height: 50),
    //                 Padding(
    //                   padding: const EdgeInsets.only(bottom: 20),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: _pageIndicators(onBoardingList.onBoardingList, context),
    //                   ),
    //                 ),
    //                 Container(
    //                   height: 45,
    //                   margin: const EdgeInsets.symmetric(horizontal: 70, vertical: Dimensions.paddingSizeSmall),
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(6),
    //                       gradient: LinearGradient(colors: [
    //                         Theme.of(context).primaryColor,
    //                         Theme.of(context).primaryColor,
    //                         Theme.of(context).primaryColor,
    //                       ])),
    //                   child: TextButton(
    //                     onPressed: () {
    //                       if (Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex == onBoardingList.onBoardingList.length - 1) {
    //                         Provider.of<SplashProvider>(context, listen: false).disableIntro();
    //                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));
    //                       } else {
    //                         _pageController.animateToPage(Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex+1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    //                       }
    //                     },
    //                     child: Container(
    //                       width: double.infinity,
    //                       alignment: Alignment.center,
    //                       child: Text(onBoardingList.selectedIndex == onBoardingList.onBoardingList.length - 1
    //                           ? getTranslated('GET_STARTED', context)! : getTranslated('NEXT', context)!,
    //                           style: titilliumSemiBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  List<Widget> _pageIndicators(var onBoardingList, BuildContext context) {
    List<Container> indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      indicators.add(
        Container(
          width: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? 18 : 7,
          height: 7,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return indicators;
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 90 / 100,
      // Fixed width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorResources.primary,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class loginFirstView extends StatefulWidget {
  // const loginFirstView({super.key});

  @override
  State<loginFirstView> createState() => _loginFirstViewState();
}

class _loginFirstViewState extends State<loginFirstView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Column(
          children: [
            // SizedBox(height: 50,),
            CustomButton(
              text: "Sign Up",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ), // Replace with your screen
                );
                // Add your navigation or logic here
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 1 / 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Gradient Line
                Container(
                  width: MediaQuery.of(context).size.width * 35 / 100,
                  height: 2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x4D999999), // 4D = 30% opacity

                        Color(0xFFA973C2),
                      ],
                    ),
                  ),
                ),

                // const SizedBox(width: 10),

                const Text(
                  "Or",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorResources.textPrimary,
                  ),
                ),

                // const SizedBox(width: 10),

                // Right Gradient Line
                Container(
                  width: MediaQuery.of(context).size.width * 35 / 100,
                  height: 2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFA973C2), Color(0x4D999999)],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/google_login.png", fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/facebook_login.png", fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),

            RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: const TextStyle(
                  color: ColorResources.loginText,
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Login!',
                    style: const TextStyle(
                      color: ColorResources.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
