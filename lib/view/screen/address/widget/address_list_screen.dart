import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
class AddressListPage extends StatelessWidget {
  final AddressModel? address;
  const AddressListPage({Key? key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        address!.addressType == 'Home' ? Images.homeImage
            : address!.addressType == 'Workplace' ? Images.bag : Images.moreImage,
        color: ColorResources.getSellerTxt(context), height: 30, width: 30,
      ),
      title: Text('${address!.address!}, ${address!.city!}, ${address!.state ?? ''} ${ address!.country == 'IN' ?  'India' ?? '' : ''}', style: titilliumRegular),
    );


    // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  AddNewAddressScreen(isBilling: false, isEnableUpdate: true,address: address,)));
  }
}
