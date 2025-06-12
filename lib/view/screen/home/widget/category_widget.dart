import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/category.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';
class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column( children: [
      Container(
        height: MediaQuery.of(context).size.width/4.4,
        width: MediaQuery.of(context).size.width/3.9,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
          // borderRadius: BorderRadius.circular(Dimensions.paddingSizeThirtyFive),
          color: Theme.of(context).highlightColor,
        ),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(Dimensions.paddingSizeThirtyFive),
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: Images.placeholder,
            image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}'
                '/${category.icon}',
            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
          ),
        ),
      ),
// SizedBox(height: 5,),
//       const SizedBox(height: 8), // You can adjust the height as needed

//       const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      Container(
        // color: Colors.red,
        width: 120,
        child: Center(
          child: Text(category.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,fontWeight: FontWeight.bold,
                color: ColorResources.getTextTitle(context)),
          ),
        ),
      ),

    ]);
  }
}
