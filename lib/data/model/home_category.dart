class HomeCategory {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? parentId;
  int? position;
  String? createdAt;
  String? updatedAt;
  int? homeStatus;
  int? priority;
  List<Products>? products;
  List<Null>? translations;

  HomeCategory(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.parentId,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.homeStatus,
        this.priority,
        this.products,
        this.translations});

  HomeCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    homeStatus = json['home_status'];
    priority = json['priority'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    // if (json['translations'] != null) {
    //   translations = <Null>[];
    //   json['translations'].forEach((v) {
    //     translations!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['home_status'] = this.homeStatus;
    data['priority'] = this.priority;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    // if (this.translations != null) {
    //   data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Products {
  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;
  String? productType;
  List<CategoryIds>? categoryIds;
  String? categoryId;
  String? subCategoryId;
  Null? subSubCategoryId;
  int? brandId;
  String? unit;
  int? minQty;
  int? refundable;
  Null? digitalProductType;
  Null? digitalFileReady;
  List<String>? images;
  Null? barcodeImage;
  List<Null>? colorImage;
  String? thumbnail;
  Null? featured;
  Null? flashDeal;
  String? videoProvider;
  Null? videoUrl;
  String? colors;
  int? variantProduct;
  List<Null>? attributes;
  List<Null>? choiceOptions;
  List<Null>? variation;
  int? published;
  int? unitPrice;
  int? purchasePrice;
  int? tax;
  String? taxType;
  String? taxModel;
  int? discount;
  String? discountType;
  int? currentStock;
  int? minimumOrderQty;
  String? details;
  int? freeShipping;
  Null? attachment;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? featuredStatus;
  Null? metaTitle;
  Null? metaDescription;
  String? metaImage;
  int? requestStatus;
  Null? deniedNote;
  int? shippingCost;
  int? multiplyQty;
  Null? tempShippingCost;
  Null? isShippingCostUpdated;
  String? code;
  int? reviewsCount;
  List<Null>? colorsFormatted;
  List<Rating>? rating;
  List<Null>? tags;
  Seller? seller;
  List<Null>? translations;
  List<Reviews>? reviews;

  Products(
      {this.id,
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
        this.barcodeImage,
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
        this.colorsFormatted,
        this.rating,
        this.tags,
        this.seller,
        this.translations,
        this.reviews});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    name = json['name'];
    slug = json['slug'];
    productType = json['product_type'];
    if (json['category_ids'] != null) {
      categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        categoryIds!.add(new CategoryIds.fromJson(v));
      });
    }
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    subSubCategoryId = json['sub_sub_category_id'];
    brandId = json['brand_id'];
    unit = json['unit'];
    minQty = json['min_qty'];
    refundable = json['refundable'];
    digitalProductType = json['digital_product_type'];
    digitalFileReady = json['digital_file_ready'];
    images = json['images'].cast<String>();
    barcodeImage = json['barcode_image'];
    // if (json['color_image'] != null) {
    //   colorImage = <Null>[];
    //   json['color_image'].forEach((v) {
    //     colorImage!.add(new Null.fromJson(v));
    //   });
    // }
    thumbnail = json['thumbnail'];
    featured = json['featured'];
    flashDeal = json['flash_deal'];
    videoProvider = json['video_provider'];
    videoUrl = json['video_url'];
    colors = json['colors'];
    variantProduct = json['variant_product'];
    // if (json['attributes'] != null) {
    //   attributes = <Null>[];
    //   json['attributes'].forEach((v) {
    //     attributes!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['choice_options'] != null) {
    //   choiceOptions = <Null>[];
    //   json['choice_options'].forEach((v) {
    //     choiceOptions!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['variation'] != null) {
    //   variation = <Null>[];
    //   json['variation'].forEach((v) {
    //     variation!.add(new Null.fromJson(v));
    //   });
    // }
    published = json['published'];
    unitPrice = json['unit_price'];
    purchasePrice = json['purchase_price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    taxModel = json['tax_model'];
    discount = json['discount'];
    discountType = json['discount_type'];
    currentStock = json['current_stock'];
    minimumOrderQty = json['minimum_order_qty'];
    details = json['details'];
    freeShipping = json['free_shipping'];
    attachment = json['attachment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    featuredStatus = json['featured_status'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    requestStatus = json['request_status'];
    deniedNote = json['denied_note'];
    shippingCost = json['shipping_cost'];
    multiplyQty = json['multiply_qty'];
    tempShippingCost = json['temp_shipping_cost'];
    isShippingCostUpdated = json['is_shipping_cost_updated'];
    code = json['code'];
    reviewsCount = json['reviews_count'];
    // if (json['colors_formatted'] != null) {
    //   colorsFormatted = <Null>[];
    //   json['colors_formatted'].forEach((v) {
    //     colorsFormatted!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['rating'] != null) {
      rating = <Rating>[];
      json['rating'].forEach((v) {
        rating!.add(new Rating.fromJson(v));
      });
    }
    // if (json['tags'] != null) {
    //   tags = <Null>[];
    //   json['tags'].forEach((v) {
    //     tags!.add(new Null.fromJson(v));
    //   });
    // }
    // seller =
    // json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    // if (json['translations'] != null) {
    //   translations = <Null>[];
    //   json['translations'].forEach((v) {
    //     translations!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['added_by'] = this.addedBy;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['product_type'] = this.productType;
    if (this.categoryIds != null) {
      data['category_ids'] = this.categoryIds!.map((v) => v.toJson()).toList();
    }
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['sub_sub_category_id'] = this.subSubCategoryId;
    data['brand_id'] = this.brandId;
    data['unit'] = this.unit;
    data['min_qty'] = this.minQty;
    data['refundable'] = this.refundable;
    data['digital_product_type'] = this.digitalProductType;
    data['digital_file_ready'] = this.digitalFileReady;
    data['images'] = this.images;
    data['barcode_image'] = this.barcodeImage;
    // if (this.colorImage != null) {
    //   data['color_image'] = this.colorImage!.map((v) => v.toJson()).toList();
    // }
    data['thumbnail'] = this.thumbnail;
    data['featured'] = this.featured;
    data['flash_deal'] = this.flashDeal;
    data['video_provider'] = this.videoProvider;
    data['video_url'] = this.videoUrl;
    data['colors'] = this.colors;
    data['variant_product'] = this.variantProduct;
    // if (this.attributes != null) {
    //   data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    // }
    // if (this.choiceOptions != null) {
    //   data['choice_options'] =
    //       this.choiceOptions!.map((v) => v.toJson()).toList();
    // }
    // if (this.variation != null) {
    //   data['variation'] = this.variation!.map((v) => v.toJson()).toList();
    // }
    data['published'] = this.published;
    data['unit_price'] = this.unitPrice;
    data['purchase_price'] = this.purchasePrice;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['tax_model'] = this.taxModel;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['current_stock'] = this.currentStock;
    data['minimum_order_qty'] = this.minimumOrderQty;
    data['details'] = this.details;
    data['free_shipping'] = this.freeShipping;
    data['attachment'] = this.attachment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['featured_status'] = this.featuredStatus;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_image'] = this.metaImage;
    data['request_status'] = this.requestStatus;
    data['denied_note'] = this.deniedNote;
    data['shipping_cost'] = this.shippingCost;
    data['multiply_qty'] = this.multiplyQty;
    data['temp_shipping_cost'] = this.tempShippingCost;
    data['is_shipping_cost_updated'] = this.isShippingCostUpdated;
    data['code'] = this.code;
    data['reviews_count'] = this.reviewsCount;
    // if (this.colorsFormatted != null) {
    //   data['colors_formatted'] =
    //       this.colorsFormatted!.map((v) => v?.toJson()).toList();
    // }
    if (this.rating != null) {
      data['rating'] = this.rating!.map((v) => v.toJson()).toList();
    }
    // if (this.tags != null) {
    //   data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    // }
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    // if (this.translations != null) {
    //   data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryIds {
  String? id;
  int? position;

  CategoryIds({this.id, this.position});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position'] = this.position;
    return data;
  }
}

class Rating {
  String? average;
  int? productId;

  Rating({this.average, this.productId});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average'] = this.average;
    data['product_id'] = this.productId;
    return data;
  }
}

class Seller {
  int? id;
  int? sellerCategoryId;
  int? sellerSubCategoryId;
  String? type;
  int? isFreelancer;
  String? uniqueCode;
  String? fName;
  String? lName;
  String? phone;
  Null? otp;
  String? image;
  String? aadharFrontImg;
  String? aadharBackImg;
  String? email;
  String? password;
  String? status;
  String? panCard;
  Null? dob;
  Null? gender;
  String? address;
  String? latitude;
  String? longitude;
  String? zipcode;
  String? city;
  String? state;
  String? area;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;
  Null? bankName;
  Null? branch;
  Null? accountNo;
  Null? holderName;
  Null? authToken;
  Null? salesCommissionPercentage;
  String? gst;
  String? aadhar;
  Null? cmFirebaseToken;
  int? posStatus;
  int? wallet;
  int? earningWallet;
  int? walletMaintain;
  int? minOrderAmountForReward;
  int? rewardPoints;
  int? minimumReward;
  int? planStatus;
  Null? planId;
  Null? startDate;
  Null? endDate;
  Null? fastServiceKm;
  Null? fastServiceHours;
  Null? warehouseId;
  Shop? shop;

  Seller(
      {this.id,
        this.sellerCategoryId,
        this.sellerSubCategoryId,
        this.type,
        this.isFreelancer,
        this.uniqueCode,
        this.fName,
        this.lName,
        this.phone,
        this.otp,
        this.image,
        this.aadharFrontImg,
        this.aadharBackImg,
        this.email,
        this.password,
        this.status,
        this.panCard,
        this.dob,
        this.gender,
        this.address,
        this.latitude,
        this.longitude,
        this.zipcode,
        this.city,
        this.state,
        this.area,
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
        this.aadhar,
        this.cmFirebaseToken,
        this.posStatus,
        this.wallet,
        this.earningWallet,
        this.walletMaintain,
        this.minOrderAmountForReward,
        this.rewardPoints,
        this.minimumReward,
        this.planStatus,
        this.planId,
        this.startDate,
        this.endDate,
        this.fastServiceKm,
        this.fastServiceHours,
        this.warehouseId,
        this.shop});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerCategoryId = json['seller_category_id'];
    sellerSubCategoryId = json['seller_sub_category_id'];
    type = json['type'];
    isFreelancer = json['is_freelancer'];
    uniqueCode = json['unique_code'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    otp = json['otp'];
    image = json['image'];
    aadharFrontImg = json['aadhar_front_img'];
    aadharBackImg = json['aadhar_back_img'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    panCard = json['pan_card'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    zipcode = json['zipcode'];
    city = json['city'];
    state = json['state'];
    area = json['area'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bankName = json['bank_name'];
    branch = json['branch'];
    accountNo = json['account_no'];
    holderName = json['holder_name'];
    authToken = json['auth_token'];
    salesCommissionPercentage = json['sales_commission_percentage'];
    gst = json['gst'];
    aadhar = json['aadhar'];
    cmFirebaseToken = json['cm_firebase_token'];
    posStatus = json['pos_status'];
    wallet = json['wallet'];
    earningWallet = json['earning_wallet'];
    walletMaintain = json['wallet_maintain'];
    minOrderAmountForReward = json['min_order_amount_for_reward'];
    rewardPoints = json['reward_points'];
    minimumReward = json['minimum_reward'];
    planStatus = json['plan_status'];
    planId = json['plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    fastServiceKm = json['fast_service_km'];
    fastServiceHours = json['fast_service_hours'];
    warehouseId = json['warehouse_id'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_category_id'] = this.sellerCategoryId;
    data['seller_sub_category_id'] = this.sellerSubCategoryId;
    data['type'] = this.type;
    data['is_freelancer'] = this.isFreelancer;
    data['unique_code'] = this.uniqueCode;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['otp'] = this.otp;
    data['image'] = this.image;
    data['aadhar_front_img'] = this.aadharFrontImg;
    data['aadhar_back_img'] = this.aadharBackImg;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['pan_card'] = this.panCard;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['zipcode'] = this.zipcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['area'] = this.area;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['bank_name'] = this.bankName;
    data['branch'] = this.branch;
    data['account_no'] = this.accountNo;
    data['holder_name'] = this.holderName;
    data['auth_token'] = this.authToken;
    data['sales_commission_percentage'] = this.salesCommissionPercentage;
    data['gst'] = this.gst;
    data['aadhar'] = this.aadhar;
    data['cm_firebase_token'] = this.cmFirebaseToken;
    data['pos_status'] = this.posStatus;
    data['wallet'] = this.wallet;
    data['earning_wallet'] = this.earningWallet;
    data['wallet_maintain'] = this.walletMaintain;
    data['min_order_amount_for_reward'] = this.minOrderAmountForReward;
    data['reward_points'] = this.rewardPoints;
    data['minimum_reward'] = this.minimumReward;
    data['plan_status'] = this.planStatus;
    data['plan_id'] = this.planId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['fast_service_km'] = this.fastServiceKm;
    data['fast_service_hours'] = this.fastServiceHours;
    data['warehouse_id'] = this.warehouseId;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    return data;
  }
}

class Shop {
  int? id;
  int? sellerId;
  String? sellerType;
  String? name;
  String? address;
  String? contact;
  String? image;
  String? bottomBanner;
  Null? vacationStartDate;
  Null? vacationEndDate;
  Null? vacationNote;
  int? vacationStatus;
  int? temporaryClose;
  String? createdAt;
  String? updatedAt;
  String? banner;

  Shop(
      {this.id,
        this.sellerId,
        this.sellerType,
        this.name,
        this.address,
        this.contact,
        this.image,
        this.bottomBanner,
        this.vacationStartDate,
        this.vacationEndDate,
        this.vacationNote,
        this.vacationStatus,
        this.temporaryClose,
        this.createdAt,
        this.updatedAt,
        this.banner});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    sellerType = json['seller_type'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    bottomBanner = json['bottom_banner'];
    vacationStartDate = json['vacation_start_date'];
    vacationEndDate = json['vacation_end_date'];
    vacationNote = json['vacation_note'];
    vacationStatus = json['vacation_status'];
    temporaryClose = json['temporary_close'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['seller_type'] = this.sellerType;
    data['name'] = this.name;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['image'] = this.image;
    data['bottom_banner'] = this.bottomBanner;
    data['vacation_start_date'] = this.vacationStartDate;
    data['vacation_end_date'] = this.vacationEndDate;
    data['vacation_note'] = this.vacationNote;
    data['vacation_status'] = this.vacationStatus;
    data['temporary_close'] = this.temporaryClose;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner'] = this.banner;
    return data;
  }
}

class Reviews {
  int? id;
  int? productId;
  Null? serviceId;
  int? customerId;
  Null? deliveryManId;
  Null? orderId;
  String? comment;
  String? attachment;
  int? rating;
  int? status;
  int? isSaved;
  String? createdAt;
  String? updatedAt;

  Reviews(
      {this.id,
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
        this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    serviceId = json['service_id'];
    customerId = json['customer_id'];
    deliveryManId = json['delivery_man_id'];
    orderId = json['order_id'];
    comment = json['comment'];
    attachment = json['attachment'];
    rating = json['rating'];
    status = json['status'];
    isSaved = json['is_saved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['service_id'] = this.serviceId;
    data['customer_id'] = this.customerId;
    data['delivery_man_id'] = this.deliveryManId;
    data['order_id'] = this.orderId;
    data['comment'] = this.comment;
    data['attachment'] = this.attachment;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['is_saved'] = this.isSaved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
