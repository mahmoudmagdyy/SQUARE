import '../../../core/typedef/typedef.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../../data/model/cities_with_area_model.dart';
import '../../repository/home/base_home_repository.dart';

class GetCitiesWithAreaUseCase
    extends UseCaseWithoutParams<CitiesWithAreamodel> {
  final BaseHomeRepository _repo;

  GetCitiesWithAreaUseCase(this._repo);
  @override
  ResultFuture<CitiesWithAreamodel> call() => _repo.getCitiesWithArea();
}
