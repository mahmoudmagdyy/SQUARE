import 'dart:developer';

import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/data/repository/favorites/favorites_repository.dart';
import 'package:aqarat/index.dart';

part 'my_favorites_state.dart';

class MyFavoritesCubit extends Cubit<MyFavoritesState> {
  final FavoritesRepository _favoritesRepository;
  MyFavoritesCubit(
    this._favoritesRepository,
  ) : super(const MyFavoritesState());

  void getAllFav() async {
    emit(state.copyWith(getMyFavoritesState: RequestState.loading));

    final result = await _favoritesRepository.getMyFavorites();

    result.fold(
      (l) {
        log('Error in Get My Favorites $l');
        emit(
          state.copyWith(
            getMyFavoritesState: RequestState.error,
            getAllFavErrorMessage: l.message,
            statusCode: l.statusCode,
          ),
        );
      },
      (r) => emit(state.copyWith(
        getMyFavoritesState: RequestState.loaded,
        myFavorites: r,
      )),
    );
  }

  void addOrRemoveFav(int id) async {
    emit(state.copyWith(addOrRemoveFavorite: RequestState.loading));

    final result = await _favoritesRepository.addOrRemoveFavorite(id);

    result.fold(
      (l) {
        log('Error in Add Or Remove Favorite $l');
        emit(state.copyWith(addOrRemoveFavorite: RequestState.error));
      },
      (r) {
        // _addOrRemoveFromList(id);
        getAllFav();
        emit(state.copyWith(addOrRemoveFavorite: RequestState.loaded));
      },
    );
  }

  bool isInFavList(int id) {
    return state.myFavorites.any((element) => element.id == id);
  }

  void _addOrRemoveFromList(int id) {
    if (isInFavList(id)) {
      state.myFavorites.removeWhere((element) => element.id == id);
    } else {
      state.myFavorites
          .add(state.myFavorites.firstWhere((element) => element.id == id));
    }
    emit(state.copyWith(myFavorites: state.myFavorites));
  }
}
