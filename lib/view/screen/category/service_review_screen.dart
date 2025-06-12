import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/review_model.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/category/service_review_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/review_widget.dart';

import '../../../data/model/response/service_model.dart';

class ServiceReviewScreen extends StatelessWidget {
  final List<Review>? reviewList;
  const ServiceReviewScreen({Key? key, this.reviewList}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        CustomAppBar(title: getTranslated('reviews', context)),

        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Text('${getTranslated('reviews', context)!}(${reviewList!.length})', style: robotoBold),
        ),

        Expanded(child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          itemCount: reviewList!.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              color: Theme.of(context).highlightColor,
              child: ServiceReviewWidget(reviewModel: reviewList![index]),
            );
          },
        )),

      ]),
    );
  }
}
