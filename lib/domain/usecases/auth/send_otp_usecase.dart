import '../../../index.dart';

class SendOtpUseCase
    extends UseCaseWithParams<AuthenticationEntity, SendOtpParameter> {
  final BaseAuthenticationRepository _repository;

  SendOtpUseCase(this._repository);
  @override
  ResultFuture<AuthenticationEntity> call(SendOtpParameter params)async =>
      await _repository.getOtp(params);
}

class SendOtpParameter extends Equatable {
  final String phone;

  const SendOtpParameter({required this.phone});

  @override
  List<Object?> get props => [phone];
}
