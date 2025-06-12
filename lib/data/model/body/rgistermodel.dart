class UserDetailsModel {
  String? name;
  String? gender;
  String? dob;
  String? address;

  UserDetailsModel({
    this.name,
    this.gender,
    this.dob,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'dob': dob,
      'address': address,
    };
  }
}
