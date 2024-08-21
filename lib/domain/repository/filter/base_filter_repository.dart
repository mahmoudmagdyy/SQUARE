import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/domain/usecases/filter/filter_usecase.dart';

import '/index.dart';

abstract class BaseFilterRepository {
  ResultFuture<List<AdsEntity>> getAds(FilterParameter params,
      [int pageNumber = 1]);
}
