import 'package:aqarat/domain/entities/profile/profile_entity.dart';
import 'package:aqarat/domain/usecases/profile/get_profile_id_usecase.dart';
import 'package:aqarat/domain/usecases/profile/update_profile_usecase.dart';
import '/index.dart';

abstract class BaseProfileRepository {
  ResultFuture<ProfileEntity> getProfile();
  ResultFuture<ProfileEntity> updateProfile(UpdateProfileParameter parameter);
  ResultFuture<ProfileEntity> getProfileId(GetProfileIdParameter parameter);
}
