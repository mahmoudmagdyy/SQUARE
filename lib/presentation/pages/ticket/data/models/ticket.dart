// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final bool? status;
  final String? message;
  final List<TickerData>? data;
  const Ticket({
    this.status,
    this.message,
    this.data,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [status, message, data];

  Ticket copyWith({
    bool? status,
    String? message,
    List<TickerData>? data,
  }) {
    return Ticket(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      status: map['status'] != null ? map['status'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? List<TickerData>.from(
              (map['data'] as List).map<TickerData?>(
                (x) => TickerData.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  factory Ticket.fromJson(String source) =>
      Ticket.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

class TickerData extends Equatable {
  final int? id;
  final String? title;
  final String? problem;
  final String? answer;
  final int? status;
  final String? createdAt;
  const TickerData({
    this.id,
    this.title,
    this.problem,
    this.answer,
    this.status,
    this.createdAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      problem,
      answer,
      status,
      createdAt,
    ];
  }

  TickerData copyWith({
    int? id,
    String? title,
    String? problem,
    String? answer,
    int? status,
    String? createdAt,
  }) {
    return TickerData(
      id: id ?? this.id,
      title: title ?? this.title,
      problem: problem ?? this.problem,
      answer: answer ?? this.answer,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'problem': problem,
      'answer': answer,
      'status': status,
      'created_at': createdAt,
    };
  }

  factory TickerData.fromMap(Map<String, dynamic> map) {
    return TickerData(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      problem: map['problem'] != null ? map['problem'] as String : null,
      answer: map['answer'] != null ? map['answer'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TickerData.fromJson(String source) =>
      TickerData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
