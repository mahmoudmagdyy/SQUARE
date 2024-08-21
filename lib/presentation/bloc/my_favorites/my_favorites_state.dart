// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_favorites_cubit.dart';

class MyFavoritesState extends Equatable {
  const MyFavoritesState({
    this.getMyFavoritesState = RequestState.none,
    this.myFavorites = const [],
    this.getAllFavErrorMessage,
    this.addOrRemoveFavorite = RequestState.none,
    this.statusCode,
  });

  final RequestState getMyFavoritesState;
  final int? statusCode;
  final List<Property> myFavorites;
  final String? getAllFavErrorMessage;

  final RequestState addOrRemoveFavorite;

  @override
  List<Object?> get props => [
        getMyFavoritesState,
        myFavorites,
        getAllFavErrorMessage,
        addOrRemoveFavorite,
        statusCode,
      ];

  MyFavoritesState copyWith({
    RequestState? getMyFavoritesState,
    int? statusCode,
    List<Property>? myFavorites,
    String? getAllFavErrorMessage,
    RequestState? addOrRemoveFavorite,
  }) {
    return MyFavoritesState(
      getMyFavoritesState: getMyFavoritesState ?? this.getMyFavoritesState,
      statusCode: statusCode ?? this.statusCode,
      myFavorites: myFavorites ?? this.myFavorites,
      addOrRemoveFavorite: addOrRemoveFavorite ?? this.addOrRemoveFavorite,
    );
  }
}
