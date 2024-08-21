import 'package:aqarat/index.dart';

class QuestionsModel extends InnerQuestionsEntity {
  const QuestionsModel({required super.id, required super.title});

  factory QuestionsModel.fromJson(Map<String, Object?> json) {
    return QuestionsModel(
      id: json['id'] == null ? null : json['id'] as int,
      title: json['title'] == null ? null : json['title'] as String,
    );
  }
}
