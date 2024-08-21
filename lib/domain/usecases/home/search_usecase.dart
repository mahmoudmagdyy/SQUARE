import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/domain/repository/home/base_home_repository.dart';
import '/index.dart';

class SearchUseCase
    extends UseCaseWithParams<List<AdsEntity>, SearchParameter> {
  final BaseHomeRepository _repo;

  SearchUseCase(this._repo);
  @override
  ResultFuture<List<AdsEntity>> call(SearchParameter params) =>
      _repo.search(SearchParameter(text: params.text));
}

class SearchParameter extends Equatable {
  final String text;

  const SearchParameter({required this.text});

  @override
  List<Object?> get props => [text];
}
