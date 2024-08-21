import 'package:aqarat/domain/entities/profile/profile_entity.dart';
import 'package:aqarat/domain/repository/profile/base_profile_repository.dart';

import '/index.dart';


class GetProfileIdUseCase
    extends UseCaseWithParams<ProfileEntity, GetProfileIdParameter> {
  final BaseProfileRepository _repo;

  GetProfileIdUseCase(this._repo);
  @override
  ResultFuture<ProfileEntity> call(GetProfileIdParameter params) =>
      _repo.getProfileId(GetProfileIdParameter(id: params.id));
}

class GetProfileIdParameter extends Equatable {
  final String id;
  const GetProfileIdParameter({required this.id});

  @override
  List<Object> get props => [id];
}
