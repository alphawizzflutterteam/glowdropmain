// import 'package:flutter/material.dart';
// import 'package:flutter_sixvalley_ecommerce/helper/network_info.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/view/ServiceHistory/service_history_screen.dart';
// import 'package:flutter_sixvalley_ecommerce/view/screen/chat/inbox_screen.dart';
// import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
// import 'package:flutter_sixvalley_ecommerce/view/screen/home/home_screens.dart';
// import 'package:flutter_sixvalley_ecommerce/view/screen/more/more_screen.dart';
// import 'package:flutter_sixvalley_ecommerce/view/screen/myplans/my_plans.dart';
// import 'package:flutter_sixvalley_ecommerce/view/screen/notification/notification_screen.dart';
// import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_screen.dart';
// import 'package:provider/provider.dart';
//
// import '../cart/cart_screen.dart';
// import '../category/all_category_screen.dart';
//
// class DashBoardScreen extends StatefulWidget {
//   const DashBoardScreen({Key? key}) : super(key: key);
//
//   @override
//   DashBoardScreenState createState() => DashBoardScreenState();
// }
//
// class DashBoardScreenState extends State<DashBoardScreen> {
//   final PageController _pageController = PageController();
//   int _pageIndex = 0;
//   late List<Widget> _screens;
//   final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
//
//   bool singleVendor = false;
//   @override
//   void initState() {
//     super.initState();
//     singleVendor = Provider.of<SplashProvider>(context, listen: false)
//             .configModel!
//             .businessMode ==
//         "single";
//
//     _screens = [
//       const HomePage(),
//       //AllCategoryScreen(fromWhere: false),
//       ServiceHistoryScreen(
//         isBackButton: false,
//       ),
//       const OrderScreen(isBacButtonExist: false),
//       CartScreen(fromWhere: false),
//       MoreScreen(),
//       // singleVendor
//       //     ? const OrderScreen(isBacButtonExist: false)
//       //     : const OrderScreen(isBackButtonExist: false),
//       // : const InboxScreen(isBackButtonExist: false),
//       // singleVendor
//       //     ?
//       // const CartScreen()
//       // : const OrderScreen(isBacButtonExist: false)
//       // ,
//       //singleVendor? const NotificationScreen(isBacButtonExist: false): const OrderScreen(isBacButtonExist: false),
//       // singleVendor ? const MoreScreen() : const CartScreen(),
//       // singleVendor ? const SizedBox() : const MoreScreen(),
//     ];
//
//     NetworkInfo.checkConnectivity(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_pageIndex != 0) {
//           _setPage(0);
//           return false;
//         } else {
//           return true;
//         }
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Theme.of(context).highlightColor,
//           selectedItemColor: Color(0xff0007a3),
//           unselectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
//           showUnselectedLabels: true,
//           currentIndex: _pageIndex,
//           type: BottomNavigationBarType.fixed,
//           items: _getBottomWidget(singleVendor),
//           onTap: (int index) {
//             _setPage(index);
//           },
//         ),
//         body: PageView.builder(
//           controller: _pageController,
//           itemCount: _screens.length,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return _screens[index];
//           },
//         ),
//       ),
//     );
//   }
//
//   BottomNavigationBarItem _barItem(String icon, String? label, int index) {
//     return BottomNavigationBarItem(
//       icon: Image.asset(
//         icon,
//         color: index == _pageIndex
//             ? Color(0xff0007a3)
//             : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
//         height: 20,
//         width: 20,
//       ),
//       label: label,
//     );
//   }
//
//   void _setPage(int pageIndex) {
//     setState(() {
//       _pageController.jumpToPage(pageIndex);
//       _pageIndex = pageIndex;
//     });
//   }
//
//   List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
//     List<BottomNavigationBarItem> list = [];
//
//     if (!isSingleVendor) {
//       list.add(_barItem(Images.homeImage, getTranslated('home', context), 0));
//       list.add(_barItem(Images.moreFilledImage, "Services", 1));
//
//       // list.add(
//       //     _barItem(Images.messageImage, getTranslated('inbox', context), 2));
//       list.add(_barItem(
//           Images.shoppingImage, getTranslated('My Orders', context), 2));
//       list.add(_barItem(Images.cartImage, getTranslated('CART', context), 3));
//       list.add(_barItem(Images.moreImage, getTranslated('more', context), 4));
//     } else {
//       list.add(_barItem(Images.homeImage, getTranslated('home', context), 0));
//       list.add(_barItem(
//           Images.moreFilledImage, getTranslated('Category', context), 1));
//       list.add(_barItem(
//           Images.shoppingImage, getTranslated('My Orders', context), 2));
//       list.add(_barItem(Images.cartImage, getTranslated('CART', context), 3));
//       list.add(_barItem(Images.moreImage, getTranslated('more', context), 4));
//     }
//
//     return list;
//   }
// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/network_info.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/view/ServiceHistory/service_history_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/home_screens.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/more_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/myplans/my_plans.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/notification/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_screen.dart';
import 'package:provider/provider.dart';

import '../../select_category/select_category_screen.dart';
import '../auth/widget/custom_drawer/custom_drawer.dart';
import '../cart/cart_screen.dart';
import '../category/all_category_screen.dart';
import '../profile/profile_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";

    _screens = [
      const HomePage(),
      // const CategoriesScreen(),
      //AllCategoryScreen(fromWhere: false),
      // ServiceHistoryScreen(
      //   isBackButton: false,
      // ),
      const OrderScreen(isBacButtonExist: false),
      CartScreen(fromWhere: false),
      ProfileScreen(),
      // singleVendor
      //     ? const OrderScreen(isBacButtonExist: false)
      //     : const OrderScreen(isBackButtonExist: false),
      // : const InboxScreen(isBackButtonExist: false),
      // singleVendor
      //     ?
      // const CartScreen()
      // : const OrderScreen(isBacButtonExist: false)
      // ,
      //singleVendor? const NotificationScreen(isBacButtonExist: false): const OrderScreen(isBacButtonExist: false),
      // singleVendor ? const MoreScreen() : const CartScreen(),
      // singleVendor ? const SizedBox() : const MoreScreen(),
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        // key: _scaffoldKey, // Add this key
        drawer: CustomDrawer(), // ADD THIS LINE
        key: _scaffoldKey,
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _screens.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _screens[index];
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavBar(
                selectedIndex: _pageIndex,
                onItemSelected: _setPage,
                labels: singleVendor
                    ? ['Home', 'Bookings', 'Our Products', 'profile']
                    : ['Home', 'Bookings', 'Our Products', 'profile'],
                icons: [
                  Icons.home,
                  Icons.calendar_month_outlined,
                  // Icons.shopping_bag,
                  Icons.shopping_cart,
                  Icons.person,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String? label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        color: index == _pageIndex
            ? Color(0xff0007a3)
            : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
        height: 20,
        width: 20,
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> list = [];

    if (!isSingleVendor) {
      list.add(_barItem(Images.homeImage, getTranslated('home', context), 0));
      list.add(_barItem(Images.moreFilledImage, "Services", 1));

      // list.add(
      //     _barItem(Images.messageImage, getTranslated('inbox', context), 2));
      list.add(_barItem(
          Images.shoppingImage, getTranslated('My Orders', context), 2));
      list.add(_barItem(Images.cartImage, getTranslated('CART', context), 3));
      list.add(_barItem(Images.moreImage, getTranslated('more', context), 4));
    } else {
      list.add(_barItem(Images.homeImage, getTranslated('home', context), 0));
      list.add(_barItem(
          Images.moreFilledImage, getTranslated('Category', context), 1));
      list.add(_barItem(
          Images.shoppingImage, getTranslated('My Orders', context), 2));
      list.add(_barItem(Images.cartImage, getTranslated('CART', context), 3));
      list.add(_barItem(Images.moreImage, getTranslated('more', context), 4));
    }

    return list;
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final List<IconData> icons;
  final List<String> labels;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.icons,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: NavBarCurvePainter(
                selectedIndex: selectedIndex, itemCount: icons.length),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(icons.length, (index) {
                bool isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / icons.length,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: Offset(0, isSelected ? -20 : 0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? ColorResources.secondryPrimaryColor
                                  : Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              icons[index],
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          labels[index],
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarCurvePainter extends CustomPainter {
  final int selectedIndex;
  final int itemCount;

  NavBarCurvePainter({required this.selectedIndex, required this.itemCount});

  @override
  void paint(Canvas canvas, Size size) {
    double itemWidth = size.width / itemCount;
    double centerX = itemWidth * selectedIndex + itemWidth / 2;

    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(centerX - 40, 0);
    path.quadraticBezierTo(centerX, 60, centerX + 40, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black12, 8, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
