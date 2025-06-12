class TopRestaurantsmodel {
  String? status;
  String? message;
  List<Seller>? seller;

  TopRestaurantsmodel({this.status, this.message, this.seller});

  TopRestaurantsmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['seller'] != null) {
      seller = <Seller>[];
      json['seller'].forEach((v) {
        seller!.add(new Seller.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.seller != null) {
      data['seller'] = this.seller!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Seller {
  int? id;
  int? sellerId;
  String? name;
  String? address;
  String? contact;
  String? image;
  String? bottomBanner;
  dynamic? vacationStartDate;
  dynamic? vacationEndDate;
  dynamic? vacationNote;
  int? vacationStatus;
  int? temporaryClose;
  String? createdAt;
  String? updatedAt;
  String? banner;
 dynamic? sponserSlip;
 dynamic? discountOnProduct;

  Seller(
      {this.id,
        this.sellerId,
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
        this.banner,
        this.sponserSlip,
        this.discountOnProduct});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
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
    sponserSlip = json['sponser_slip'];
    discountOnProduct = json['discount_on_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
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
    data['sponser_slip'] = this.sponserSlip;
    data['discount_on_product'] = this.discountOnProduct;
    return data;
  }
}
