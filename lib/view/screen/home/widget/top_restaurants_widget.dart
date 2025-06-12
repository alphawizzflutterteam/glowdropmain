import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/top_restaurants_model.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
class TopRestaurantsWidget extends StatelessWidget {
  Seller seller;
  ///final TopRestaurantsmodel topRestaurants;
  TopRestaurantsWidget({Key? key,required this.seller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
       Stack(
         children: [
           Container(
             height: MediaQuery.of(context).size.height/10,
             width: 75,
             // width: MediaQuery.of(context).size.width/1,
             decoration: BoxDecoration(
               // border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
               borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
               color: Theme.of(context).highlightColor,
             ),
             child: ClipRRect(
               borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
               child: FadeInImage.assetNetwork(
                 fit: BoxFit.cover,
                 placeholder: Images.placeholder,
                 image: '${seller.image}',
                 // '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}'
                 // '/${category.icon}',
                 imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
               ),
             ),
           ),
           Positioned(
             top: 5,
               left:5,
           child: Icon(Icons.heart_broken_rounded,color: Colors.red,size: 15,))
         ],
       ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Text(
              seller.name ?? "",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,fontWeight: FontWeight.bold,
                  color: ColorResources.getTextTitle(context)),
            ),
           SizedBox(height: 5,),
            Text(
              "Burger",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                  color: Colors.grey),
            ),
            SizedBox(height: 5,),

            Row(
              children: [
                Icon(Icons.more_time_sharp,color: Colors.deepOrange,size:Dimensions.fontSizeExtraSmall,),
                Text(
                  "30-35 min 4km",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                      color: Colors.grey),
                ),

              ],
            ),
            // SizedBox(height: 5,),
            // Text(
            //   "Burger",
            //   textAlign: TextAlign.center,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
            //       color: Colors.grey),
            // ),

          ],
        ),


      ],
    );
  }
}
