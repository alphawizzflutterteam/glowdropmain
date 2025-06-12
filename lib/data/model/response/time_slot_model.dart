class TimeSlotModel {
  bool? status;
  String? message;
  List<TimeSlotData>? data;

  TimeSlotModel({this.status, this.message, this.data});

  TimeSlotModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TimeSlotData>[];
      json['data'].forEach((v) {
        data!.add(new TimeSlotData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlotData {
  int? slotId;
  String? fromTime;
  String? toTime;
  int? isBooked;

  TimeSlotData({this.slotId, this.fromTime, this.toTime, this.isBooked});

  TimeSlotData.fromJson(Map<String, dynamic> json) {
    slotId = json['slot_id'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    isBooked = json['is_booked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot_id'] = this.slotId;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['is_booked'] = this.isBooked;
    return data;
  }
}
