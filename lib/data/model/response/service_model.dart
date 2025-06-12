class ServiceModel {
  ServiceModel({
     this.status,
     this.data,
     this.message,
  });

   bool? status;
   Service? data;
   String? message;

  factory ServiceModel.fromJson(Map<String, dynamic> json){
    return ServiceModel(
      status: json["status"],
      data: json["data"] == null ? null : Service.fromJson(json["data"]),
      message: json["message"],
    );
  }

}

class Service {
  Service({
     this.currentPage,
     this.data,
     this.firstPageUrl,
     this.from,
     this.lastPage,
     this.lastPageUrl,
     this.links,
     this.nextPageUrl,
     this.path,
     this.perPage,
     this.prevPageUrl,
     this.to,
     this.total,
  });

   int? currentPage;
   List<ServiceData>? data;
   String? firstPageUrl;
   int? from;
   int? lastPage;
   String? lastPageUrl;
   List<Link>? links;
   dynamic nextPageUrl;
   String? path;
   String? perPage;
   dynamic prevPageUrl;
   int? to;
   int? total;

  factory Service.fromJson(Map<String, dynamic> json){
    return Service(
      currentPage: json["current_page"],
      data: json["data"] == null ? [] : List<ServiceData>.from(json["data"]!.map((x) => ServiceData.fromJson(x))),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }

}

class ServiceData {
  ServiceData({
     this.id,
     this.addedBy,
     this.userId,
     this.name,
     this.slug,
     this.productType,
     this.categoryIds,
     this.categoryId,
     this.subCategoryId,
     this.subSubCategoryId,
     this.brandId,
     this.unit,
     this.minQty,
     this.refundable,
     this.digitalProductType,
     this.digitalFileReady,
     this.images,
     this.colorImage,
     this.thumbnail,
     this.featured,
     this.flashDeal,
     this.videoProvider,
     this.videoUrl,
     this.colors,
     this.variantProduct,
     this.attributes,
     this.choiceOptions,
     this.variation,
     this.published,
     this.unitPrice,
     this.purchasePrice,
     this.tax,
     this.taxType,
     this.taxModel,
     this.discount,
     this.discountType,
     this.currentStock,
     this.minimumOrderQty,
     this.details,
     this.freeShipping,
     this.attachment,
     this.createdAt,
     this.updatedAt,
     this.status,
     this.featuredStatus,
     this.metaTitle,
     this.metaDescription,
     this.metaImage,
     this.requestStatus,
     this.deniedNote,
     this.shippingCost,
     this.multiplyQty,
     this.tempShippingCost,
     this.isShippingCostUpdated,
     this.code,
     this.reviewsCount,
     this.seller,
     this.rating,
     this.reviews,
     this.translations,
    this.timeSlots,

  });
  List<TimeSlot>? timeSlots;
   int? id;
   String? addedBy;
   int? userId;
   String? name;
   String? slug;
   String? productType;
   dynamic categoryIds;
   String? categoryId;
   dynamic subCategoryId;
   dynamic subSubCategoryId;
   dynamic brandId;
   dynamic unit;
   int? minQty;
   int? refundable;
   dynamic digitalProductType;
   dynamic digitalFileReady;
   String? images;
   dynamic colorImage;
   String? thumbnail;
   dynamic featured;
   dynamic flashDeal;
   String? videoProvider;
   dynamic videoUrl;
   dynamic colors;
   int? variantProduct;
   dynamic attributes;
   dynamic choiceOptions;
   dynamic variation;
   int? published;
   int? unitPrice;
   int? purchasePrice;
   int? tax;
   dynamic taxType;
   String? taxModel;
   int? discount;
   String? discountType;
   dynamic currentStock;
   int? minimumOrderQty;
   String? details;
   int? freeShipping;
   dynamic attachment;
   DateTime? createdAt;
   DateTime? updatedAt;
   int? status;
   int? featuredStatus;
   dynamic metaTitle;
   dynamic metaDescription;
   dynamic metaImage;
   int? requestStatus;
   dynamic deniedNote;
   int? shippingCost;
   dynamic multiplyQty;
   dynamic tempShippingCost;
   dynamic isShippingCostUpdated;
   dynamic code;
   int? reviewsCount;
   Seller? seller;
   List<Rating>? rating;
   List<Review>? reviews;
   List<dynamic>? translations;

   

  factory ServiceData.fromJson(Map<String, dynamic> json){
    return ServiceData(
      id: json["id"],
      addedBy: json["added_by"],
      userId: json["user_id"],
      name: json["name"],
      slug: json["slug"],
      productType: json["product_type"],
      categoryIds: json["category_ids"],
      categoryId: json["category_id"],
      subCategoryId: json["sub_category_id"],
      subSubCategoryId: json["sub_sub_category_id"],
      brandId: json["brand_id"],
      unit: json["unit"],
      minQty: json["min_qty"],
      refundable: json["refundable"],
      digitalProductType: json["digital_product_type"],
      digitalFileReady: json["digital_file_ready"],
      images: json["images"],
      colorImage: json["color_image"],
      thumbnail: json["thumbnail"],
      featured: json["featured"],
      flashDeal: json["flash_deal"],
      videoProvider: json["video_provider"],
      videoUrl: json["video_url"],
      colors: json["colors"],
      variantProduct: json["variant_product"],
      attributes: json["attributes"],
      choiceOptions: json["choice_options"],
      variation: json["variation"],
      published: json["published"],
      unitPrice: json["unit_price"],
      purchasePrice: json["purchase_price"],
      tax: json["tax"],
      taxType: json["tax_type"],
      taxModel: json["tax_model"],
      discount: json["discount"],
      discountType: json["discount_type"],
      currentStock: json["current_stock"],
      minimumOrderQty: json["minimum_order_qty"],
      details: json["details"],
      freeShipping: json["free_shipping"],
      attachment: json["attachment"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      status: json["status"],
      featuredStatus: json["featured_status"],
      metaTitle: json["meta_title"],
      metaDescription: json["meta_description"],
      metaImage: json["meta_image"],
      requestStatus: json["request_status"],
      deniedNote: json["denied_note"],
      shippingCost: json["shipping_cost"],
      multiplyQty: json["multiply_qty"],
      tempShippingCost: json["temp_shipping_cost"],
      isShippingCostUpdated: json["is_shipping_cost_updated"],
      code: json["code"],
      reviewsCount: json["reviews_count"],
      seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
      rating: json["rating"] == null ? [] : List<Rating>.from(json["rating"]!.map((x) => Rating.fromJson(x))),
      reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
      timeSlots: json["time_slots"] == null ? [] : List<TimeSlot>.from(json["time_slots"]!.map((x) => TimeSlot.fromJson(x))),
    );
  }

}

class TimeSlot {
  TimeSlot({
    required this.id,
    required this.sellerId,
    required this.serviceId,
    required this.fromTime,
    required this.toTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? sellerId;
  final int? serviceId;
  final String? fromTime;
  final String? toTime;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory TimeSlot.fromJson(Map<String, dynamic> json){
    return TimeSlot(
      id: json["id"],
      sellerId: json["seller_id"],
      serviceId: json["service_id"],
      fromTime: json["from_time"],
      toTime: json["to_time"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Rating {
  Rating({
     this.average,
     this.serviceId,
  });

 String? average;
 int? serviceId;

  factory Rating.fromJson(Map<String, dynamic> json){
    return Rating(
      average: json["average"],
      serviceId: json["service_id"],
    );
  }

}

class Review {
  Review({
     this.id,
     this.productId,
     this.serviceId,
     this.customerId,
     this.deliveryManId,
     this.orderId,
     this.comment,
     this.attachment,
     this.rating,
     this.status,
     this.isSaved,
     this.createdAt,
     this.updatedAt,
    this.customer,
  });

   int? id;
   dynamic productId;
   int? serviceId;
   int? customerId;
   dynamic deliveryManId;
   dynamic orderId;
   String? comment;
   String? attachment;
   int? rating;
   int? status;
   int? isSaved;
   DateTime? createdAt;
   DateTime? updatedAt;
  Customer? customer;

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
      id: json["id"],
      productId: json["product_id"],
      serviceId: json["service_id"],
      customerId: json["customer_id"],
      deliveryManId: json["delivery_man_id"],
      orderId: json["order_id"],
      comment: json["comment"],
      attachment: json["attachment"],
      rating: json["rating"],
      status: json["status"],
      isSaved: json["is_saved"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    );
  }

}

class Customer {
  Customer({
     this.id,
     this.name,
     this.fName,
     this.lName,
     this.phone,
     this.image,
     this.email,
     this.emailVerifiedAt,
     this.createdAt,
     this.updatedAt,
     this.streetAddress,
     this.age,
     this.gender,
     this.country,
     this.city,
     this.state,
     this.zipcode,
     this.houseNo,
     this.apartmentNo,
     this.cmFirebaseToken,
     this.isActive,
     this.paymentCardLastFour,
     this.paymentCardBrand,
     this.paymentCardFawryToken,
     this.loginMedium,
     this.socialId,
     this.isPhoneVerified,
     this.temporaryToken,
     this.isEmailVerified,
     this.walletBalance,
     this.loyaltyPoint,
     this.loginHitCount,
     this.isTempBlocked,
     this.tempBlockTime,
     this.referralCode,
     this.friendReferral,
     this.planStatus,
     this.planId,
     this.planExpireDate,
     this.dailyBonusAmount,
     this.referralBonus,
     this.repurchaseWallet,
     this.withdrawalWallet,
     this.isFrenchise,
     this.fundWallet,
  });

  int? id;
  String? name;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic streetAddress;
  dynamic age;
  dynamic gender;
  dynamic country;
  dynamic city;
  dynamic state;
  dynamic zipcode;
  dynamic houseNo;
  dynamic apartmentNo;
  String? cmFirebaseToken;
  int? isActive;
  dynamic paymentCardLastFour;
  dynamic paymentCardBrand;
  dynamic paymentCardFawryToken;
  dynamic loginMedium;
  dynamic socialId;
  int? isPhoneVerified;
  String? temporaryToken;
  int? isEmailVerified;
  int? walletBalance;
  dynamic loyaltyPoint;
  int? loginHitCount;
  int? isTempBlocked;
  dynamic tempBlockTime;
  dynamic referralCode;
  dynamic friendReferral;
  int? planStatus;
  dynamic planId;
  dynamic planExpireDate;
  int? dailyBonusAmount;
  dynamic referralBonus;
  int? repurchaseWallet;
  int? withdrawalWallet;
  int? isFrenchise;
  int? fundWallet;

  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      id: json["id"],
      name: json["name"],
      fName: json["f_name"],
      lName: json["l_name"],
      phone: json["phone"],
      image: json["image"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      streetAddress: json["street_address"],
      age: json["age"],
      gender: json["gender"],
      country: json["country"],
      city: json["city"],
      state: json["state"],
      zipcode: json["zipcode"],
      houseNo: json["house_no"],
      apartmentNo: json["apartment_no"],
      cmFirebaseToken: json["cm_firebase_token"],
      isActive: json["is_active"],
      paymentCardLastFour: json["payment_card_last_four"],
      paymentCardBrand: json["payment_card_brand"],
      paymentCardFawryToken: json["payment_card_fawry_token"],
      loginMedium: json["login_medium"],
      socialId: json["social_id"],
      isPhoneVerified: json["is_phone_verified"],
      temporaryToken: json["temporary_token"],
      isEmailVerified: json["is_email_verified"],
      walletBalance: json["wallet_balance"],
      loyaltyPoint: json["loyalty_point"],
      loginHitCount: json["login_hit_count"],
      isTempBlocked: json["is_temp_blocked"],
      tempBlockTime: json["temp_block_time"],
      referralCode: json["referral_code"],
      friendReferral: json["friend_referral"],
      planStatus: json["plan_status"],
      planId: json["plan_id"],
      planExpireDate: json["plan_expire_date"],
      dailyBonusAmount: json["daily_bonus_amount"],
      referralBonus: json["referral_bonus"],
      repurchaseWallet: json["repurchase_wallet"],
      withdrawalWallet: json["withdrawal_wallet"],
      isFrenchise: json["is_frenchise"],
      fundWallet: json["fund_wallet"],
    );
  }

}


class Seller {
  Seller({
     this.id,
     this.type,
     this.fName,
     this.lName,
     this.phone,
     this.image,
     this.email,
     this.password,
     this.status,
     this.panCard,
     this.dob,
     this.gender,
     this.address,
     this.zipcode,
     this.city,
     this.state,
     this.rememberToken,
     this.createdAt,
     this.updatedAt,
     this.bankName,
     this.branch,
     this.accountNo,
     this.holderName,
     this.authToken,
     this.salesCommissionPercentage,
     this.gst,
     this.cmFirebaseToken,
     this.posStatus,
     this.wallet,
     this.earningWallet,
     this.walletMaintain,
     this.planStatus,
     this.planId,
     this.startDate,
     this.endDate,
  });

   int? id;
   String? type;
   String? fName;
   String? lName;
   String? phone;
   String? image;
   String? email;
   String? password;
   String? status;
   String? panCard;
   DateTime? dob;
   String? gender;
   String? address;
   String? zipcode;
   String? city;
   String? state;
   dynamic rememberToken;
   DateTime? createdAt;
   DateTime? updatedAt;
   dynamic bankName;
   dynamic branch;
   dynamic accountNo;
   dynamic holderName;
   String? authToken;
   dynamic salesCommissionPercentage;
   String? gst;
   String? cmFirebaseToken;
   int? posStatus;
   int? wallet;
   int? earningWallet;
   int? walletMaintain;
   int? planStatus;
   dynamic planId;
   dynamic startDate;
   dynamic endDate;

  factory Seller.fromJson(Map<String, dynamic> json){
    return Seller(
      id: json["id"],
      type: json["type"],
      fName: json["f_name"],
      lName: json["l_name"],
      phone: json["phone"],
      image: json["image"],
      email: json["email"],
      password: json["password"],
      status: json["status"],
      panCard: json["pan_card"],
      dob: DateTime.tryParse(json["dob"] ?? ""),
      gender: json["gender"],
      address: json["address"],
      zipcode: json["zipcode"],
      city: json["city"],
      state: json["state"],
      rememberToken: json["remember_token"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      bankName: json["bank_name"],
      branch: json["branch"],
      accountNo: json["account_no"],
      holderName: json["holder_name"],
      authToken: json["auth_token"],
      salesCommissionPercentage: json["sales_commission_percentage"],
      gst: json["gst"],
      cmFirebaseToken: json["cm_firebase_token"],
      posStatus: json["pos_status"],
      wallet: json["wallet"],
      earningWallet: json["earning_wallet"],
      walletMaintain: json["wallet_maintain"],
      planStatus: json["plan_status"],
      planId: json["plan_id"],
      startDate: json["start_date"],
      endDate: json["end_date"],
    );
  }

}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

   String? url;
   String? label;
   bool? active;

  factory Link.fromJson(Map<String, dynamic> json){
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }

}
