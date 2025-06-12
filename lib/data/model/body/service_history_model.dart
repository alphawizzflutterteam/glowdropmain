class ServiceHistoryModel {
  ServiceHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  ServiceHistory? data;

  factory ServiceHistoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceHistoryModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : ServiceHistory.fromJson(json["data"]),
    );
  }
}

class ServiceHistory {
  ServiceHistory({
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
  List<ServiceHistoryData>? data;
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

  factory ServiceHistory.fromJson(Map<String, dynamic> json) {
    return ServiceHistory(
      currentPage: json["current_page"],
      data: json["data"] == null
          ? []
          : List<ServiceHistoryData>.from(
              json["data"]!.map((x) => ServiceHistoryData.fromJson(x))),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      links: json["links"] == null
          ? []
          : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }
}

class ServiceHistoryData {
  ServiceHistoryData(
      {this.id,
      this.bookingId,
      this.userId,
      this.bookingType,
      this.employeeId,
      this.sellerId,
      this.serviceId,
      this.patientName,
      this.patientAge,
      this.patientGender,
      this.patientEmail,
      this.patientMobile,
      this.houseNumber,
      this.streetName,
      this.locality,
      this.pincode,
      this.area,
      this.landmark,
      this.complaint,
      this.bookingDatetime,
      this.alternateDatetime,
      this.paidAmount,
      this.isPaid,
      this.googleAddress,
      this.latitude,
      this.longitude,
      this.status,
      this.statusUpdateBy,
      this.createdAt,
      this.updatedAt,
      this.alternateMobile,
      this.city,
      this.state,
      this.seller,
      this.service,
      this.bookingTime,
      this.toTime,
      this.images,
      this.reScheduleUserStatus});

  int? id;
  String? bookingId;
  int? userId;
  String? bookingType;
  dynamic employeeId;
  int? sellerId;
  int? serviceId;
  String? patientName;
  dynamic patientAge;
  dynamic patientGender;
  String? patientEmail;
  String? patientMobile;
  dynamic houseNumber;
  dynamic streetName;
  dynamic locality;
  int? pincode;
  String? area;
  dynamic landmark;
  String? complaint;
  String? bookingDatetime;
  String? alternateDatetime;
  int? paidAmount;
  int? isPaid;
  String? googleAddress;
  String? latitude;
  String? longitude;
  int? status;
  dynamic statusUpdateBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? alternateMobile;
  String? city;
  String? state;
  Seller? seller;
  Service? service;
  String? bookingTime;
  String? toTime;
  String? images;
  String? reScheduleUserStatus;

  factory ServiceHistoryData.fromJson(Map<String, dynamic> json) {
    return ServiceHistoryData(
        id: json["id"],
        bookingId: json["booking_id"],
        bookingTime: json["booking_time"],
        toTime: json["till_time"],
        userId: json["user_id"],
        bookingType: json["booking_type"],
        employeeId: json["employee_id"],
        sellerId: json["seller_id"],
        serviceId: json["service_id"],
        patientName: json["patient_name"],
        patientAge: json["patient_age"],
        patientGender: json["patient_gender"],
        patientEmail: json["patient_email"],
        patientMobile: json["patient_mobile"],
        houseNumber: json["house_number"],
        streetName: json["street_name"],
        locality: json["locality"],
        pincode: json["pincode"],
        area: json["area"],
        landmark: json["landmark"],
        complaint: json["complaint"],
        bookingDatetime: json["booking_datetime"] ?? "",
        alternateDatetime: json["alternate_datetime"] ?? "",
        paidAmount: json["paid_amount"],
        isPaid: json["is_paid"],
        googleAddress: json["google_address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        statusUpdateBy: json["status_update_by"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ""),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        alternateMobile: json["alternate_mobile"],
        city: json["city"],
        images: json["images"],
        state: json["state"],
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        reScheduleUserStatus: json['reschedule_user_status'] == null
            ? null
            : json['reschedule_user_status'].toString());
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
  dynamic panCard;
  dynamic dob;
  dynamic gender;
  dynamic address;
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
  dynamic authToken;
  dynamic salesCommissionPercentage;
  dynamic gst;
  dynamic cmFirebaseToken;
  int? posStatus;
  int? wallet;
  int? earningWallet;
  int? walletMaintain;
  int? planStatus;
  int? planId;
  DateTime? startDate;
  DateTime? endDate;

  factory Seller.fromJson(Map<String, dynamic> json) {
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
      dob: json["dob"],
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
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
    );
  }
}

class Service {
  Service({
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
    this.translations,
    this.reviews,
  });

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
  List<dynamic>? translations;
  List<Review>? reviews;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
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
      translations: json["translations"] == null
          ? []
          : List<dynamic>.from(json["translations"]!.map((x) => x)),
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
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

  factory Review.fromJson(Map<String, dynamic> json) {
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

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }
}
