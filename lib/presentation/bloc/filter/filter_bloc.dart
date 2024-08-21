// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:developer';

import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/domain/usecases/filter/filter_usecase.dart';
import 'package:aqarat/index.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterInitial> {
  final FilterUseCase _getAdsUseCase;
  List<String> listofAreaIds = [];
  String? lat;
  String? lng;
  int pageNumber = 1;
  FilterBloc(this._getAdsUseCase) : super(const FilterInitial()) {
    on<GetAdsByFilterEvent>(_getAdsEvent);
    on<GetCityIdEvent>(_getCityIdEvent);
    on<GetAreaIdEvent>(_getAreaIdEvent);
    on<GetLatEvent>(_getLatEvent);
    on<GetLngEvent>(_getLngEvent);
  }

  void addAndRemoveAreaId(String areaId) {
    if (listofAreaIds.contains(areaId)) {
      listofAreaIds.remove(areaId);
    } else {
      listofAreaIds.add(areaId);
    }
    add(GetAreaIdEvent(areaId: listofAreaIds));
  }

  // chek if the listofAreaIds contain the areaId from the listofAreaIds from screen and then rutern true or false
  bool checkIfAreaIdIsSelected(String areaId) {
    return listofAreaIds.contains(areaId);
  }

  Future<void> _getAdsEvent(
    GetAdsByFilterEvent event,
    Emitter<FilterInitial> emit,
  ) async {
    if (pageNumber == 1) {
      emit(state.copyWith(requestState: RequestState.loading));
    }

    var params = FilterParameter(
      cityId: state.cityId,
      listOfareaId: listofAreaIds,
      categoryId: state.categoryId,
      lat: lat,
      lng: lng,
    );

    log("params ===> $params");
    final result = await _getAdsUseCase(
      params,
      pageNumber,
    );

    result.fold(
      (left) {
        log("message(error) ===> ${left.message}",
            name: 'Filter _getAdsEvent left');
        emit(state.copyWith(requestState: RequestState.error, adsEntity: []));
      },
      (right) {
        print('+++++++++++++++++++++++++++12122++++$right');

        if (pageNumber == 1 ||
            listofAreaIds.isNotEmpty ||
            state.categoryId.isNotEmpty) {
          emit(state.copyWith(
              requestState: RequestState.loaded, adsEntity: right));
        } else {
          emit(state.copyWith(
              requestState: RequestState.loaded,
              adsEntity: [...state.adsEntity, ...right]));
        }
      },
    );
  }

  Future<void> _getCityIdEvent(
    GetCityIdEvent event,
    Emitter<FilterInitial> emit,
  ) async {
    emit(state.copyWith(cityId: event.cityId));
  }

  Future<void> _getLatEvent(
    GetLatEvent event,
    Emitter<FilterInitial> emit,
  ) async {
    emit(state.copyWith(lat: event.lat));
  }

  Future<void> _getLngEvent(
    GetLngEvent event,
    Emitter<FilterInitial> emit,
  ) async {
    emit(state.copyWith(lng: event.lng));
  }

  Future<void> setNullLatAndLng() async {
    lat = null;
    lng = null;
    print('333333333333333333333333');
  }

  Future<void> _getAreaIdEvent(
    GetAreaIdEvent event,
    Emitter<FilterInitial> emit,
  ) async {
    emit(state.copyWith(listOfareaId: event.areaId));
  }

  void changeCategoryId(String? categoryID) {
    log('changeCategoryId $categoryID');
    emit(state.copyWith(categoryId: categoryID));
  }

  void resetCategoryId() {
    emit(state.copyWith(categoryId: ''));
  }

  void dispose() {
    add(const GetCityIdEvent(cityId: ''));
    add(const GetAreaIdEvent(areaId: []));
  }
}
