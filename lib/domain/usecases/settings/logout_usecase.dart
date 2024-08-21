import 'package:aqarat/domain/repository/settings/base_settings_respository.dart';
import '/index.dart';

class LogOutUseCase extends UseCaseWithoutParams<void> {
  final BaseSettingsRepository _repo;

  LogOutUseCase(this._repo);
  @override
  ResultVoid call() => _repo.logout();
}
