import '/index.dart';

class ResetPasswordUseCase
    extends UseCaseWithParams<AuthenticationEntity, ResetPasswordParameter> {
  final BaseAuthenticationRepository _repository;

  ResetPasswordUseCase(this._repository);
  @override
  ResultFuture<AuthenticationEntity> call(
          ResetPasswordParameter params) async =>
      await _repository.resetPassword(params);
}

class ResetPasswordParameter extends Equatable {
  final String password;
  final String phone;

  const ResetPasswordParameter({required this.password, required this.phone});

  @override
  List<Object?> get props => [password, phone];
}
