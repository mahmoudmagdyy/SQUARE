import '../../../index.dart';

class GetQuestionsUseCase
    extends UseCaseWithoutParams<List<InnerQuestionsEntity>> {
  final BaseUploadAqarRepository _repository;

  GetQuestionsUseCase(this._repository);
  @override
  ResultFuture<List<InnerQuestionsEntity>> call() async =>
      await _repository.getQuestions();
}
