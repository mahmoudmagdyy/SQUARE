import 'package:aqarat/data/data_source/remote/profile/base_profile_remote_data_source.dart';

import '/index.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUsecase;

  final formKey = GlobalKey<FormState>();

  LoginBloc(this._loginUsecase) : super(const LoginState()) {
    on<OnTapedLoginEvent>(_login);
    on<GetPhoneEvent>(_phone);
    on<GetPasswordEvent>(_password);
  }
  Future<void> _login(
    OnTapedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(requestState: RequestState.loading));

      final result = await _loginUsecase(
        LoginParameter(phone: state.phone, password: state.password),
      );
      result.fold(
        (left) {
          showSnackBar(message: left.message, isError: true);

          emit(state.copyWith(requestState: RequestState.error));
        },
        (right) async{
          showSnackBar(message: right.message);
          print(right.data);
          sl<AppPreferences>().setToken(right.data.token);
          sl<AppPreferences>().setUserId(right.data.id.toString());
          sl<AppPreferences>().setUserName(right.data.name.toString());
          sl<AppPreferences>().setFirstName(right.data.firstName.toString());
          sl<AppPreferences>().setLastName(right.data.lastName.toString());
          sl<AppPreferences>().setImgUrl(right.data.avatar.toString());
          sl<AppPreferences>().setEmail(right.data.email.toString());
          sl<AppPreferences>().setPhone(right.data.phone.toString());

         right.data.role.toLowerCase()=='user'? sl<AppPreferences>().setUserRole(
            right.data.role.toLowerCase() == 'user' ,
          ):sl<AppPreferences>().setUserRole(
           right.data.role.toLowerCase() == 'admin' ,
         );
           sl<AppPreferences>().onSubmittedLogin;
          sl<NavigationService>().toNamedAndRemoveUntil(Routes.main);
          emit( await state.copyWith(requestState: RequestState.loaded,
              model: right
          ));
        },
      );
    }
  }

  void _phone(GetPhoneEvent event, Emitter<LoginState> emit) =>
      emit(state.copyWith(phone: event.phone));

  void _password(GetPasswordEvent event, Emitter<LoginState> emit) =>
      emit(state.copyWith(password: event.password));
}
