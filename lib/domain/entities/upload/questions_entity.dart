import 'package:aqarat/index.dart';

class InnerQuestionsEntity extends Equatable {
  final int? id;
  final String? title;
  final List<String> values;
  const InnerQuestionsEntity({
    required this.id,
    required this.title,
    this.values = const <String>["1", "2", "3", "4", "5", "6", "7+"],
  });

  @override
  List<Object?> get props => [id, title, values];
}
