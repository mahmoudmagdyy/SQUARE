import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/params/publish_add_params.dart';
import '../../../core/utils/enums.dart';
import '../../../data/model/slider_model.dart';
import '../../../data/network/error/failure.dart';
import '../../../data/repository/publish_add/publish_add.dart';
import '../../../domain/entities/home/ads_entity.dart';

part 'publish_add_state.dart';

class PublishAddCubit extends Cubit<PublishAddState> {
  PublishAddCubit(this.publishAddRepository) : super(const PublishAddState());

  final PublishAddRepository publishAddRepository;
  List<String> listofAreaIds = [];
  String? cityId;

  void addAndRemoveAreaId(String areaId) {
    if (listofAreaIds.contains(areaId)) {
      listofAreaIds.remove(areaId);
    } else {
      listofAreaIds.add(areaId);
    }
  }

  // chek if the listofAreaIds contain the areaId from the listofAreaIds from screen and then rutern true or false
  bool checkIfAreaIdIsSelected(String areaId) {
    return listofAreaIds.contains(areaId);
  }

  Future<void> getpublishAddSlider() async {
    emit(state.copyWith(sliderState: RequestState.loading));
    final sliderResult = await publishAddRepository.getpublishAddSlider();

    sliderResult.fold(
      (failure) {
        emit(state.copyWith(
            sliderState: RequestState.error, sliderFailure: failure));

        log('slider Failure $failure');
      },
      (sliderModel) {
        emit(
          state.copyWith(
            sliderState: RequestState.loaded,
            sliderModel: sliderModel,
          ),
        );
      },
    );
  }

  Future<void> getpublishAdd([bool isLoading = true]) async {
    if (isLoading) emit(state.copyWith(adsState: RequestState.loading));
    final sliderResult = await publishAddRepository.getpublishAdd(
        params: PublishAddParams(listOfareaId: listofAreaIds, cityId: cityId));

    sliderResult.fold(
      (failure) {
        emit(state.copyWith(
            adsState: RequestState.error, sliderFailure: failure));

        log(' getpublishAdd Failure $failure');
      },
      (right) {
        print('88888888888888888888888888');
        emit(
          state.copyWith(
            adsState: RequestState.loaded,
            adsEntityList: right,
          ),
        );
      },
    );
  }

  Future<void> getAdminPhoneNumber() async {
    final sliderResult = await publishAddRepository.getAdminPhoneNumber();

    sliderResult.fold(
      (failure) {
        log('adminPhoneNumberState Failure $failure');
      },
      (adminPhoneNumber) {
        adminPhoneNumberG = adminPhoneNumber;
      },
    );
  }
}

String adminPhoneNumberG = '';
