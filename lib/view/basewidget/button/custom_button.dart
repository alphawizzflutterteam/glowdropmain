import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final Color? backgroundColor;
  final double? radius;
  const CustomButton({Key? key, this.onTap, required this.buttonText, this.isBuy= false, this.isBorder = false, this.backgroundColor, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap as void Function()?,
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width*90/100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:  backgroundColor ?? (isBuy?  ColorResources.primary : ColorResources.primary),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
            ],
            borderRadius: BorderRadius.circular(radius !=null ? radius! : isBorder? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall)),
        child: Text(buttonText ?? '',
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            )),
      ),
    );
  }
}

class CustomButton1 extends StatelessWidget {
  final Function? onTap;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final Color? backgroundColor;
  final double? radius;
  const CustomButton1({Key? key, this.onTap, required this.buttonText, this.isBuy= false, this.isBorder = false, this.backgroundColor, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap as void Function()?,
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width*90/100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:  backgroundColor ?? (isBuy?  ColorResources.backGroundcolor : ColorResources.backGroundcolor),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
            ],
            borderRadius: BorderRadius.circular(radius !=null ? radius! : isBorder? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall)),
        child: Text(buttonText ?? '',
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: ColorResources.white,
            )),
      ),
    );
  }
}
