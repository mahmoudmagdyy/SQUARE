import 'package:aqarat/domain/repository/home/base_home_repository.dart';
import 'package:aqarat/index.dart';

class GetCityUseCase extends UseCaseWithoutParams<List<CityEntity>> {
  final BaseHomeRepository _repo;

  GetCityUseCase(this._repo);
  @override
  ResultFuture<List<CityEntity>> call() => _repo.getCities();
}
