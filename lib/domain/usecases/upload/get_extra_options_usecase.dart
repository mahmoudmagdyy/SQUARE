import '../../../index.dart';

class GetExtraOptionsUseCase
    extends UseCaseWithoutParams<List<InnerQuestionsEntity>> {
  final BaseUploadAqarRepository _repository;

  GetExtraOptionsUseCase(this._repository);
  @override
  ResultFuture<List<InnerQuestionsEntity>> call() async =>
      await _repository.getExtraOptions();
}
