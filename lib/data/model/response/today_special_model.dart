class TodaySpecialModel {
  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;
  String? productType;
  List<CategoryIds>? categoryIds;
  String? categoryId;
  String? subCategoryId;
  dynamic subSubCategoryId;
  int? brandId;
  String? unit;
  int? minQty;
  int? refundable;
  dynamic digitalProductType;
  dynamic digitalFileReady;
  List<String>? images;
  List<Null>? colorImage;
  String? thumbnail;
  int? featured;
  dynamic flashDeal;
  String? videoProvider;
  dynamic videoUrl;
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
  dynamic attachment;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int? requestStatus;
  dynamic deniedNote;
  int? shippingCost;
  int? multiplyQty;
  dynamic tempShippingCost;
  dynamic isShippingCostUpdated;
  String? code;
  int? checked;
  String? productIndicator;
  dynamic adminDiscountDate;
  dynamic todaySpecial;
  int? specialStatus;
  int? reviewsCount;
  List<Null>? colorsFormatted;
  int? productreviews;
  String? productrating;
  List<Null>? translations;
  List<Null>? reviews;

  TodaySpecialModel(
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
      this.checked,
      this.productIndicator,
      this.adminDiscountDate,
      this.todaySpecial,
      this.specialStatus,
      this.reviewsCount,
      this.colorsFormatted,
      this.productreviews,
      this.productrating,
      this.translations,
      this.reviews});

  TodaySpecialModel.fromJson(Map<String, dynamic> json) {
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
    checked = json['checked'];
    productIndicator = json['product_indicator'];
    adminDiscountDate = json['admin_discount_date'];
    todaySpecial = json['today_special'];
    specialStatus = json['special_status'];
    reviewsCount = json['reviews_count'];
    // if (json['colors_formatted'] != null) {
    //   colorsFormatted = <Null>[];
    //   json['colors_formatted'].forEach((v) {
    //     colorsFormatted!.add(new Null.fromJson(v));
    //   });
    // }
    productreviews = json['productreviews'];
    productrating = json['productrating'];
    // if (json['translations'] != null) {
    //   translations = <Null>[];
    //   json['translations'].forEach((v) {
    //     translations!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['reviews'] != null) {
    //   reviews = <Null>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(new Null.fromJson(v));
    //   });
    // }
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
    data['checked'] = this.checked;
    data['product_indicator'] = this.productIndicator;
    data['admin_discount_date'] = this.adminDiscountDate;
    data['today_special'] = this.todaySpecial;
    data['special_status'] = this.specialStatus;
    data['reviews_count'] = this.reviewsCount;
    // if (this.colorsFormatted != null) {
    //   data['colors_formatted'] =
    //       this.colorsFormatted!.map((v) => v.toJson()).toList();
    // }
    data['productreviews'] = this.productreviews;
    data['productrating'] = this.productrating;
    // if (this.translations != null) {
    //   data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
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
