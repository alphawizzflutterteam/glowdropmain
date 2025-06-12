class SlectCategory {
  int? id;
  String? name;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Childes>? childes;

  SlectCategory(
      {this.id,
        this.name,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.childes});

  SlectCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['childes'] != null) {
      childes = <Childes>[];
      json['childes'].forEach((v) {
        childes!.add(new Childes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.childes != null) {
      data['childes'] = this.childes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Childes {
  int? id;
  int? parentId;
  String? name;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  Childes(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  Childes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
