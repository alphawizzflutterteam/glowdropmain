import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/notification_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/referal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ReferalProvider>(context, listen: false).initBonusList(context);
    Provider.of<ReferalProvider>(context, listen: false)
        .initEarningsList(context);
    Provider.of<ReferalProvider>(context, listen: false)
        .initReferalList(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: CustomAppBar(
              title: getTranslated('earnings', context),
              isBackButtonExist: true)),

      body: Column(
        children: [
          TabBar(
            isScrollable: true,
            labelColor: Theme.of(context).primaryColor,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: 'Referral Earnings'),
              Tab(text: 'Daily Earnings'),
              Tab(text: 'Bonus Earnings'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                listReferalview(),
                listview(),
                listbonus()
                // Card(
                //   margin: const EdgeInsets.all(16.0),
                //   child: Center(child: Text(': Overview tab')),
                // ),
                // Card(
                //   margin: const EdgeInsets.all(16.0),
                //   child: Center(
                //       child: Text(': Specifications tab')),
                // ),
              ],
            ),
          )
        ],
      ),

      /// Here List
    );
  }

  Widget listbonus() {
    return Consumer<ReferalProvider>(
      builder: (context, notification, child) {
        return notification.bonusList != null
            ? notification.bonusList!.isNotEmpty
                ? RefreshIndicator(
                    backgroundColor: Theme.of(context).highlightColor,
                    onRefresh: () async {
                      await Provider.of<ReferalProvider>(context, listen: false)
                          .initReferalList(context);
                    },
                    child: ListView.builder(
                      shrinkWrap: true, //
                      itemCount: notification.bonusList!.length,
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
                                  "${notification.bonusList![index].referralName}",
                                  style: titilliumSemiBold),
                              subtitle: Text(
                                  "Your Level ${notification.bonusList![index].level} Earning",
                                  style: robotoRegular),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  const Text(
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
                                    constraints: const BoxConstraints(
                                      minWidth: 11,
                                      minHeight: 11,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 1, left: 5, right: 5),
                                      child: Text(
                                        "₹ ${notification.bonusList![index].amount}",
                                        style: const TextStyle(
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
        return notification.earningsList != null
            ? notification.earningsList!.isNotEmpty
                ? RefreshIndicator(
                    backgroundColor: Theme.of(context).highlightColor,
                    onRefresh: () async {
                      await Provider.of<ReferalProvider>(context, listen: false)
                          .initReferalList(context);
                    },
                    child: ListView.builder(
                      shrinkWrap: true, //
                      itemCount: notification.earningsList!.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeSmall),
                      itemBuilder: (context, index) {
                        String dateTimeString =
                            "${notification.earningsList![index].createdAt}";
                        DateTime dateTime = DateTime.parse(dateTimeString);
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(dateTime);
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
                              title: const Text("Amount",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                              subtitle: Text(
                                  "₹ ${notification.earningsList![index].amount}",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  const Text(
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
                                    constraints: const BoxConstraints(
                                      minWidth: 11,
                                      minHeight: 11,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 1, left: 5, right: 5),
                                      child: Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
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
        return notification.notificationList != null
            ? notification.notificationList!.isNotEmpty
                ? RefreshIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
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
                                  "${notification.notificationList![index].referralName}",
                                  style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                  )),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${notification.notificationList![index].type}"),
                                  Text(
                                      "Level: ${notification.notificationList![index].level}",
                                      style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                      )),
                                ],
                              ),
                              trailing: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 11,
                                  minHeight: 11,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 1, left: 5, right: 5),
                                  child: Text(
                                    "₹ ${notification.notificationList![index].amount}",
                                    style: const TextStyle(
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
