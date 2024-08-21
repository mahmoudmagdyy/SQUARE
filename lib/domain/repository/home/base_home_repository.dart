import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/domain/entities/home/slider_entity.dart';
import 'package:aqarat/domain/usecases/home/search_usecase.dart';

import '/index.dart';
import '../../../data/model/cities_with_area_model.dart';

abstract class BaseHomeRepository {
  ResultFuture<List<SlidersEntity>> getSlider();
  ResultFuture<List<AdsEntity>> getAds();
  ResultFuture<List<CityEntity>> getCities();
  ResultFuture<List<AdsEntity>> search(SearchParameter params);
  ResultFuture<CitiesWithAreamodel> getCitiesWithArea();
}
