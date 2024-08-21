import 'dart:async';
import 'dart:developer';

import 'package:aqarat/core/notification/notifications.dart';
import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/domain/entities/home/slider_entity.dart';
import 'package:aqarat/domain/usecases/home/get_ads_usecase.dart';
import 'package:aqarat/domain/usecases/home/get_city_usecase.dart';
import 'package:aqarat/domain/usecases/home/get_slider_usecase.dart';
import 'package:aqarat/domain/usecases/home/search_usecase.dart';

import '/index.dart';
import '../../../data/model/cities_with_area_model.dart';
import '../../../domain/usecases/home/get_cities_with_area.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this._searchUseCase,
    this._getAdsUseCase,
    this._getSilderUseCase,
    this._getCityUseCase,
    this._getCitiesWithAreaUseCase,
  ) : super(const HomeState()) {
    _initNotification();
    on<GetAdsEvent>(getAdsEvent);

    on<GetSliderEvent>(_getSliderEvent);
    on<GetCityEvent>(_getCityEvent);
    on<GetSearchProductsEvent>(_getSearchEvent);
  }

  final List<Area> listOfSelectedArea = [];
  final GetAdsUseCase _getAdsUseCase;
  final GetSilderUseCase _getSilderUseCase;
  final GetCityUseCase _getCityUseCase;
  final GetCitiesWithAreaUseCase _getCitiesWithAreaUseCase;
  final SearchUseCase _searchUseCase;
  final TextEditingController controller = TextEditingController();

  // add and remove ittem from list of selected area
  void addAndRemoveArea(Area area) {
    if (listOfSelectedArea.contains(area)) {
      listOfSelectedArea.remove(area);
    } else {
      listOfSelectedArea.add(area);
    }
    // add(GetAreaEvent(listOfSelectedArea: listOfSelectedArea));
  }

  void _initNotification() async {
    await NotificationHelper.initialize();
  }

  int selectedCityIDAtMap = 0;
  Future<void> getAdsEvent(
    GetAdsEvent? event,
    Emitter<HomeState> emit,
  ) async {
    print('5555555555555555555555555555555555555555');
    emit(state.copyWith(requestStateAds: RequestState.loading));
    final result = await _getAdsUseCase();

    result.fold(
      (left) {
        log(
          "message(error) ===> ${left.message}",
          name: 'Home getAdsEvent left',
        );
        emit(state.copyWith(
            message: left.message, requestStateAds: RequestState.error));
      },
      (right) {
        print(
            'rightmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm ===> $right');
        emit(state.copyWith(requestStateAds: RequestState.loaded, ads: right));
        print('state.ads ===> ${state.ads}');
      },
    );
    // try {
    //   emit(state.copyWith(requestStateAds: RequestState.loading));
    //   final result = await _getAdsUseCase();

    //   result.fold(
    //     (left) {
    //       log(
    //         "message(error) ===> ${left.message}",
    //         name: 'Home getAdsEvent left',
    //       );
    //       emit(state.copyWith(
    //           message: left.message, requestStateAds: RequestState.error));
    //     },
    //     (right) {
    //       emit(
    //           state.copyWith(requestStateAds: RequestState.loaded, ads: right));
    //     },
    //   );
    // } catch (error) {
    //   log(
    //     "message(error) ===> $error",
    //     name: 'Home getAdsEvent Catch',
    //   );
    //   emit(state.copyWith(
    //       message: error.toString(), requestStateAds: RequestState.error));
    // } finally {
    //   // emit(state.copyWith(requestState: RequestState.none));
    // }
  }

  Future<void> _getSliderEvent(
    GetSliderEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(requestStateSlider: RequestState.loading));
      final result = await _getSilderUseCase();

      result.fold(
        (left) {
          log(
            "message(error) ===> ${left.message}",
            name: 'Home _getSliderEvent left',
          );
          emit(state.copyWith(
              message: left.message, requestStateSlider: RequestState.error));
        },
        (right) {
          emit(state.copyWith(
              requestStateSlider: RequestState.loaded, slider: right));
        },
      );
    } catch (error) {
      log("message(error) ===> $error", name: 'Home _getSliderEvent Catch');
      emit(state.copyWith(
          message: error.toString(), requestStateSlider: RequestState.error));
    } finally {
      // emit(state.copyWith(requestState: RequestState.none));
    }
  }

  Future<void> _getCityEvent(
    GetCityEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(requestStateCity: RequestState.loading));
      final result = await _getCityUseCase();

      result.fold(
        (left) {
          log(
            "message(error) ===> ${left.message}",
            name: 'Home _getCityEvent left',
          );
          emit(state.copyWith(
              message: left.message, requestStateCity: RequestState.error));
        },
        (right) {
          emit(state.copyWith(
              requestStateCity: RequestState.loaded, cities: right));
        },
      );
    } catch (error) {
      log("message(error) ===> $error", name: 'Home _getCityEvent Catch');
      emit(state.copyWith(
          message: error.toString(), requestStateCity: RequestState.error));
    } finally {
      // emit(state.copyWith(requestState: RequestState.none));
    }
  }

  Future<void> getCitiesWithArea() async {
    try {
      emit(state.copyWith(requestStateCityWithArea: RequestState.loading));
      final result = await _getCitiesWithAreaUseCase();

      result.fold(
        (left) {
          log(
            "message(error) ===> ${left.message}",
            name: 'Home _getCityEvent left',
          );
          emit(state.copyWith(
              message: left.message,
              requestStateCityWithArea: RequestState.error));
        },
        (right) {
          emit(
            state.copyWith(
              requestStateCityWithArea: RequestState.loaded,
              cityWithAreaModel: right,
            ),
          );
        },
      );
    } catch (error) {
      log("message(error) ===> $error", name: 'Home _getCityEvent Catch');
      emit(state.copyWith(
          message: error.toString(),
          requestStateCityWithArea: RequestState.error));
    } finally {
      // emit(state.copyWith(requestState: RequestState.none));
    }
  }

  Future<void> _getSearchEvent(
    GetSearchProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (controller.text.isEmpty) {
        emit(state
            .copyWith(requestStateSearch: RequestState.none, search: const []));
      } else {
        emit(state.copyWith(requestStateSearch: RequestState.loading));
        final result =
            await _searchUseCase(SearchParameter(text: controller.text));

        result.fold(
          (left) {
            log(
              "message(error) ===> ${left.message}",
              name: 'Home _getSearchEvent left',
            );
            emit(state.copyWith(
                message: left.message, requestStateSearch: RequestState.error));
          },
          (right) {
            log("response(success) ===> $right");

            emit(state.copyWith(
                requestStateSearch: RequestState.loaded, search: right));
          },
        );
      }
    } catch (error) {
      log(
        "message(error) ===> $error",
        name: 'Home _getSearchEvent left',
      );
      emit(state.copyWith(
          message: error.toString(), requestStateSearch: RequestState.error));
    } finally {
      // emit(state.copyWith(requestState: RequestState.none));
    }
  }


}
