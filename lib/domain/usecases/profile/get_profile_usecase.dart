import 'package:aqarat/domain/entities/profile/profile_entity.dart';
import 'package:aqarat/domain/repository/profile/base_profile_repository.dart';

import '/index.dart';


class GetProfileUseCase extends UseCaseWithoutParams<ProfileEntity> {
  final BaseProfileRepository _repo;

  GetProfileUseCase(this._repo);
  @override
  ResultFuture<ProfileEntity> call() => _repo.getProfile();
}