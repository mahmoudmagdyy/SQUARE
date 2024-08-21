import '../../../index.dart';

class RegisterUseCase
    extends UseCaseWithParams<AuthenticationEntity, RegisterParameter> {
  final BaseAuthenticationRepository _repository;

  RegisterUseCase(this._repository);
  @override
  ResultFuture<AuthenticationEntity> call(RegisterParameter params) async =>
      await _repository.register(params);
}

class RegisterParameter extends Equatable {
  const RegisterParameter({
    required this.name,
    required this.fristName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.email,
    required this.gender,
  });
  final String name;
  final String fristName;
  final String lastName;
  final String phone;
  final String password;
  final String email;
  final int gender;
  @override
  List<Object?> get props =>
      [name, fristName, lastName, phone, password, email, gender];
}
