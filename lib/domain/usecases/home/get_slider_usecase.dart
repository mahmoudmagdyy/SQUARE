import 'package:aqarat/domain/entities/home/slider_entity.dart';
import 'package:aqarat/domain/repository/home/base_home_repository.dart';
import '/index.dart';

class GetSilderUseCase extends UseCaseWithoutParams<List<SlidersEntity>> {
  final BaseHomeRepository _repo;

  GetSilderUseCase(this._repo);
  @override
  ResultFuture<List<SlidersEntity>> call() => _repo.getSlider();
}
