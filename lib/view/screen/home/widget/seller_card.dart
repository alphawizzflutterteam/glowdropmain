import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/top_seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/topSeller/top_seller_product_screen.dart';
import 'package:provider/provider.dart';

import '../../../../utill/images.dart';
class SellerCard extends StatefulWidget {
  // final TopSellerModel? sellerModel;
  const SellerCard({Key? key}) : super(key: key);

  @override
  State<SellerCard> createState() => _SellerCardState();
}

class _SellerCardState extends State<SellerCard> {
  bool vacationIsOn = false;
  final List<Map<String, String>> categories = [
    {'name': 'Health & Wellness', 'image': 'assets/images/image 156.png'},
    {'name': 'Beauty & Aesthetics', 'image': 'assets/images/image 155.png'},
    {
      'name': 'Beauty & Aesthetics',
      'image':
      'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    },
    {
      'name': 'Beauty & Aesthetics',
      'image':
      'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    },
    {
      'name': 'Beauty & Aesthetics',
      'image':
      'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    },
    {
      'name': 'Beauty & Aesthetics',
      'image':
      'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    },
    {
      'name': 'Beauty & Aesthetics',
      'image':
      'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    },
    {
      'name': 'Beauty & Aesthetics',
      'image':
      'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    },
    {
      'name': 'Beauty & Aesthetics',
      'image':
      'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    },
    {
      'name': 'Beauty & Aesthetics',
      'image':
      'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // if (widget.sellerModel!.vacationEndDate != null) {
    //   DateTime vacationDate = DateTime.parse(
    //       widget.sellerModel!.vacationEndDate!);
    //   DateTime vacationStartDate = DateTime.parse(
    //       widget.sellerModel!.vacationStartDate!);
    //   final today = DateTime.now();
    //   final difference = vacationDate
    //       .difference(today)
    //       .inDays;
    //   final startDate = vacationStartDate
    //       .difference(today)
    //       .inDays;
    //
    //   vacationIsOn =
    //   (difference >= 0 && widget.sellerModel!.vacationStatus == 1 &&
    //       startDate <= 0);
    //
    //   if (kDebugMode) {
    //     print('------=>${widget.sellerModel!.name}${widget.sellerModel!
    //         .vacationEndDate}/${widget.sellerModel!
    //         .vacationStartDate}${vacationIsOn.toString()}/${difference
    //         .toString()}/${startDate.toString()}');
    //   }
    // }

    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (_) =>
        //     TopSellerProductScreen(topSeller: widget.sellerModel)));
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 1, // square
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        Dimensions.paddingSizeExtraSmall),
                    color: Theme
                        .of(context)
                        .highlightColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        Dimensions.paddingSizeExtraSmall),
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: Images.placeholder,
                      image:Images.placeholder,
                      // '${Provider
                      //     .of<SplashProvider>(context, listen: false)
                      //     .baseUrls!
                      //     .shopImageUrl!}/${widget.sellerModel!.image!}',
                      imageErrorBuilder: (c, o, s) =>
                          Image.asset(
                              Images.placeholder_1x1, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // if (widget.sellerModel!.temporaryClose == 1 || vacationIsOn)
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                borderRadius: BorderRadius.circular(
                    Dimensions.paddingSizeExtraSmall),
              ),
            ),
          // if (widget.sellerModel!.temporaryClose == 1)
          Container(
            width: MediaQuery.of(context).size.width * 90 / 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: 17,
                          fontFamily: "Bricolage Grotesque",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (showAllCategories) {
                        //   setState(() {
                        //     showAllCategories = false;
                        //   });
                        // } else {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder:
                        //           (context) => AllCategoriesPage(
                        //         categories: categories,
                        //       ),
                        //     ),
                        //   );
                        // }
                      },

                      // child: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     Text(
                      //       showAllCategories ? "Hide" : "View all",
                      //       style: TextStyle(
                      //         color: AppColors.primary,
                      //         fontSize: 17,
                      //         fontFamily: "Bricolage Grotesque",
                      //       ),
                      //     ),
                      //     const SizedBox(width: 8),
                      //     Icon(
                      //       showAllCategories
                      //           ? Ionicons.chevron_up
                      //           : Ionicons.chevron_forward,
                      //       size: 18,
                      //       color: AppColors.primary,
                      //     ),
                      //   ],
                      // ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),

                /// This handles both collapsed and expanded views
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height:300,
                  // showAllCategories
                  //     ? 300
                  //     : 130, // adjust height if needed
                  child: GridView.builder(
                    // physics: const NeverScrollableScrollPhysics(), // Disable inner scroll
                    padding: const EdgeInsets.all(10),

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.0, // for square shape
                    ),

                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Column(
                        children: [
                          Expanded(
                            child: Container(
                              width:
                              MediaQuery.of(
                                context,
                              ).size.width *
                                  90 /
                                  100,

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    category['image']!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width:
                            MediaQuery.of(context).size.width *
                                15 /
                                100,

                            child: Text(
                              category['name']!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              // overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // else
          //   if (vacationIsOn)
          //     Center(
          //       child: Text(
          //         getTranslated('close_for_now', context)!,
          //         textAlign: TextAlign.center,
          //         style: robotoRegular.copyWith(
          //             color: Colors.white, fontSize: Dimensions.fontSizeLarge),
          //       ),
          //     ),
        ],
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//
//     if(widget.sellerModel!.vacationEndDate != null){
//       DateTime vacationDate = DateTime.parse(widget.sellerModel!.vacationEndDate!);
//       DateTime vacationStartDate = DateTime.parse(widget.sellerModel!.vacationStartDate!);
//       final today = DateTime.now();
//       final difference = vacationDate.difference(today).inDays;
//       final startDate = vacationStartDate.difference(today).inDays;
//
//       if(difference >= 0 && widget.sellerModel!.vacationStatus == 1 && startDate <= 0){
//         vacationIsOn = true;
//       }
//
//       else{
//         vacationIsOn = false;
//       }
//       if (kDebugMode) {
//         print('------=>${widget.sellerModel!.name}${widget.sellerModel!.vacationEndDate}/${widget.sellerModel!.vacationStartDate}${vacationIsOn.toString()}/${difference.toString()}/${startDate.toString()}');
//       }
//
//     }
//
//
//     return InkWell(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(topSeller: widget.sellerModel)));
//       },
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(
//                 child:
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
//                     color: Theme.of(context).highlightColor,
//
//                   ),
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
//                     child: FadeInImage.assetNetwork(
//                       fit: BoxFit.cover,
//                       placeholder: Images.placeholder,
//                       image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.shopImageUrl!}/${widget.sellerModel!.image!}',
//                       imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_1x1, fit: BoxFit.cover,),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if(widget.sellerModel!.temporaryClose == 1  || vacationIsOn)
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(.5),
//                 borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
//               ),
//             ),
//
//           widget.sellerModel!.temporaryClose ==1?
//             Center(child: Text(getTranslated('temporary_closed', context)!, textAlign: TextAlign.center,
//               style: robotoRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge),)):
//           vacationIsOn?
//           Center(child: Text(getTranslated('close_for_now', context)!, textAlign: TextAlign.center,
//             style: robotoRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge),)):
//           const SizedBox()
//         ],
//       ),
//     );
//   }
// }
