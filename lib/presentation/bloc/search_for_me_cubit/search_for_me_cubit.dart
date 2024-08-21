import 'dart:developer';

import 'package:aqarat/data/repository/search_for_me/search_for_me_repo.dart';
import 'package:aqarat/index.dart';
import 'package:dartz/dartz.dart';

import '../../../core/params/search_for_me_params.dart';
import '../../../data/model/search_for_me_model.dart';

part 'search_for_me_state.dart';

class SearchForMeCubit extends Cubit<SearchForMeCubitState> {
  SearchForMeCubit(this.searchForMeRepository)
      : super(
          const SearchForMeCubitState(),
        );
  final SearchForMeRepository searchForMeRepository;

  TextEditingController descController = TextEditingController();
  TextEditingController fromPriceController = TextEditingController();
  TextEditingController toPriceController = TextEditingController();
  TextEditingController spaceController = TextEditingController();

  int cityId = 0;
  int areaId = 0;
  int catId = 0;
  int type = 0;

  List<Property> newProperties = [];
  List<Property> accepted = [];
  List<Property> rejected = [];

  Future searchForMe() async {
    emit(state.copyWith(requestState: RequestState.loading));

    final Either<Failure, String> getProfileResult =
        await searchForMeRepository.searchForMe(
      SearchForMeParams(
        desc: descController.text,
        fromPrice: int.parse(fromPriceController.text),
        toPrice: int.parse(toPriceController.text),
        cityId: cityId,
        areaId: areaId,
        catId: catId,
        type: type,
        space: int.parse(spaceController.text),
      ),
    );
    getProfileResult.fold(
      (failure) {
        print('failure $failure');
        emit(state.copyWith(
          requestState: RequestState.error,
          failure: failure,
        ));
        print(failure.toString());
      },
      (data) {
        emit(state.copyWith(
          requestState: RequestState.loaded,
        ));
        clearData();
      },
    );
  }

  Future getSearchForMe() async {
    emit(state.copyWith(getSearchForMeRequestState: RequestState.loading));

    final Either<Failure, SearchForMeModel> getProfileResult =
        await searchForMeRepository.getSearchForMe();
    getProfileResult.fold(
      (failure) {
        print('failure $failure');
        emit(state.copyWith(
          getSearchForMeRequestState: RequestState.error,
          failure: failure,
        ));
        print(failure.toString());
      },
      (data) {
        emit(state.copyWith(
          getSearchForMeRequestState: RequestState.loaded,
        ));
        newProperties = data.newProperties;
        accepted = data.accepted;
        rejected = data.rejected;
        clearData();
      },
    );
  }

  List<Property> getSelectedListUsingIndex(int index) {
    if (index == 0) {
      return newProperties;
    } else if (index == 1) {
      return accepted;
    } else {
      return rejected;
    }
  }

  checkIfUserSelectedSingnInSearchData() {
    log('===================');
    if (cityId != 0 &&
        areaId != 0 &&
        fromPriceController.text.isNotEmpty &&
        toPriceController.text.isNotEmpty &&
        descController.text.isNotEmpty &&
        spaceController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  checkIfUserSelectedAqarTypeData() {
    if (catId != 0) {
      return true;
    } else {
      return false;
    }
  }

  clearData() {
    cityId = 0;
    areaId = 0;
    type = 0;
    catId = 0;
    fromPriceController.clear();
    toPriceController.clear();
    spaceController.clear();
    descController.clear();
  }

  @override
  Future<void> close() {
    fromPriceController.dispose();
    toPriceController.dispose();
    spaceController.dispose();
    descController.dispose();
    return super.close();
  }
}
