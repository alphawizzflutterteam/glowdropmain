import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wallet_transaction_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/widget/send_money_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/widget/transaction_list_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../withdraw_request/withdrawscreen.dart';

class WalletScreen extends StatelessWidget {
  final bool isBacButtonExist;
  const WalletScreen({Key? key, this.isBacButtonExist = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    bool darkMode =
        Provider.of<ThemeProvider>(context, listen: false).darkTheme;
    bool isFirstTime = true;
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (isFirstTime) {
      if (!isGuestMode) {
        Provider.of<ProfileProvider>(context, listen: false)
            .getUserInfo(context);
        Provider.of<WalletTransactionProvider>(context, listen: false)
            .getTransactionList(context, 1);
      }

      isFirstTime = false;
    }

    return Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        body: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            Provider.of<WalletTransactionProvider>(context, listen: false)
                .getTransactionList(context, 1, reload: true);
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                iconTheme:
                    IconThemeData(color: ColorResources.getTextTitle(context)),
                backgroundColor: Theme.of(context).cardColor,
                title: Text(
                  getTranslated('wallet', context)! + "",
                  style: TextStyle(color: ColorResources.getTextTitle(context)),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    isGuestMode
                        ? const NotLoggedInWidget()
                        : Column(
                            children: [
                              Consumer<WalletTransactionProvider>(
                                  builder: (context, profile, _) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.85,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.28,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeSmall),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      darkMode ? 900 : 200]!,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.3)
                                            ],
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: Dimensions
                                                            .iconSizeDefault,
                                                        height: Dimensions
                                                            .iconSizeDefault,
                                                        child: Image.asset(
                                                            Images.wallet)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Fund Wallet",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall)),
                                                    const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeSmall,
                                                    ),
                                                    Text(
                                                        PriceConverter.convertPrice(
                                                            context,
                                                            (profile.walletBalance!
                                                                            .total_fund_wallet !=
                                                                        null &&
                                                                    profile.walletBalance!
                                                                            .total_fund_wallet !=
                                                                        null)
                                                                ? profile
                                                                        .walletBalance!
                                                                        .total_fund_wallet ??
                                                                    0
                                                                : 0),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeDefault)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: Dimensions
                                                      .iconSizeDefault,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.85,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.28,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeSmall),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      darkMode ? 900 : 200]!,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.3)
                                            ],
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: Dimensions
                                                            .iconSizeDefault,
                                                        height: Dimensions
                                                            .iconSizeDefault,
                                                        child: Icon(
                                                          Icons.currency_rupee,
                                                          color: Colors.white,
                                                        )
                                                        // Image.asset(
                                                        //     Images.wallet)
                                                        ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFEEF6FF),
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .paddingSizeSmall)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          SendMoneyScreen(
                                                                            amount:
                                                                                profile.walletBalance!.total_fund_wallet,
                                                                          )));
                                                            },
                                                            // onTap: () => showModalBottomSheet(
                                                            //     backgroundColor:
                                                            //     Colors
                                                            //         .transparent,
                                                            //     isScrollControlled:
                                                            //     true,
                                                            //     context:
                                                            //     context,
                                                            //     builder: (_) => CustomEditDialog(
                                                            //         "daily",
                                                            //         profile
                                                            //             .walletBalance!
                                                            //             .total_daily_bonus)),
                                                            child: Text(
                                                                "Send Money",
                                                                style: titilliumRegular.copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeDefault)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeSmall,
                                                    ),
                                                    // Text(
                                                    //     PriceConverter.convertPrice(
                                                    //         context,
                                                    //         (profile.walletBalance!
                                                    //                         .total_fund_wallet !=
                                                    //                     null &&
                                                    //                 profile.walletBalance!
                                                    //                         .total_fund_wallet !=
                                                    //                     null)
                                                    //             ? profile
                                                    //                     .walletBalance!
                                                    //                     .total_fund_wallet ??
                                                    //                 0
                                                    //             : 0),
                                                    //     style: const TextStyle(
                                                    //         fontWeight:
                                                    //             FontWeight.w700,
                                                    //         color: Colors.white,
                                                    //         fontSize: Dimensions
                                                    //             .fontSizeDefault)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: Dimensions
                                                      .iconSizeDefault,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: Dimensions.paddingSizeDefault,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.85,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.28,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeSmall),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      darkMode ? 900 : 200]!,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.3)
                                            ],
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: Dimensions
                                                            .iconSizeDefault,
                                                        height: Dimensions
                                                            .iconSizeDefault,
                                                        child: Image.asset(
                                                            Images.wallet)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        getTranslated(
                                                            'wallet_amount',
                                                            context)!,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall)),
                                                    const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeSmall,
                                                    ),
                                                    Text(
                                                        PriceConverter.convertPrice(
                                                            context,
                                                            (profile.walletBalance !=
                                                                        null &&
                                                                    profile.walletBalance!
                                                                            .totalWalletBalance !=
                                                                        null)
                                                                ? profile
                                                                        .walletBalance!
                                                                        .totalWalletBalance ??
                                                                    0
                                                                : 0),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeDefault)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: Dimensions
                                                      .iconSizeDefault,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.paddingSizeSmall,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.85,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.28,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeSmall),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      darkMode ? 900 : 200]!,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.3)
                                            ],
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: Dimensions
                                                            .iconSizeDefault,
                                                        height: Dimensions
                                                            .iconSizeDefault,
                                                        child: Image.asset(
                                                            Images
                                                                .loyaltyPoint)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        getTranslated(
                                                            'total_daily_bonus',
                                                            context)!,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall)),
                                                    const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeSmall,
                                                    ),
                                                    Text(
                                                        PriceConverter.convertPrice(
                                                            context,
                                                            (profile.walletBalance !=
                                                                        null &&
                                                                    profile.walletBalance!
                                                                            .totalWalletBalance !=
                                                                        null)
                                                                ? profile
                                                                        .walletBalance!
                                                                        .total_daily_bonus ??
                                                                    0
                                                                : 0),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeDefault)),
                                                    InkWell(
                                                      onTap: () => showModalBottomSheet(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          isScrollControlled:
                                                              true,
                                                          context: context,
                                                          builder: (_) =>
                                                              CustomEditDialog(
                                                                  "daily",
                                                                  profile
                                                                      .walletBalance!
                                                                      .total_daily_bonus)),
                                                      child: Container(
                                                        height: 35,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xFFEEF6FF),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .paddingSizeSmall)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () => showModalBottomSheet(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  isScrollControlled:
                                                                      true,
                                                                  context:
                                                                      context,
                                                                  builder: (_) => CustomEditDialog(
                                                                      "daily",
                                                                      profile
                                                                          .walletBalance!
                                                                          .total_daily_bonus)),
                                                              child: Text(
                                                                  "Withdraw",
                                                                  style: titilliumRegular.copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeDefault)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.paddingSizeDefault,
                                    ),

                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.5,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeSmall),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeSmall),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.paddingSizeSmall),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors
                                                  .grey[darkMode ? 900 : 200]!,
                                              spreadRadius: 0.5,
                                              blurRadius: 0.3)
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: Dimensions.logoHeight,
                                                  height: Dimensions.logoHeight,
                                                  child: Image.asset(
                                                      Images.loyaltyTrophy)),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      getTranslated(
                                                          'total_referral_bonus',
                                                          context)!,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                          fontSize: Dimensions
                                                              .fontSizeLarge)),
                                                  const SizedBox(
                                                    height: Dimensions
                                                        .paddingSizeSmall,
                                                  ),
                                                  Text(
                                                      PriceConverter.convertPrice(
                                                          context,
                                                          (profile.walletBalance !=
                                                                      null &&
                                                                  profile.walletBalance!
                                                                          .totalWalletBalance !=
                                                                      null)
                                                              ? profile
                                                                      .walletBalance!
                                                                      .total_referral_bonus ??
                                                                  0
                                                              : 0),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
                                                          fontSize: Dimensions
                                                              .fontSizeOverLarge)),
                                                  InkWell(
                                                    onTap: () => showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        isScrollControlled:
                                                            true,
                                                        context: context,
                                                        builder: (_) =>
                                                            CustomEditDialog(
                                                                "referral",
                                                                profile
                                                                    .walletBalance!
                                                                    .total_referral_bonus)),
                                                    child: Container(
                                                      height: 40,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFEEF6FF),
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .paddingSizeSmall)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: InkWell(
                                                              onTap: () => showModalBottomSheet(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  isScrollControlled:
                                                                      true,
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      CustomEditDialog(
                                                                          "referral",
                                                                          profile
                                                                              .walletBalance!
                                                                              .total_referral_bonus)),
                                                              child: Text(
                                                                  "Withdraw ",
                                                                  style: titilliumRegular.copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeDefault)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: Dimensions.logoHeight,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.paddingSizeDefault,
                                    ),

                                    ///
                                    /// Wallet and Repurchase
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.85,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.28,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeSmall),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      darkMode ? 900 : 200]!,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.3)
                                            ],
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: Dimensions
                                                            .iconSizeDefault,
                                                        height: Dimensions
                                                            .iconSizeDefault,
                                                        child: Image.asset(
                                                          Images.offers,
                                                          color: Colors.white,
                                                        )),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Repurchase ",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall)),
                                                    const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeSmall,
                                                    ),
                                                    Text(
                                                        PriceConverter.convertPrice(
                                                            context,
                                                            (profile.walletBalance !=
                                                                        null &&
                                                                    profile.walletBalance!
                                                                            .totalWalletBalance !=
                                                                        null)
                                                                ? profile
                                                                        .walletBalance!
                                                                        .total_repurchase_wallet ??
                                                                    0
                                                                : 0),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeDefault)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: Dimensions
                                                      .iconSizeDefault,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.paddingSizeSmall,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.85,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.28,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeSmall),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      darkMode ? 900 : 200]!,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.3)
                                            ],
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: Dimensions
                                                            .iconSizeDefault,
                                                        height: Dimensions
                                                            .iconSizeDefault,
                                                        child: Image.asset(
                                                          Images.earning,
                                                          color: Colors.white,
                                                        )),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text("Withdraw ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall)),
                                                    const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeSmall,
                                                    ),
                                                    Text(
                                                        PriceConverter.convertPrice(
                                                            context,
                                                            (profile.walletBalance !=
                                                                        null &&
                                                                    profile.walletBalance!
                                                                            .totalWalletBalance !=
                                                                        null)
                                                                ? profile
                                                                        .walletBalance!
                                                                        .total_withdrawal_wallet ??
                                                                    0
                                                                : 0),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .fontSizeDefault)),
                                                    InkWell(
                                                      onTap: () => showModalBottomSheet(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          isScrollControlled:
                                                              true,
                                                          context: context,
                                                          builder: (_) =>
                                                              CustomEditDialog(
                                                                  "withdrawal",
                                                                  profile
                                                                      .walletBalance!
                                                                      .total_withdrawal_wallet)),
                                                      child: Container(
                                                        height: 35,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xFFEEF6FF),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .paddingSizeSmall)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () => showModalBottomSheet(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  isScrollControlled:
                                                                      true,
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      CustomEditDialog(
                                                                          "withdrawal",
                                                                          profile
                                                                              .walletBalance!
                                                                              .total_withdrawal_wallet)),
                                                              child: Text(
                                                                  "Withdrawl",
                                                                  style: titilliumRegular.copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeDefault)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                              TransactionListView(
                                scrollController: scrollController,
                              )
                            ],
                          ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class OrderShimmer extends StatelessWidget {
  const OrderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: Dimensions.marginSizeDefault),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          color: Theme.of(context).highlightColor,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: ColorResources.white),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container(height: 45, color: Colors.white)),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(height: 20, color: ColorResources.white),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                  height: 10, width: 70, color: Colors.white),
                              const SizedBox(width: 10),
                              Container(
                                  height: 10, width: 20, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}
