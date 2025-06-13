import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/user_info_model.dart';

import 'package:flutter_sixvalley_ecommerce/helper/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/banner_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/brand_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/featured_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/flash_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/home_category_product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/referal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/top_restaurants_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/top_seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/brand/all_brand_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/cart/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/category/all_category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/featureddeal/featured_deal_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/announcement.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/banners_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/book%20_services.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/brand_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/category_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/featured_deal_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/featured_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/flash_deals_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/footer_banner.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/home_category_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/latest_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/main_section_banner.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/products_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/flashdeal/flash_deal_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/recommended_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/todys_special_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/top_restaurants_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/top_seller_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/jobs/job_details.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/view_all_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/search/search_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/topSeller/all_top_seller_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/localization_provider.dart';
import '../../../provider/notification_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/wishlist_provider.dart';
import '../auth/widget/custom_drawer/custom_drawer.dart';
import '../category/all_service_category_screen.dart';
import '../category/service_view_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/address_list_screen.dart';
import '../wishlist/wishlist_screen.dart';
import 'package:ionicons/ionicons.dart';

String? lat;
String? long;
String? state;
String? city;
String? area;
String? pincode;
String? address;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHomeSelected = true;
  bool showAllCategories = false;

  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData(bool reload) async {
    Provider.of<ProfileProvider>(Get.context!, listen: false)
        .getUserInfo(Get.context!)
        .then((value) {
      address = Provider.of<ProfileProvider>(Get.context!, listen: false)
              .userInfoModel
              ?.address ??
          '';
      lat = Provider.of<ProfileProvider>(Get.context!, listen: false)
              .userInfoModel
              ?.lat ??
          '';
      long = Provider.of<ProfileProvider>(Get.context!, listen: false)
              .userInfoModel
              ?.long ??
          '';
      area = Provider.of<ProfileProvider>(Get.context!, listen: false)
              .userInfoModel
              ?.area ??
          '';
      city = Provider.of<ProfileProvider>(Get.context!, listen: false)
              .userInfoModel
              ?.city ??
          '';
      Provider.of<ProfileProvider>(Get.context!, listen: false)
          .setSelectCity(city ?? "");
      state = Provider.of<ProfileProvider>(Get.context!, listen: false)
              .userInfoModel
              ?.state ??
          '';
      pincode = Provider.of<ProfileProvider>(Get.context!, listen: false)
              .userInfoModel
              ?.zipcode ??
          '';
      setState(() {});
    });

    await Provider.of<NotificationProvider>(context, listen: false)
        .initNotificationList(context);
    // await Provider.of<ReferalProvider>(context, listen: false).initReferalList(context);
    Provider.of<WishListProvider>(context, listen: false).initWishList(
      context,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .countryCode,
    );
    await Provider.of<BannerProvider>(Get.context!, listen: false)
        .getBannerList(reload);
    await Provider.of<BannerProvider>(Get.context!, listen: false)
        .getFooterBannerList();
    await Provider.of<BannerProvider>(Get.context!, listen: false)
        .getMainSectionBanner();
    await Provider.of<CategoryProvider>(Get.context!, listen: false)
        .getCategoryList(reload);
    await Provider.of<CategoryProvider>(Get.context!, listen: false)
        .getServiceCategoryList(reload);
    await Provider.of<HomeCategoryProductProvider>(Get.context!, listen: false)
        .getHomeCategoryProductList(reload);
    await Provider.of<TopSellerProvider>(Get.context!, listen: false)
        .getTopSellerList(reload);
    await Provider.of<BrandProvider>(Get.context!, listen: false)
        .getBrandList(reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false)
        .getLatestProductList(1, reload: reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false)
        .getFeaturedProductList('1', reload: reload);
    await Provider.of<FeaturedDealProvider>(Get.context!, listen: false)
        .getFeaturedDealList(reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false)
        .getLProductList('1', reload: reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false)
        .getRecommendedProduct();

    // await Provider.of<TopRestaurantsProvider>(Get.context!, listen: false).getTopRestaurantsList(reload);
    // await Provider.of<TopRestaurantsProvider>(Get.context!, listen: false).getTodaysSpecialList(reload);
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  final List<Map<String, String>> categories = [
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
    {'name': 'cvxcvxcv', 'image': 'assets/images/image 156.png'},
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
  ];

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();

    singleVendor = Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";
    Provider.of<FlashDealProvider>(context, listen: false)
        .getMegaDealList(true, true);

    _loadData(false);

    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<CartProvider>(context, listen: false).uploadToServer(context);
      Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
    } else {
      Provider.of<CartProvider>(context, listen: false).getCartData();
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<String?> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];
    return Scaffold(
      key: _scaffoldKey, // <-- Set the key here
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      // drawer: CustomDrawer(), // <-- Use the drawer here
      // Custom AppBar with defined height
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Set your desired height
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset('assets/images/homeappbar.png',
                    fit: BoxFit.cover),
              ),
// SizedBox(height: 10,),
              // Overlay content
              Positioned(
                left: 0,
                top: 5,
                right: 5,
                // bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     _scaffoldKey.currentState?.openDrawer(); // <-- Open Drawer
                    //   },
                    //   child: Image.asset(
                    //     'assets/images/menuicon.png',
                    //     width: 40,
                    //     height: 40,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // InkWell(
                        //             onTap: () => Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (_) => const SearchScreen())),
                        //             child: Icon(Icons.search, color: Colors.white),
                        //           ),
                        //           Image.asset(
                        //             Images.homeLogoImage,
                        //             height: 40,
                        //           ),
                        GestureDetector(
                          onTap: () {
                            // Use Scaffold.of(context) to find the nearest Scaffold ancestor and open its drawer.
                            Scaffold.of(context).openDrawer(); // MODIFIED LINE
                          },
                          child: Image.asset(
                            'assets/images/menuicon.png',
                            width: 40,
                            height: 40,
                          ),
                        ),

                        Text(
                          "Hello Esha!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Bricolage Grotesque",
                          ),
                        ),
                        Image.asset(
                          'assets/images/appbarsalunicon.png',
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(width: 8),
                        Image.asset(
                          'assets/images/contact-information-help.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 8),
                        Image.asset(
                          'assets/images/notification 1.png',
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background image that will be overlapped
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Image.asset(
          //     "assets/images/homeappbar.png",
          //     fit: BoxFit.cover,
          //     height: 200,
          //   ),
          // ),
          SafeArea(
              child: RefreshIndicator(
            backgroundColor: Theme.of(context).highlightColor,
            onRefresh: () async {
              await _loadData(true);
              await Provider.of<FlashDealProvider>(Get.context!, listen: false)
                  .getMegaDealList(true, false);
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Transparent App Bar that allows content to show through
                // SliverAppBar(
                //   pinned: true,
                //   floating: false,
                //   snap: false,
                //   expandedHeight: 200.0,
                //   backgroundColor:
                //       Colors.red, // Changed from Colors.red
                //   elevation: 0,
                //   automaticallyImplyLeading: false,
                //   flexibleSpace: FlexibleSpaceBar(
                //     collapseMode: CollapseMode.parallax,
                //     background: Container(
                //       decoration: BoxDecoration(
                //         image: DecorationImage(
                //           image: AssetImage('assets/images/homeappbar.png'),
                //           fit: BoxFit.cover,
                //         ),
                //       )
                //     ), // Empty container instead of image
                //   ),
                //   title: Opacity(
                //     opacity: 1.0,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         InkWell(
                //           onTap: () => Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (_) => const SearchScreen())),
                //           child: Icon(Icons.search, color: Colors.white),
                //         ),
                //         Image.asset(
                //           Images.homeLogoImage,
                //           height: 40,
                //         ),
                //         Row(
                //           children: [
                //             IconButton(
                //               icon: Icon(Icons.favorite_border,
                //                   color: Colors.white),
                //               onPressed: () => Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (_) => const WishListScreen())),
                //             ),
                //             IconButton(
                //               icon: Icon(Icons.notifications_none,
                //                   color: Colors.white),
                //               onPressed: () => Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (_) =>
                //                           const NotificationScreen())),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Dimensions.homePagePadding,
                        Dimensions.homePagePadding,
                        Dimensions.paddingSizeDefault,
                        0),
                    child: Column(
                      children: [
                        const BannersView(),

                        const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall),

                        Column(
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 90 / 100,
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  // At Home Button
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHomeSelected = true;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isHomeSelected
                                                  ? ColorResources
                                                      .secondryPrimaryColor
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "At Home",
                                              style: TextStyle(
                                                color: isHomeSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          // Bottom Indicator
                                          Container(
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: isHomeSelected
                                                  ? ColorResources
                                                      .secondryPrimaryColor
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            margin:
                                                const EdgeInsets.only(top: 9),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  // At Salon Button
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHomeSelected = false;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            decoration: BoxDecoration(
                                              color: !isHomeSelected
                                                  ? ColorResources
                                                      .secondryPrimaryColor
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "At Salon",
                                              style: TextStyle(
                                                color: !isHomeSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          // Bottom Indicator
                                          Container(
                                            height: 4,
                                            margin:
                                                const EdgeInsets.only(top: 9),
                                            decoration: BoxDecoration(
                                              color: !isHomeSelected
                                                  ? ColorResources
                                                      .secondryPrimaryColor
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Category
                        isHomeSelected
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .paddingSizeExtraExtraSmall,
                                        vertical: Dimensions
                                            .paddingSizeExtraExtraSmall),
                                    child: TitleRow(
                                        title: 'Categories',
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    AllServiceCategoryScreen(
                                                      fromWhere: true,
                                                    )))),
                                  ),

                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  const ServiceViewScreen(isHomePage: true),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .paddingSizeExtraExtraSmall,
                                        vertical: Dimensions
                                            .paddingSizeExtraExtraSmall),
                                    child: TitleRow(
                                        title: 'Best Salon',
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    AllCategoryScreen(
                                                      fromWhere: true,
                                                    )))),
                                  ),

                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  CategoryView(isHomePage: true),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: Dimensions
                                  //           .paddingSizeExtraExtraSmall,
                                  //       vertical: Dimensions
                                  //           .paddingSizeExtraExtraSmall),
                                  //   child: TitleRow(
                                  //       title: 'Service Categories',
                                  //       onTap: () => Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (_) =>
                                  //                   AllServiceCategoryScreen(
                                  //                     fromWhere: true,
                                  //                   )))),
                                  // ),

                                  Container(
                                    // height:  MediaQuery.of(context).size.height * 90 / 100,
                                    width: MediaQuery.of(context).size.width *
                                        90 /
                                        100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeExtraExtraSmall,
                                              vertical: Dimensions
                                                  .paddingSizeExtraExtraSmall),
                                          child: TitleRow(
                                              title: 'Service Categories',
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          AllServiceCategoryScreen(
                                                            fromWhere: true,
                                                          )))),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Padding(
                                            //   padding: const EdgeInsets.symmetric(
                                            //       horizontal: Dimensions
                                            //           .paddingSizeExtraExtraSmall,
                                            //       vertical: Dimensions
                                            //           .paddingSizeExtraExtraSmall),
                                            //   child: TitleRow(
                                            //       title: 'Service Categories',
                                            //       onTap: () => Navigator.push(
                                            //           context,
                                            //           MaterialPageRoute(
                                            //               builder: (_) =>
                                            //                   AllServiceCategoryScreen(
                                            //                     fromWhere: true,
                                            //                   )))),
                                            // ),
                                            GestureDetector(
                                              onTap: () {
                                                if (showAllCategories) {
                                                  setState(() {
                                                    showAllCategories = false;
                                                  });
                                                } else {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder:
                                                  //         (context) => AllCategoriesPage(
                                                  //       categories: categories,
                                                  //     ),
                                                  //   ),
                                                  // );
                                                }
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    showAllCategories
                                                        ? "Hide"
                                                        : "View all",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 17,
                                                      fontFamily:
                                                          "Bricolage Grotesque",
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Icon(
                                                    showAllCategories
                                                        ? Ionicons.chevron_up
                                                        : Ionicons
                                                            .chevron_forward,
                                                    size: 18,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 1),

                                        /// This handles both collapsed and expanded views
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          // height: showAllCategories ? 300 : 130, // adjust height if needed
                                          child: GridView.builder(
                                            shrinkWrap:
                                                true, // Important: allows GridView to size itself properly inside a Column
                                            physics:
                                                NeverScrollableScrollPhysics(), // Important: disables inner scroll so outer scroll takes over
                                            // Disable inner scroll
                                            padding: const EdgeInsets.all(10),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 11,
                                              mainAxisSpacing: 11,
                                              childAspectRatio: 0.7,
                                            ),
                                            itemCount: 2,
                                            itemBuilder: (context, index) {
                                              final category =
                                                  categories[index];
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    60 /
                                                    100,
                                                // height:
                                                //     MediaQuery.of(context).size.height * 100 / 100,
                                                color: Colors.white,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            // width: MediaQuery.of(context).size.width*90/100,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    AssetImage(
                                                                  category[
                                                                      'image']!,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Theme.of(
                                                                      context)
                                                                  .highlightColor,
                                                            ),
                                                            child: Positioned(
                                                              child: Text(
                                                                "Beauty & Sense",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 125,
                                                            left: 110,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                            1,
                                                                          ),
                                                                          color:
                                                                              ColorResources.red),
                                                                  child: Text(
                                                                    "20% OFF",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 5.0,
                                                      ),
                                                      child: Text(
                                                        category['name']!,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        // overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 5.0,
                                                        right: 8,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          // Padding(                    padding: const EdgeInsets.only( left: 5,right: 5),
                                                          Text('200'),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .orange,
                                                                size: 14,
                                                              ),
                                                              Text(
                                                                category[
                                                                        'rating'] ??
                                                                    '4.5', // fallback if null
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            ColorResources
                                                                .secondryPrimaryColor,
                                                        minimumSize: Size(
                                                          160,
                                                          30,
                                                        ), // 👈 width: 120, height: 45

                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BookScreen()),
                                                        );
                                                      },
                                                      child: Text(
                                                        "Book",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeExtraExtraSmall,
                                              vertical: Dimensions
                                                  .paddingSizeExtraExtraSmall),
                                          child: TitleRow(
                                              title: 'Our Products',
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          AllCategoryScreen(
                                                            fromWhere: true,
                                                          )))),
                                        ),
                                        CategoryView(isHomePage: true),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Consumer<ProductProvider>(
                                      builder: (context, featured, _) {
                                    return featured
                                            .featuredProductList.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeExtraSmall,
                                                vertical: Dimensions
                                                    .paddingSizeExtraExtraSmall),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: Dimensions
                                                      .paddingSizeSmall),
                                              child: TitleRow(
                                                  title: getTranslated(
                                                      'featured_products',
                                                      context),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                AllProductScreen(
                                                                    productType:
                                                                        ProductType
                                                                            .featuredProduct)));
                                                  }),
                                            ),
                                          )
                                        : const SizedBox();
                                  }),

                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: Dimensions
                                  //           .paddingSizeExtraExtraSmall,
                                  //       vertical: Dimensions
                                  //           .paddingSizeExtraExtraSmall),
                                  //   child: TitleRow(
                                  //       title: 'Our Products',
                                  //       onTap: () => Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (_) =>
                                  //                   AllCategoryScreen(
                                  //                     fromWhere: true,
                                  //                   )))),
                                  // ),

                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .paddingSizeExtraExtraSmall,
                                        vertical: Dimensions
                                            .paddingSizeExtraExtraSmall),
                                    child: TitleRow(
                                        title: 'Service Categories',
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    AllServiceCategoryScreen(
                                                      fromWhere: true,
                                                    )))),
                                  ),

                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  const ServiceViewScreen(isHomePage: true),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .paddingSizeExtraExtraSmall,
                                        vertical: Dimensions
                                            .paddingSizeExtraExtraSmall),
                                    child: TitleRow(
                                        title: 'Best Salon',
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    AllCategoryScreen(
                                                      fromWhere: true,
                                                    )))),
                                  ),

                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  CategoryView(isHomePage: true),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  // CategoryView(isHomePage: true),
                                  Container(
                                    // height:  MediaQuery.of(context).size.height * 90 / 100,
                                    width: MediaQuery.of(context).size.width *
                                        90 /
                                        100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "Popular Salons",
                                                style: TextStyle(
                                                  color: ColorResources
                                                      .textPrimary,
                                                  fontSize: 17,
                                                  fontFamily:
                                                      "Bricolage Grotesque",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (showAllCategories) {
                                                  setState(() {
                                                    showAllCategories = false;
                                                  });
                                                } else {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder:
                                                  //         (context) => AllCategoriesPage(
                                                  //       categories: categories,
                                                  //     ),
                                                  //   ),
                                                  // );
                                                }
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    showAllCategories
                                                        ? "Hide"
                                                        : "View all",
                                                    style: TextStyle(
                                                      color: ColorResources
                                                          .primary,
                                                      fontSize: 17,
                                                      fontFamily:
                                                          "Bricolage Grotesque",
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Icon(
                                                    showAllCategories
                                                        ? Ionicons.chevron_up
                                                        : Ionicons
                                                            .chevron_forward,
                                                    size: 18,
                                                    color:
                                                        ColorResources.primary,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 1),

                                        /// This handles both collapsed and expanded views
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          // height: showAllCategories ? 300 : 130, // adjust height if needed
                                          child: GridView.builder(
                                            shrinkWrap:
                                                true, // Important: allows GridView to size itself properly inside a Column
                                            physics:
                                                NeverScrollableScrollPhysics(), // Important: disables inner scroll so outer scroll takes over
                                            // Disable inner scroll
                                            padding: const EdgeInsets.all(10),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 11,
                                              mainAxisSpacing: 11,
                                              childAspectRatio: 0.7,
                                            ),
                                            itemCount: 2,
                                            itemBuilder: (context, index) {
                                              final category =
                                                  categories[index];
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    60 /
                                                    100,
                                                // height:
                                                //     MediaQuery.of(context).size.height * 100 / 100,
                                                color: Colors.white,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            // width: MediaQuery.of(context).size.width*90/100,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    AssetImage(
                                                                  category[
                                                                      'image']!,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  ColorResources
                                                                      .pc,
                                                            ),
                                                            child: Positioned(
                                                              child: Text(
                                                                "Open",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 5.0,
                                                      ),
                                                      child: Text(
                                                        category['name']!,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        // overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 5.0,
                                                        right: 0,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          // Padding(                    padding: const EdgeInsets.only( left: 5,right: 5),
                                                          SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                'Mon - Sat | 11:00 AM - 08:PM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        8),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              minimumSize:
                                                                  Size(100, 30),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              // Navigator.push(
                                                              //   context,
                                                              //   MaterialPageRoute(builder: (context) => BookScreen()),
                                                              // );
                                                            },
                                                            child: Text(
                                                              "Book",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .orange,
                                                                size: 14,
                                                              ),
                                                              Text(
                                                                category[
                                                                        'rating'] ??
                                                                    '4.5', // fallback if null
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        Container(
                          child: Column(
                            children: [
                              SizedBox(height: 20),

                              // Text before boxes
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Welcome, Esha',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    Text(
                                      'Best Job You Need!',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 12),

                              // Scrollable row of boxes
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(10, (index) {
                                    final color = index % 2 == 0
                                        ? ColorResources.greencl
                                        : ColorResources.pinkcl;
                                    return InkWell(
                                      onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => JobDetails()))
                                      },
                                      child: Container(
                                        width: 180,
                                        height: 120,
                                        margin: EdgeInsets.only(
                                          left: index == 0 ? 16 : 8,
                                          right: index == 9 ? 16 : 0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      8.0,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/Frame 1000001477.png', // Replace with your image pat
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // SizedBox(height: 8),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                    ),
                                                    child: Text(
                                                      'Makeup Specialist', // Replace with your image path
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                    ),
                                                    child: Text(
                                                      'Indore - Full Time', // Replace with your image path
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),

                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              SizedBox(height: 20),

                              // Text before boxes
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Welcome, Esha',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    Text(
                                      'Best Training You Need!',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 12),

                              // Scrollable row of boxes
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(10, (index) {
                                    final color = index % 2 == 0
                                        ? ColorResources.greencl
                                        : ColorResources.pinkcl;
                                    return Container(
                                      width: 180,
                                      height: 120,
                                      margin: EdgeInsets.only(
                                        left: index == 0 ? 16 : 8,
                                        right: index == 9 ? 16 : 0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/Frame 1000001477.png', // Replace with your image pat
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                // SizedBox(height: 8),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                    'Makeup Specialist', // Replace with your image path
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                    'Indore - Full Time', // Replace with your image path
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),

                              SizedBox(height: 20),
                            ],
                          ),
                        ),

                        //Today's Special
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal:
                        //           Dimensions.paddingSizeExtraExtraSmall,
                        //       vertical: 0),
                        //   child: TitleRow(
                        //     title: getTranslated("Today's Special", context),
                        //     // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllCategoryScreen()))
                        //   ),
                        // ),
                        // const SizedBox(height: Dimensions.paddingSizeSmall),

                        // const Padding(
                        //   padding: EdgeInsets.only(
                        //       bottom: Dimensions.paddingSizeExtraSmall,
                        //       top: Dimensions.paddingSizeExtraSmall),
                        //   child: TodaysSpecialView(),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal:
                        //           Dimensions.paddingSizeExtraExtraSmall,
                        //       vertical: Dimensions.paddingSizeExtraSmall),
                        //   child: TitleRow(
                        //     title: getTranslated(
                        //         'Top Rated Restaurants', context),
                        //     // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllCategoryScreen()))
                        //   ),
                        // ),
                        //   const SizedBox(height: Dimensions.paddingSizeSmall),
                        // const Padding(
                        //   padding: EdgeInsets.only(
                        //       bottom: Dimensions.homePagePadding),
                        //   child: TopRestaurantsView(isHomePage: true),
                        // ),
                        // Mega Deal
                        // Consumer<FlashDealProvider>(
                        //     builder: (context, flashDeal, child) {
                        //       return (flashDeal.flashDeal != null &&
                        //               flashDeal.flashDealList.isNotEmpty)
                        //           ? TitleRow(
                        //               title: getTranslated(
                        //                   'flash_deal', context),
                        //               eventDuration:
                        //                   flashDeal.flashDeal != null
                        //                       ? flashDeal.duration
                        //                       : null,
                        //               onTap: () {
                        //                 Navigator.push(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                         builder: (_) =>
                        //                             const FlashDealScreen()));
                        //               },
                        //               isFlash: true,
                        //             )
                        //           : const SizedBox.shrink();
                        //     },
                        //   ),

                        // const SizedBox(height: Dimensions.paddingSizeSmall),
                        // Consumer<FlashDealProvider>(
                        //   builder: (context, megaDeal, child) {
                        //     return (megaDeal.flashDeal != null &&
                        //             megaDeal.flashDealList.isNotEmpty)
                        //         ? SizedBox(
                        //             height:
                        //                 MediaQuery.of(context).size.width * .77,
                        //             child: const Padding(
                        //               padding: EdgeInsets.only(
                        //                   bottom: Dimensions.homePagePadding),
                        //               child: FlashDealsView(),
                        //             ))
                        //         : const SizedBox.shrink();
                        //   },
                        // ),

                        // Brand
                        // Provider.of<SplashProvider>(context, listen: false)
                        //             .configModel!
                        //             .brandSetting ==
                        //         "1"
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(
                        //             left: Dimensions.paddingSizeExtraSmall,
                        //             right: Dimensions.paddingSizeExtraSmall,
                        //             bottom: Dimensions.paddingSizeExtraSmall),
                        //         child: TitleRow(
                        //             title: getTranslated('brand', context),
                        //             onTap: () {
                        //               Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (_) =>
                        //                           const AllBrandScreen()));
                        //             }),
                        //       )
                        //     : const SizedBox(),
                        // SizedBox(
                        //     height: Provider.of<SplashProvider>(context,
                        //                     listen: false)
                        //                 .configModel!
                        //                 .brandSetting ==
                        //             "1"
                        //         ? Dimensions.paddingSizeSmall
                        //         : 0),
                        // Provider.of<SplashProvider>(context, listen: false)
                        //             .configModel!
                        //             .brandSetting ==
                        //         "1"
                        //     ? const BrandView(isHomePage: true)
                        //     : const SizedBox(),

                        //top seller

                        //
                        // singleVendor
                        //     ? const SizedBox()
                        //     : TitleRow(
                        //         title: getTranslated('popular_services', context),
                        //         onTap: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (_) =>
                        //                       const AllTopSellerScreen(
                        //                         topSeller: null,
                        //                       )));
                        //         },
                        //       ),
                        // singleVendor
                        //     ? const SizedBox(height: 0)
                        //     : const SizedBox(
                        //         height: Dimensions.paddingSizeSmall),
                        // singleVendor
                        //     ? const SizedBox()
                        //     : const Padding(
                        //         padding: EdgeInsets.only(
                        //             bottom: Dimensions.homePagePadding),
                        //         child: TopSellerView(isHomePage: true),
                        //       ),
                        // singleVendor
                        //                            ? const SizedBox()
                        //                            : TitleRow(
                        //                                title: getTranslated('popular_services', context),
                        //                                onTap: () {
                        //                                  Navigator.push(
                        //                                      context,
                        //                                      MaterialPageRoute(
                        //                                          builder: (_) =>
                        //                                              const AllTopSellerScreen(
                        //                                                topSeller: null,
                        //                                              )));
                        //                                },
                        //                              ),
                        //                        singleVendor
                        //                            ? const SizedBox(height: 0)
                        //                            : const SizedBox(
                        //                                height: Dimensions.paddingSizeSmall),
                        //                        singleVendor
                        //                            ? const SizedBox()
                        //                            : const Padding(
                        //                                padding: EdgeInsets.only(
                        //                                    bottom: Dimensions.homePagePadding),
                        //                                child: TopSellerView(isHomePage: true),
                        //                              ),

                        //footer banner
                        // Consumer<BannerProvider>(builder: (context, footerBannerProvider, child){
                        //   return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.isNotEmpty?
                        //   const Padding(
                        //     padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                        //     child: FooterBannersView(index: 0,),
                        //   ):const SizedBox();
                        // }),
                        //

                        // Featured Products

                        //
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       bottom: Dimensions.homePagePadding),
                        //   child: FeaturedProductView(
                        //     scrollController: _scrollController,
                        //     isHome: true,
                        //   ),
                        // ),

                        // Featured Deal

                        // Consumer<FeaturedDealProvider>(
                        //   builder: (context, featuredDealProvider, child) {
                        //     return  featuredDealProvider.featuredDealProductList.isNotEmpty ?
                        //     Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                        //       child: TitleRow(title: getTranslated('featured_deals', context),
                        //           onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FeaturedDealScreen()));}),
                        //     ) : const SizedBox.shrink();},),
                        //
                        // Consumer<FeaturedDealProvider>(
                        //   builder: (context, featuredDealProvider, child) {
                        //     return  featuredDealProvider.featuredDealProductList.isNotEmpty ?
                        //    SizedBox(height: featuredDealProvider.featuredDealProductList.length> 4 ? 120 * 4.0 : 120 * (double.parse(featuredDealProvider.featuredDealProductList.length.toString())),
                        //         child: const Padding(
                        //           padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                        //           child: FeaturedDealsView(),
                        //         )) : const SizedBox.shrink();},),
                        //
                        //

                        // const Padding(
                        //   padding: EdgeInsets.only(
                        //       bottom: Dimensions.homePagePadding),
                        //   child: RecommendedProductView(),
                        // ),

                        //footer banner
                        // Consumer<BannerProvider>(builder: (context, footerBannerProvider, child){
                        //   return footerBannerProvider.mainSectionBannerList != null &&
                        //       footerBannerProvider.mainSectionBannerList!.isNotEmpty?
                        //   const Padding(
                        //     padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                        //     child: MainSectionBannersView(index: 0,),
                        //   ):const SizedBox();
                        //
                        // }),
                        //

                        // Latest Products

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 7,vertical: Dimensions.paddingSizeExtraSmall),
                        //   child: TitleRow(title: getTranslated('latest_products', context),
                        //       onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(
                        //           productType: ProductType.latestProduct)));}),
                        // ),
                        // const SizedBox(height: Dimensions.paddingSizeSmall),
                        // LatestProductView(scrollController: _scrollController),
                        // const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                        //Home category
                        // const HomeCategoryProductView(isHomePage: true),
                        // const SizedBox(height: Dimensions.homePagePadding),

                        //footer banner
                        // Consumer<BannerProvider>(builder: (context, footerBannerProvider, child){
                        //   return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.length>1?
                        //   const FooterBannersView(index: 1):const SizedBox();
                        // }),
                        // const SizedBox(height: Dimensions.homePagePadding),

                        //Category filter
                        // Consumer<ProductProvider>(
                        //     builder: (ctx, prodProvider, child) {
                        //   return Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: Dimensions.paddingSizeExtraSmall,
                        //         vertical: Dimensions.paddingSizeExtraSmall),
                        //     child: Row(children: [
                        //       Expanded(
                        //           child: Text(
                        //               prodProvider.title == 'xyz'
                        //                   ? getTranslated(
                        //                       'new_arrival', context)!
                        //                   : prodProvider.title!,
                        //               style: titleHeader)),
                        //       prodProvider.latestProductList != null
                        //           ? PopupMenuButton(
                        //               itemBuilder: (context) {
                        //                 return [
                        //                   PopupMenuItem(
                        //                       value: ProductType.newArrival,
                        //                       textStyle: robotoRegular.copyWith(
                        //                         color:
                        //                             Theme.of(context).hintColor,
                        //                       ),
                        //                       child: Text(getTranslated(
                        //                           'new_arrival', context)!)),
                        //                   PopupMenuItem(
                        //                       value: ProductType.topProduct,
                        //                       textStyle: robotoRegular.copyWith(
                        //                         color:
                        //                             Theme.of(context).hintColor,
                        //                       ),
                        //                       child: Text(getTranslated(
                        //                           'top_product', context)!)),
                        //                   PopupMenuItem(
                        //                       value: ProductType.bestSelling,
                        //                       textStyle: robotoRegular.copyWith(
                        //                         color:
                        //                             Theme.of(context).hintColor,
                        //                       ),
                        //                       child: Text(getTranslated(
                        //                           'best_selling', context)!)),
                        //                   PopupMenuItem(
                        //                       value:
                        //                           ProductType.discountedProduct,
                        //                       textStyle: robotoRegular.copyWith(
                        //                         color:
                        //                             Theme.of(context).hintColor,
                        //                       ),
                        //                       child: Text(getTranslated(
                        //                           'discounted_product',
                        //                           context)!)),
                        //                 ];
                        //               },
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(
                        //                       Dimensions.paddingSizeSmall)),
                        //               child: Padding(
                        //                 padding: const EdgeInsets.symmetric(
                        //                     horizontal:
                        //                         Dimensions.paddingSizeSmall,
                        //                     vertical:
                        //                         Dimensions.paddingSizeSmall),
                        //                 child: Image.asset(
                        //                   Images.dropdown,
                        //                   scale: 3,
                        //                 ),
                        //               ),
                        //               onSelected: (dynamic value) {
                        //                 if (value == ProductType.newArrival) {
                        //                   Provider.of<ProductProvider>(context,
                        //                           listen: false)
                        //                       .changeTypeOfProduct(
                        //                           value, types[0]);
                        //                 } else if (value ==
                        //                     ProductType.topProduct) {
                        //                   Provider.of<ProductProvider>(context,
                        //                           listen: false)
                        //                       .changeTypeOfProduct(
                        //                           value, types[1]);
                        //                 } else if (value ==
                        //                     ProductType.bestSelling) {
                        //                   Provider.of<ProductProvider>(context,
                        //                           listen: false)
                        //                       .changeTypeOfProduct(
                        //                           value, types[2]);
                        //                 } else if (value ==
                        //                     ProductType.discountedProduct) {
                        //                   Provider.of<ProductProvider>(context,
                        //                           listen: false)
                        //                       .changeTypeOfProduct(
                        //                           value, types[3]);
                        //                 }
                        //
                        //                 ProductView(
                        //                     isHomePage: false,
                        //                     productType: value,
                        //                     scrollController:
                        //                         _scrollController);
                        //                 Provider.of<ProductProvider>(context,
                        //                         listen: false)
                        //                     .getLatestProductList(1,
                        //                         reload: true);
                        //               })
                        //           : const SizedBox(),
                        //     ]),
                        //   );
                        // }),
                        // ProductView(
                        //     isHomePage: false,
                        //     productType: ProductType.newArrival,
                        //     scrollController: _scrollController),
                        // const SizedBox(height: Dimensions.homePagePadding),
                      ],
                    ),
                  ),
                )
              ],
            ),
            // Provider.of<SplashProvider>(context, listen: false)
            //             .configModel!
            //             .announcement!
            //             .status ==
            //         '1'
            //     ? Positioned(
            //         top: MediaQuery.of(context).size.height - 128,
            //         left: 0,
            //         right: 0,
            //         child: Consumer<SplashProvider>(
            //           builder: (context, announcement, _) {
            //             return (announcement.configModel!.announcement!
            //                             .announcement !=
            //                         null &&
            //                     announcement.onOff)
            //                 ? AnnouncementScreen(
            //                     announcement:
            //                         announcement.configModel!.announcement)
            //                 : const SizedBox();
            //           },
            //         ),
            //       )
            //     : const SizedBox(),
          ))
        ],
      ),
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
// SliverAppBar(
//   pinned: true,
//   expandedHeight: 58.0,
//   // floating: true,
//   elevation: 0,
//   centerTitle: false,
//   automaticallyImplyLeading: false,
//   backgroundColor: Color(0xffF4F1EC),
//   flexibleSpace: FlexibleSpaceBar(
//     // background: Image.asset(
//     //   'assets/images/homeappbar.png', // yahan aapki image ka path
//     //   fit: BoxFit.cover,
//     // ),
//   ),
//   title: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       InkWell(
//           onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => const SearchScreen())),
//           child: Icon(Icons.search_sharp,
//               color: ColorResources.white, size: 27)),
//       SizedBox(
//         width: 10,
//       ),
//       Image.asset(
//         Images.homeLogoImage,
//         height: 50,
//         width: 80,
//       ),
//       SizedBox(
//         width: 1,
//       ),
//       // Icon(Icons.notifications_none,color: ColorResources.primaryMaterial,size: 27,),
//     ],
//   ),
//   actions: [
//     //  Row(
//     //    mainAxisAlignment: MainAxisAlignment.center,
//     //    children: [
//     //      Image.asset(Images.logoWithNameImage, height: 35),
//     //      Icon(Icons.notifications_none,color: ColorResources.primaryMaterial,size: 27,),
//     // ] ),
//
//     // SizedBox(width: 15,),
//
//     Padding(
//       padding: const EdgeInsets.only(right: 0, top: 5),
//       child: IconButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const WishListScreen(),
//               ));
//         },
//         icon: Stack(clipBehavior: Clip.none, children: [
//           Image.asset(
//             Images.wishlist,
//             height: 27,
//             width: 22,
//             color: ColorResources.white,
//           ),
//           // Positioned(top: 0, right: -2,
//           //   child: Consumer<WishListProvider>(builder: (context, cart, child) {
//           //     return CircleAvatar(radius: 6, backgroundColor: ColorResources.red,
//           //       child: Text(cart.wishList?.length.toString() ?? "0",
//           //           style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: 8
//           //           )),
//           //     );
//           //   }),
//           // ),
//         ]),
//       ),
//     ),
//
//     InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const NotificationScreen(),
//             ));
//       },
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(right: 10, top: 5),
//           child: Stack(children: [
//             Icon(
//               Icons.notifications_none,
//               color: ColorResources.white,
//               size: 27,
//             ),
//             // Positioned(top: 1, right: 1,
//             //   child: Consumer<NotificationProvider>(builder: (context, cart, child) {
//             //     return CircleAvatar(radius: 6, backgroundColor: ColorResources.red,
//             //       child: Text(cart.notificationList?.length.toString() ?? "0",
//             //           style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: 8
//             //           )),
//             //     );
//             //   }),
//             // ),
//           ]),
//         ),
//       ),
//     ),
//   ],
// ),

// SliverAppBar(
//   backgroundColor: Theme.of(context).primaryColor,
// //   pinned: true,
//   expandedHeight: 58.0,
//   // floating: true,
//   elevation: 0,
//   centerTitle: false,
//   automaticallyImplyLeading: false,
//   // backgroundColor: Theme.of(context).primaryColor,
//   title: InkWell(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PlacePicker(
//             selectInitialPosition: true,
//             enableMyLocationButton: true,
//             apiKey: Platform.isAndroid
//                 ? ""
//                 : "",
//             onPlacePicked: (result) {
//               print(
//                   'Full Address: ${result.formattedAddress}');
//
//               // Extract components from address
//               for (var component
//                   in result.addressComponents!) {
//                 if (component.types.contains(
//                     'administrative_area_level_1')) {
//                   state = component.longName; // State
//                 } else if (component.types
//                     .contains('locality')) {
//                   city = component.longName; // City
//                   Provider.of<ProfileProvider>(Get.context!,
//                           listen: false)
//                       .setSelectCity(city ?? "");
//                 } else if (component.types
//                         .contains('sublocality_level_1') ||
//                     component.types
//                         .contains('neighborhood')) {
//                   area = component.longName; // Area
//                 } else if (component.types
//                     .contains('postal_code')) {
//                   pincode = component.longName; // Pincode
//                 }
//               }
//
//               print('State: $state');
//               print('City: $city');
//               print('Area: $area');
//               print('Pincode: $pincode');
//
//               setState(() {
//                 address = result.formattedAddress.toString();
//                 lat =
//                     result.geometry!.location.lat.toString();
//                 long =
//                     result.geometry!.location.lng.toString();
//               });
//               Navigator.of(context).pop();
//             },
//             initialPosition:
//                 const LatLng(22.719568, 75.857727),
//             useCurrentLocation: true,
//           ),
//         ),
//       );
//     },
//     child: Card(
//       child: Container(
//         height: 45,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Icon(Icons.location_on_outlined,
//                 color: ColorResources.black, size: 27),
//             Expanded(
//                 child: Text(
//               address ?? '',
//               maxLines: 1,
//               style:
//                   TextStyle(overflow: TextOverflow.ellipsis),
//             ))
//           ],
//         ),
//       ),
//     ),
//   ),
//   actions: [],
// ),

/// Search Button For Location
// SliverPersistentHeader(
//     pinned: true,
//     delegate: SliverDelegate(
//         child: InkWell(
//       onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => const AddressListScreen())),
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: Dimensions
//               .homePagePadding, /*vertical: Dimensions.paddingSizeExtraExtraSmall*/
//         ),
//         // color: Colors.black,
//         alignment: Alignment.center,
//         child: Container(
//           padding: const EdgeInsets.only(
//             left: Dimensions.homePagePadding,
//             right: Dimensions.paddingSizeExtraSmall,
//             /*top: Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeExtraExtraSmall,*/
//           ),
//           height: 40,
//           alignment: Alignment.centerLeft,
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             border: Border.all(color: Colors.grey, width: 2),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey[
//                       Provider.of<ThemeProvider>(context)
//                               .darkTheme
//                           ? 900
//                           : 200]!,
//                   spreadRadius: 1,
//                   blurRadius: 1)
//             ],
//             borderRadius: BorderRadius.circular(
//                 Dimensions.paddingSizeSmall),
//           ),
//           child: Row(
//               // mainAxisAlignment : MainAxisAlignment.spaceBetween,
//               children: [
//                 // Text(getTranslated('SEARCH_HINT', context)!,
//                 //     style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
//
//                 Container(
//                   //width: 40,
//                   // height: 40,
//                   decoration: BoxDecoration(
//                       //color: Theme.of(context).primaryColor,
//                       borderRadius: const BorderRadius.all(
//                           Radius.circular(Dimensions
//                               .paddingSizeExtraSmall))),
//                   child: Icon(
//                     Icons.location_on_outlined,
//                     size: 30,
//                     color: Colors
//                         .grey, /*color: Theme.of(context).cardColor, size: Dimensions.iconSizeSmall*/
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//
//                 Text(
//                   getTranslated('Location', context)!,
//                   style: robotoRegular.copyWith(
//                       color: Theme.of(context).hintColor,
//                       fontSize: 15),
//                 ),
//               ]),
//         ),
//       ),
//     ))),

// SliverPersistentHeader(
//     pinned: true,
//     delegate: SliverDelegate(
//         child: InkWell(
//       onTap: () {
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //       builder: (_) => const AddressListScreen()));
//       },
//       child: Container(
//         height: 15,
//       ),
//     ))),

///
// SliverPersistentHeader(
//     pinned: true,
//     delegate: SliverDelegate(
//         child: InkWell(
//       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
//           child: Container(
//
//             padding: const EdgeInsets.symmetric(
//               horizontal: Dimensions.homePagePadding, vertical: Dimensions.paddingSizeSmall),
//             color: ColorResources.getHomeBg(context),
//             alignment: Alignment.center,
//             child: Container(padding: const EdgeInsets.only(
//               left: Dimensions.homePagePadding, right: Dimensions.paddingSizeExtraSmall,
//               top: Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeExtraSmall,
//             ),
//               height: 60, alignment: Alignment.centerLeft,
//               decoration: BoxDecoration(color: Theme.of(context).cardColor,
//                 boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ?
//                 900 : 200]!, spreadRadius: 1, blurRadius: 1)],
//                 borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),
//               child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween, children: [
//
//                 Text(getTranslated('SEARCH_HINT', context)!,
//                     style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
//
//                 Container(
//                   width: 40,height: 40,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
//                     borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall))
//                 ),
//                   child: Icon(Icons.search, color: Theme.of(context).cardColor, size: Dimensions.iconSizeSmall),
//                 ),
//           ]),
//         ),
//       ),
//     ))),
