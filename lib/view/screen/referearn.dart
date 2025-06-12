import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../provider/profile_provider.dart';
import '../basewidget/custom_app_bar.dart';

class ReferAEarn extends StatefulWidget {
  const ReferAEarn();

  @override
  State<ReferAEarn> createState() => _ReferAEarnState();
}

class _ReferAEarnState extends State<ReferAEarn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: CustomAppBar(
            title: "Refer & Earn",
            isBackButtonExist: true,
            isSkip: false,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("REFER AND EARN EXCITING AMOUNT"),
            SizedBox(
              height: 15,
            ),
            Image.asset(Images.referPage, height: Dimensions.splashLogoWidth),
            SizedBox(
              height: 15,
            ),
            Text("Referal Code", style: titilliumSemiBold),
            SizedBox(
              height: 15,
            ),
            Consumer<ProfileProvider>(builder: (context, profile, child) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 55),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5)
                        ],
                      ),
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          onPressed: () {},
                          child: Text(
                            "${profile.userInfoModel!.referral_code}",
                            style: robotoBoldRed,
                          )),
                    ),
                  ),
                ],
              );
            }),

            SizedBox(
              height: 25,
            ),

            /// Sharing
            Consumer<ProfileProvider>(builder: (context, profile, child) {
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Share.share(
                            "Your referral code is ${profile.userInfoModel!.referral_code}");
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                        ),
                        width: MediaQuery.of(context).size.width - 50,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () {
                              Share.share(
                                  "Your referral code is ${profile.userInfoModel!.referral_code}");
                            },
                            child: Text(
                              "Share",
                              style: robotoBoldwhite,
                            )),
                      ),
                    ),
                  ),
                ],
              );
            }),
            // Expanded(
            //   child: ElevatedButton(onPressed: () {}, child: Text("Share")),
            // )
          ],
        ),
      ),
    );
  }
}
