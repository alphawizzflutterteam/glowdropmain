import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/notification_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/referal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/images.dart';
import '../../basewidget/no_internet_screen.dart';

class RepurchaseHistory extends StatefulWidget {
  const RepurchaseHistory();

  @override
  State<RepurchaseHistory> createState() => _RepurchaseHistoryState();
}

class _RepurchaseHistoryState extends State<RepurchaseHistory>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ReferalProvider>(context, listen: false)
        .initRepurchaseReferalList(context);
    Provider.of<ReferalProvider>(context, listen: false)
        .initRepurchaseBonusList(context);
    Provider.of<ReferalProvider>(context, listen: false)
        .initRepurchaseREBonusList(context);
    Provider.of<ReferalProvider>(context, listen: false)
        .initRepurchaseFrechEarningsList(context);

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: CustomAppBar(
              title: "Repurchase History", isBackButtonExist: true)),

      body: Column(
        children: [
          TabBar(
            isScrollable: true,
            controller: _tabController,
            labelColor: Theme.of(context).primaryColor,
            tabs: const <Widget>[
              Tab(text: 'Self Purchase Bonus'),
              Tab(text: 'Bonus'),
              Tab(text: 'Repurchase Bonus'),
              Tab(text: 'frenchise Withdrawal income '),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                listReferalview(),
                listview(),
                listbonus(),
                listfrnch()
              ],
            ),
          )
        ],
      ),

      /// Here List
    );
  }

  Widget listfrnch() {
    return Consumer<ReferalProvider>(
      builder: (context, notification, child) {
        return notification.frenchRepurchaseList != null
            ? notification.frenchRepurchaseList!.isNotEmpty
                ? RefreshIndicator(
                    backgroundColor: Theme.of(context).highlightColor,
                    onRefresh: () async {
                      await Provider.of<ReferalProvider>(context, listen: false)
                          .initReferalList(context);
                    },
                    child: ListView.builder(
                      shrinkWrap: true, //
                      itemCount: notification.frenchRepurchaseList!.length,
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
                            margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              color: ColorResources.getImageBg(context),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorResources.getSellerTxt(context),
                                  width: 2),
                            ),
                            // margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,left: 10,right: 10),
                            // // color: Theme.of(context).cardColor,
                            // decoration: BoxDecoration(
                            //   color: Colors.white,
                            //   borderRadius: BorderRadius.circular(10),
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Colors.grey.withOpacity(0.5),
                            //       spreadRadius: 5,
                            //       blurRadius: 7,
                            //       offset: Offset(0, 3), // changes position of shadow
                            //     ),
                            //   ],
                            // ),
                            child: ListTile(
                              leading: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder, height: 50,
                                width: 50, fit: BoxFit.cover,
                                image:
                                    'https://randomuser.me/api/portraits/men/79', //.jpg
                                // image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.notificationImageUrl}/${notification.notificationList![index].image}',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                    Images.safePayment,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover),
                              )),
                              title: Text(
                                  "${notification.frenchRepurchaseList![index].referralName}",
                                  style: titilliumSemiBold),
                              subtitle: Text(
                                  "Your Level ${notification.frenchRepurchaseList![index].level} Earning",
                                  style: robotoRegular),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Text(
                                    "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 11,
                                      minHeight: 11,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 1, left: 5, right: 5),
                                      child: Text(
                                        "₹ ${notification.frenchRepurchaseList![index].amount}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // subtitle: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(notification.notificationList![index].createdAt!)),
                              //   style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.getHint(context)),
                              // ),
                            ),
                          ),
                        );
                      },
                    ))
                : const NoInternetOrDataScreen(isNoInternet: false)
            : const NotificationShimmer();
      },
    );
  }

  Widget listbonus() {
    return Consumer<ReferalProvider>(
      builder: (context, notification, child) {
        return notification.rebonusRepurchaseList != null
            ? notification.rebonusRepurchaseList!.isNotEmpty
                ? RefreshIndicator(
                    backgroundColor: Theme.of(context).highlightColor,
                    onRefresh: () async {
                      await Provider.of<ReferalProvider>(context, listen: false)
                          .initReferalList(context);
                    },
                    child: ListView.builder(
                      shrinkWrap: true, //
                      itemCount: notification.rebonusRepurchaseList!.length,
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
                            margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              color: ColorResources.getImageBg(context),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorResources.getSellerTxt(context),
                                  width: 2),
                            ),
                            // margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,left: 10,right: 10),
                            // // color: Theme.of(context).cardColor,
                            // decoration: BoxDecoration(
                            //   color: Colors.white,
                            //   borderRadius: BorderRadius.circular(10),
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Colors.grey.withOpacity(0.5),
                            //       spreadRadius: 5,
                            //       blurRadius: 7,
                            //       offset: Offset(0, 3), // changes position of shadow
                            //     ),
                            //   ],
                            // ),
                            child: ListTile(
                              leading: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder, height: 50,
                                width: 50, fit: BoxFit.cover,
                                image:
                                    'https://randomuser.me/api/portraits/men/79', //.jpg
                                // image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.notificationImageUrl}/${notification.notificationList![index].image}',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                    Images.safePayment,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover),
                              )),
                              title: Text(
                                  "${notification.rebonusRepurchaseList![index].referralName}",
                                  style: titilliumSemiBold),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${notification.rebonusRepurchaseList?[index].type ?? ''}"),
                                  Text(
                                      "Level: ${notification.rebonusRepurchaseList?[index].level}",
                                      style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                      )),
                                ],
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Text(
                                    "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 11,
                                      minHeight: 11,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 1, left: 5, right: 5),
                                      child: Text(
                                        "₹ ${notification.rebonusRepurchaseList![index].amount}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // subtitle: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(notification.notificationList![index].createdAt!)),
                              //   style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.getHint(context)),
                              // ),
                            ),
                          ),
                        );
                      },
                    ))
                : const NoInternetOrDataScreen(isNoInternet: false)
            : const NotificationShimmer();
      },
    );
  }

  Widget listview() {
    return Consumer<ReferalProvider>(
      builder: (context, notification, child) {
        return notification.bonusRepurchaseList != null
            ? notification.bonusRepurchaseList!.isNotEmpty
                ? RefreshIndicator(
                    backgroundColor: Theme.of(context).highlightColor,
                    onRefresh: () async {
                      await Provider.of<ReferalProvider>(context, listen: false)
                          .initReferalList(context);
                    },
                    child: ListView.builder(
                      shrinkWrap: true, //
                      itemCount: notification.bonusRepurchaseList!.length,
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
                            margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              color: ColorResources.getImageBg(context),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorResources.getSellerTxt(context),
                                  width: 2),
                            ),
                            // margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,left: 10,right: 10),
                            // // color: Theme.of(context).cardColor,
                            // decoration: BoxDecoration(
                            //   color: Colors.white,
                            //   borderRadius: BorderRadius.circular(10),
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Colors.grey.withOpacity(0.5),
                            //       spreadRadius: 5,
                            //       blurRadius: 7,
                            //       offset: Offset(0, 3), // changes position of shadow
                            //     ),
                            //   ],
                            // ),
                            child: ListTile(
                              leading: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder, height: 50,
                                width: 50, fit: BoxFit.cover,
                                image:
                                    'https://randomuser.me/api/portraits/men/79', //.jpg
                                // image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.notificationImageUrl}/${notification.notificationList![index].image}',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                    Images.safePayment,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover),
                              )),
                              title: Text(
                                  "${notification.bonusRepurchaseList![index].referralName}",
                                  style: titilliumSemiBold),
                              subtitle: Text("Your bonus Earning",
                                  style: robotoRegular),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Text(
                                    "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 11,
                                      minHeight: 11,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 1, left: 5, right: 5),
                                      child: Text(
                                        "₹ ${notification.bonusRepurchaseList![index].amount}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // subtitle: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(notification.notificationList![index].createdAt!)),
                              //   style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.getHint(context)),
                              // ),
                            ),
                          ),
                        );
                      },
                    ))
                : const NoInternetOrDataScreen(isNoInternet: false)
            : const NotificationShimmer();
      },
    );
  }

  Widget listReferalview() {
    return Consumer<ReferalProvider>(
      builder: (context, notification, child) {
        return notification.selfRepurchaseList != null
            ? notification.selfRepurchaseList!.isNotEmpty
                ? RefreshIndicator(
                    backgroundColor: Theme.of(context).highlightColor,
                    onRefresh: () async {
                      await Provider.of<ReferalProvider>(context, listen: false)
                          .initReferalList(context);
                    },
                    child:
                        //     Expanded(
                        //
                        //       child:
                        ListView.builder(
                      shrinkWrap: true, //
                      itemCount: notification.selfRepurchaseList!.length,
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
                                  color: ColorResources.getSellerTxt(context),
                                  width: 2),
                            ),
                            child: ListTile(
                              leading: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder, height: 50,
                                width: 50, fit: BoxFit.cover,
                                image:
                                    'https://randomuser.me/api/portraits/men/79',
                                // image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.notificationImageUrl}/${notification.notificationList![index].image}',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                    Images.maintenance,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover),
                              )),
                              title: Text(
                                  "${notification.selfRepurchaseList![index].referralName}",
                                  style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                  )),
                              subtitle: Text(
                                  "${notification.selfRepurchaseList![index].type}"),
                              trailing: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 11,
                                  minHeight: 11,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 1, left: 5, right: 5),
                                  child: Text(
                                    "₹ ${notification.selfRepurchaseList![index].amount}",
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
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          color: ColorResources.getGrey(context),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled:
                Provider.of<NotificationProvider>(context).notificationList ==
                    null,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.white),
              subtitle:
                  Container(height: 10, width: 50, color: ColorResources.white),
            ),
          ),
        );
      },
    );
  }
}
