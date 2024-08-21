import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  NotificationModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        status,
        code,
        message,
        data,
      ];
}

class Data extends Equatable {
  int? id;
  String? title;
  String? body;
  String? image;
  int? status;
  String? createdAt;

  Data({
    this.id,
    this.title,
    this.body,
    this.image,
    this.status,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        image,
        status,
        createdAt,
      ];
}
