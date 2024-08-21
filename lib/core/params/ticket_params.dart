import 'package:equatable/equatable.dart';

class TicketParams extends Equatable {
  final String title;
  final String name;
  final String phone;
  final String problem;
  final String email;
  final int? tableId;
  final bool? isQuestion;
  const TicketParams({
    required this.title,
    required this.name,
    required this.phone,
    required this.problem,
    required this.email,
    this.tableId,
    this.isQuestion,
  });

  @override
  List<Object?> get props {
    return [
      title,
      name,
      phone,
      problem,
      email,
      tableId,
      isQuestion,
    ];
  }

  TicketParams copyWith({
    String? title,
    String? name,
    String? phone,
    String? problem,
    String? email,
    int? tableId,
    bool? isQuestion,
  }) {
    return TicketParams(
      title: title ?? this.title,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      problem: problem ?? this.problem,
      email: email ?? this.email,
      tableId: tableId ?? this.tableId,
      isQuestion: isQuestion ?? this.isQuestion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'name': name,
      'phone': phone,
      'problem': problem,
      if (tableId != null) 'table_id': tableId,
      if (isQuestion != null) 'is_questions': isQuestion,
    };
  }

  @override
  bool get stringify => true;
}
