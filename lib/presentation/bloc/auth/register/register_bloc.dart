import 'dart:developer';

import '/index.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _useCase;
  final formKey = GlobalKey<FormState>();
  RegisterBloc(this._useCase) : super(const RegisterState()) {
    on<FristNameRegisterEvent>(_fristName);
    on<LastNameRegisterEvent>(_lastName);
    on<NickNameRegisterEvent>(_nickname);
    on<EmailRegisterEvent>(_email);
    on<PhoneRegisterEvent>(_phone);
    on<PasswordRegisterEvent>(_password);
    on<GenderRegisterEvent>(_gender);
    on<OtpRegisterEvent>(_otp);
    on<OnTapedRegisterEvent>(_onRegister);
    on<HiddenPasswordEvent>(_isHiddenPassword);
  }

  Future<void> _onRegister(
    OnTapedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(requestState: RequestState.loading));
      final result = await _useCase(
        RegisterParameter(
          name: state.nickname,
          fristName: state.firstName,
          lastName: state.lastName,
          phone: state.phone,
          password: state.password,
          email: state.email,
          gender: state.gender,
        ),
      );

      result.fold(
        (left) {
          log("error in register ==> ${left.message}");
          showSnackBar(message: left.message, isError: true);
          emit(state.copyWith(
              message: left.message, requestState: RequestState.error));
        },
        (right) {
          log("loaded in register ==> ${right.message}");
          showSnackBar(message: right.message);
          // sl<NavigationService>().toNamed(Routes.verificationRegister);
          sl<AppPreferences>().setToken(right.data.token);
          sl<AppPreferences>().setUserId(right.data.id.toString());
          sl<AppPreferences>().setUserName(right.data.name.toString());
          sl<AppPreferences>().setUserRole(
            right.data.role.toLowerCase() == 'user',
          );
          sl<AppPreferences>().onSubmittedLogin;
          sl<NavigationService>().toNamedAndRemoveUntil(Routes.main);
          emit(state.copyWith(requestState: RequestState.loaded, model: right));
        },
      );
    }
  }

  void _fristName(FristNameRegisterEvent event, Emitter<RegisterState> emit) =>
      emit(state.copyWith(firstName: event.firstName));

  void _lastName(LastNameRegisterEvent event, Emitter<RegisterState> emit) =>
      emit(state.copyWith(lastName: event.lastName));

  void _nickname(NickNameRegisterEvent event, Emitter<RegisterState> emit) =>
      emit(state.copyWith(nickname: event.nickname));

  void _email(EmailRegisterEvent event, Emitter<RegisterState> emit) =>
      emit(state.copyWith(email: event.email));

  void _phone(PhoneRegisterEvent event, Emitter<RegisterState> emit) =>
      emit(state.copyWith(phone: event.phone));

  void _password(PasswordRegisterEvent event, Emitter<RegisterState> emit) =>
      emit(state.copyWith(password: event.password));

  void _gender(GenderRegisterEvent event, Emitter<RegisterState> emit) =>
      emit(state.copyWith(gender: event.gender));

  void _otp(OtpRegisterEvent event, Emitter<RegisterState> emit) =>
      emit(state.copyWith(otp: event.otp));

  void _isHiddenPassword(
    HiddenPasswordEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isPassword: event.isPassword));
  }
}
