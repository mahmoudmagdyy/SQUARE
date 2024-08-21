import '../../../index.dart';

class SetOtpUseCase
    extends UseCaseWithParams<AuthenticationEntity, SetOtpParameter> {
  final BaseAuthenticationRepository _repository;

  SetOtpUseCase(this._repository);
  @override
  ResultFuture<AuthenticationEntity> call(SetOtpParameter params) async =>
      await _repository.setOtp(params);
}

class SetOtpParameter extends Equatable {
  final String otp;

  const SetOtpParameter({required this.otp});

  @override
  List<Object?> get props => [otp];
}
