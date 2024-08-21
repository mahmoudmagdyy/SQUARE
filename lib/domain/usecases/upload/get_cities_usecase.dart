import '../../../index.dart';

class GetCitiesUseCase extends UseCaseWithoutParams<List<CityEntity>> {
  final BaseUploadAqarRepository _repository;

  GetCitiesUseCase(this._repository);
  @override
  ResultFuture<List<CityEntity>> call() async => await _repository.getCities();
}
