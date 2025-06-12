import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/referal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:provider/provider.dart';

import '../notification/notification_screen.dart';

class ReferealsScreen extends StatefulWidget {
  const ReferealsScreen({Key? key}) : super(key: key);

  @override
  State<ReferealsScreen> createState() => _ReferealsScreenState();
}

class _ReferealsScreenState extends State<ReferealsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ReferalProvider>(context, listen: false)
        .initReferalList(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: CustomAppBar(
              title: getTranslated('referrals', context),
              isBackButtonExist: true)),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ReferalProvider>(
              builder: (context, notification, child) {
                return notification.notificationList != null
                    ? notification.notificationList!.isNotEmpty
                        ? RefreshIndicator(
                            backgroundColor: Theme.of(context).highlightColor,
                            onRefresh: () async {
                              await Provider.of<ReferalProvider>(context,
                                      listen: false)
                                  .initReferalList(context);
                            },
                            child:
                                //     Expanded(
                                //
                                //       child:
                                ListView.builder(
                              shrinkWrap: true, //
                              itemCount: notification.notificationList!.length,
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeSmall),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // showDialog(context: context, builder: (context) =>
                                    //   NotificationDialog(notificationModel: notification.notificationList![index]));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    margin: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                      color: ColorResources.getImageBg(context),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorResources.getSellerTxt(
                                              context),
                                          width: 2),
                                    ),
                                    child: ListTile(
                                      leading: ClipOval(
                                          child: FadeInImage.assetNetwork(
                                        placeholder: Images.placeholder,
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                        image:
                                            'https://randomuser.me/api/portraits/men/79',
                                        // image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.notificationImageUrl}/${notification.notificationList![index].image}',
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(Images.maintenance,
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover),
                                      )),
                                      title: Text(
                                          "${notification.notificationList![index].referralName}",
                                          style: titilliumRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                          )),
                                      subtitle: Text(
                                          "${notification.notificationList![index].type}"),
                                      trailing: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 11,
                                          minHeight: 11,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 1, left: 5, right: 5),
                                          child: Text(
                                            "₹ ${notification.notificationList![index].amount}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      //   style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.getHint(context)),
                                      // ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const NoInternetOrDataScreen(isNoInternet: false)
                    : const NotificationShimmer();
              },
            ),
          )
        ],
      ),
    );
  }
}
