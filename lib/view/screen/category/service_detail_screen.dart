import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/category/service_from_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/category/service_review_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/category/service_review_widget.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/service_model.dart';
import '../../../helper/price_converter.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/splash_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../basewidget/rating_bar.dart';
import '../home/home_screens.dart';
import '../product/widget/review_widget.dart';

class ServiceDetailScreen extends StatefulWidget {
  final ServiceData productModel;
  ServiceDetailScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  final List<String> imageUrls = [
    'https://via.placeholder.com/600x300',
    'https://via.placeholder.com/600x300?text=Second',
    'https://via.placeholder.com/600x300?text=Third',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
            // onTap: widget.isFromWishList? () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const WishListScreen())):
            //     () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.home,
                  color: Theme.of(context).cardColor, size: 20),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text('Service Details',
              style: robotoRegular.copyWith(
                  fontSize: 18, color: Theme.of(context).cardColor)),
        ]),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                ),
                items: List<String>.from(
                        json.decode(widget.productModel.images ?? ''))
                    .map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        elevation: 7,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          // decoration: BoxDecoration(color: Colors.amber),
                          child: Image.network(
                            '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl}/${url}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.productModel.discount != null &&
                          widget.productModel.discount! > 0
                      ? Text(
                          PriceConverter.convertPrice(
                              context,
                              double.parse(
                                  widget.productModel.unitPrice.toString())),
                          style: titleRegular.copyWith(
                            color: ColorResources.getRed(context),
                            decoration: TextDecoration.lineThrough,
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                        )
                      : const SizedBox.shrink(),
                  widget.productModel.discount != null &&
                          widget.productModel.discount! > 0
                      ? const SizedBox(
                          width: 10,
                        )
                      : SizedBox(),
                  Text(
                    PriceConverter.convertPrice(context,
                        double.parse(widget.productModel.unitPrice.toString()),
                        discountType: widget.productModel.discountType,
                        discount: double.parse(
                            widget.productModel.discount.toString())),
                    style: titilliumSemiBold.copyWith(
                        color: ColorResources.getPrimary(context),
                        fontSize: 18),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.productModel.name ?? '',
                style: robotoRegular.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Text(widget.productModel.seller?.address ?? '',
                        style: robotoRegular.copyWith(
                            fontSize: 16, color: Colors.grey)),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Details',
                style: robotoRegular.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Text(widget.productModel.details ?? '',
                  style:
                      robotoRegular.copyWith(fontSize: 16, color: Colors.grey)),
              SizedBox(
                height: 10,
              ),
              Text(
                'Seller Details',
                style: robotoRegular.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.black,
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header

                      // Seller Image and Name
                      Row(
                        children: [
                          // Seller Profile Picture
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder,
                              height: Dimensions.chooseReviewImageSize,
                              width: Dimensions.chooseReviewImageSize,
                              fit: BoxFit.cover,
                              image:
                                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/${widget.productModel.seller?.image ?? ''}',
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                Images.placeholder,
                                height: Dimensions.chooseReviewImageSize,
                                width: Dimensions.chooseReviewImageSize,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          // Seller Name
                          Expanded(
                            child: Text(
                              '${widget.productModel.seller?.fName ?? ''} ${widget.productModel.seller?.lName ?? ''}',
                              style: robotoRegular.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),

                      // Seller Phone
                      Row(
                        children: [
                          Icon(Icons.phone,
                              color: ColorResources.primaryMaterial, size: 20),
                          SizedBox(width: 10),
                          Text(
                            '${widget.productModel.seller?.phone ?? 'N/A'}',
                            style: robotoRegular.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Seller Email
                      Row(
                        children: [
                          Icon(Icons.email_outlined,
                              color: ColorResources.primaryMaterial, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${widget.productModel.seller?.email ?? 'N/A'}',
                              style: robotoRegular.copyWith(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                color: Theme.of(context).cardColor,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated('customer_reviews', context)!,
                        style: titilliumSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge),
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      Container(
                        width: 230,
                        height: 30,
                        decoration: BoxDecoration(
                          color: ColorResources.visitShop(context),
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeExtraLarge),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBar(
                              rating: double.parse(
                                  (widget.productModel.rating?.isNotEmpty ??
                                          false)
                                      ? (widget.productModel.rating?[0].average
                                              .toString() ??
                                          '0')
                                      : '0'),
                              size: 18,
                            ),
                            const SizedBox(
                                width: Dimensions.paddingSizeDefault),
                            Text(
                                '${(widget.productModel.rating?.isNotEmpty ?? false) ? double.parse(widget.productModel.rating?[0].average.toString() ?? '0').toStringAsFixed(1) : '0'} ${getTranslated('out_of_5', context)}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      Text(
                          '${getTranslated('total', context)} ${(widget.productModel.reviews?.isNotEmpty ?? false) ? widget.productModel.reviews!.length : 0} ${getTranslated('reviews', context)}'),
                      widget.productModel.reviews != null
                          ? widget.productModel.reviews!.isNotEmpty
                              ? ServiceReviewWidget(
                                  reviewModel: widget.productModel.reviews![0])
                              : const SizedBox()
                          : const ReviewShimmer(),
                      // widget.productModel.reviews != null
                      //     ? widget.productModel.reviews!.length > 1
                      //     ? ServiceReviewWidget(
                      //     reviewModel:
                      //     widget.productModel.reviews![1])
                      //     : const SizedBox()
                      //     : const ReviewShimmer(),
                      // widget.productModel.reviews != null
                      //     ?widget.productModel.reviews!.length > 2
                      //     ? ServiceReviewWidget(
                      //     reviewModel:
                      //     widget.productModel.reviews![2])
                      //     : const SizedBox()
                      //     : const ReviewShimmer(),
                      InkWell(
                          onTap: () {
                            if (widget.productModel.reviews != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ServiceReviewScreen(
                                          reviewList:
                                              widget.productModel.reviews)));
                            }
                          },
                          child: widget.productModel.reviews != null &&
                                  widget.productModel.reviews!.length > 1
                              ? Text(
                                  getTranslated('view_more', context)!,
                                  style: titilliumRegular.copyWith(
                                      color: Theme.of(context).primaryColor),
                                )
                              : const SizedBox()),

                      SizedBox(
                        height: 30,
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServiceFromScreen(
                                  sellerId: widget.productModel.seller?.id
                                          .toString() ??
                                      '',
                                  serviceId:
                                      widget.productModel.id.toString() ?? '',
                                  amount: PriceConverter.convertPrice1(
                                      context,
                                      double.parse(widget.productModel.unitPrice
                                          .toString()),
                                      discountType:
                                          widget.productModel.discountType,
                                      discount: double.parse(widget
                                          .productModel.discount
                                          .toString())),
                                ),
                              ));
                        },
                        child: Center(
                            child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text(
                            'Book Now',
                            style: TextStyle(
                                color: ColorResources.white,
                                fontWeight: FontWeight.bold),
                          )),
                        )),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
