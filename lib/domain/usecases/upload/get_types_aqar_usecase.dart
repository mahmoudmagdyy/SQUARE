import '../../../index.dart';

class GetTypesAqarUseCase extends UseCaseWithoutParams<List<AreaEntity>> {
  final BaseUploadAqarRepository _repository;

  GetTypesAqarUseCase(this._repository);
  @override
  ResultFuture<List<AreaEntity>> call() async =>
      await _repository.getTypesAqar();
}
