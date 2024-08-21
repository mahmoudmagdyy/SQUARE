import 'package:aqarat/domain/repository/settings/base_settings_respository.dart';
import '/index.dart';

class DeleteAccountUseCase extends UseCaseWithoutParams<void> {
  final BaseSettingsRepository _repo;

  DeleteAccountUseCase(this._repo);
  @override
  ResultVoid call() => _repo.deleteAccount();
}
