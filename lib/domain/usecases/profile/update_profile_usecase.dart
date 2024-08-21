import 'package:aqarat/domain/entities/profile/profile_entity.dart';
import 'package:aqarat/domain/repository/profile/base_profile_repository.dart';

import '/index.dart';

class UpdateProfileUseCase
    extends UseCaseWithParams<ProfileEntity, UpdateProfileParameter> {
  final BaseProfileRepository _repo;

  UpdateProfileUseCase(this._repo);
  @override
  ResultFuture<ProfileEntity> call(UpdateProfileParameter params) =>
      _repo.updateProfile(params);
}

class UpdateProfileParameter extends Equatable {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String? image;
  // final int gender;
  const UpdateProfileParameter({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    this.image,
    // required this.gender,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        username,
        email,
        image,
        phone, /*  gender */
      ];
}
