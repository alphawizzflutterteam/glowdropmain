class MyTeamModel {
  MyTeamModel({
    required this.status,
    required this.message,
    required this.levelCount,
    required this.totalCount,
    required this.data,
  });

  final bool? status;
  final String? message;
  final int levelCount;
  final TeamData? data;
  int? totalCount;

  factory MyTeamModel.fromJson(Map<String, dynamic> json) {
    return MyTeamModel(
      status: json["status"],
      message: json["message"],
      levelCount: json["level_count"] ?? 0,
      totalCount: json['total_count'],
      data: json["data"] == null ? null : TeamData.fromJson(json["data"]),
    );
  }
}

class TeamData {
  TeamData({
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.level5,
    required this.level6,
    required this.level7,
    required this.level8,
    required this.level9,
    required this.level10,
    required this.level11,
    required this.level12,
    required this.level13,
    required this.level14,
    required this.level15,
    required this.level16,
    required this.level17,
    required this.level18,
    required this.level19,
    required this.level20,
  });

  final Level? level1;
  final Level? level2;
  final Level? level3;
  final Level? level4;
  final Level? level5;
  final Level? level6;
  final Level? level7;
  final Level? level8;
  final Level? level9;
  final Level? level10;
  final Level? level11;
  final Level? level12;
  final Level? level13;
  final Level? level14;
  final Level? level15;
  final Level? level16;
  final Level? level17;
  final Level? level18;
  final Level? level19;
  final Level? level20;

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return TeamData(
      level1: json["level1"] == null ? null : Level.fromJson(json["level1"]),
      level2: json["level2"] == null ? null : Level.fromJson(json["level2"]),
      level3: json["level3"] == null ? null : Level.fromJson(json["level3"]),
      level4: json["level4"] == null ? null : Level.fromJson(json["level4"]),
      level5: json["level5"] == null ? null : Level.fromJson(json["level5"]),
      level6: json["level6"] == null ? null : Level.fromJson(json["level6"]),
      level7: json["level7"] == null ? null : Level.fromJson(json["level7"]),
      level8: json["level8"] == null ? null : Level.fromJson(json["level8"]),
      level9: json["level9"] == null ? null : Level.fromJson(json["level9"]),
      level10: json["level10"] == null ? null : Level.fromJson(json["level10"]),
      level11: json["level11"] == null ? null : Level.fromJson(json["level11"]),
      level12: json["level12"] == null ? null : Level.fromJson(json["level12"]),
      level13: json["level13"] == null ? null : Level.fromJson(json["level13"]),
      level14: json["level14"] == null ? null : Level.fromJson(json["level14"]),
      level15: json["level15"] == null ? null : Level.fromJson(json["level15"]),
      level16: json["level16"] == null ? null : Level.fromJson(json["level16"]),
      level17: json["level17"] == null ? null : Level.fromJson(json["level17"]),
      level18: json["level18"] == null ? null : Level.fromJson(json["level18"]),
      level19: json["level19"] == null ? null : Level.fromJson(json["level19"]),
      level20: json["level20"] == null ? null : Level.fromJson(json["level20"]),
    );
  }
}

class Level {
  Level({
    required this.userCount,
    required this.userData,
  });

  final int? userCount;
  final List<UserDatum> userData;

  factory Level.fromJson(Map<String, dynamic> json) {
    print("levee;e;e;e count ${json["user_count"]}");
    return Level(
      userCount: json["user_count"],
      userData: json["user_data"] == null
          ? []
          : List<UserDatum>.from(
              json["user_data"]!.map((x) => UserDatum.fromJson(x))),
    );
  }
}

class UserDatum {
  UserDatum({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.registeredDate,
    required this.status,
  });

  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? registeredDate;
  final int? status;

  factory UserDatum.fromJson(Map<String, dynamic> json) {
    return UserDatum(
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      phone: json["phone"],
      registeredDate: json["registered_date"],
      status: json["status"],
    );
  }
}
