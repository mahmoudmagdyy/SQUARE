import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/domain/repository/filter/base_filter_repository.dart';

import '/index.dart';

class FilterUseCase
    extends UseCaseWithParams<List<AdsEntity>, FilterParameter> {
  final BaseFilterRepository _repo;

  FilterUseCase(this._repo);
  @override
  ResultFuture<List<AdsEntity>> call(FilterParameter params,
          [int pageNumber = 1]) =>
      _repo.getAds(
        FilterParameter(
          lat: params.lat,
          lng: params.lng,
          cityId: params.cityId,
          listOfareaId: params.listOfareaId,
          categoryId: params.categoryId,
        ),
        pageNumber,
      );
}

class FilterParameter extends Equatable {
  final String? cityId;
  final List<String>? listOfareaId;
  final String? categoryId;
  final String? lng;
  final String? lat;

  const FilterParameter({
    this.lng,
    this.lat,
    this.categoryId,
    this.cityId,
    this.listOfareaId,
  });

  @override
  List<Object?> get props => [
        lat,
        lng,
        cityId,
        listOfareaId,
        categoryId,
      ];
}
