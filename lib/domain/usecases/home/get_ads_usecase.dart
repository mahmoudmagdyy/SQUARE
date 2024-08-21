import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/domain/repository/home/base_home_repository.dart';

import '/index.dart';

class GetAdsUseCase extends UseCaseWithoutParams<List<AdsEntity>> {
  final BaseHomeRepository _repo;

  GetAdsUseCase(this._repo);
  @override
  ResultFuture<List<AdsEntity>> call() => _repo.getAds();
}
