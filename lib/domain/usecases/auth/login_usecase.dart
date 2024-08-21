import '/index.dart';

class LoginUseCase extends UseCaseWithParams<void, LoginParameter> {
  final BaseAuthenticationRepository _repo;

  LoginUseCase(this._repo);
  @override
  ResultFuture<AuthenticationEntity> call(LoginParameter params) async =>
      await _repo.login(
          LoginParameter(phone: params.phone, password: params.password));
}

class LoginParameter extends Equatable {
  final String phone;
  final String password;

  const LoginParameter({required this.phone, required this.password});

  @override
  List<Object?> get props => [phone, password];
}
