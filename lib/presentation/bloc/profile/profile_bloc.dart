import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:aqarat/domain/entities/profile/profile_entity.dart';
import 'package:aqarat/domain/usecases/profile/get_profile_id_usecase.dart';
import 'package:aqarat/domain/usecases/profile/get_profile_usecase.dart';
import 'package:aqarat/domain/usecases/profile/update_profile_usecase.dart';
import 'package:image_picker/image_picker.dart';

import '/index.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final formKey = GlobalKey<FormState>();
  ProfileBloc(
    this._profileIdUseCase,
    this._getProfileUseCase,
    this._updateProfileUseCase,
  ) : super(const ProfileState()) {
    on<FristNameProfileEvent>(_firstName);
    on<LastNameProfileEvent>(_lastName);
    on<NameProfileEvent>(_name);
    on<EmailProfileEvent>(_email);
    on<PhoneProfileEvent>(_phone);
    on<PasswordProfileEvent>(_password);
    on<GenderProfileEvent>(_gender);

    on<UpdateProfileEvent>(_onTapedUpdateProfile);
    on<GetProfileEvent>(_getProfile);
    on<GetProfileIDEvent>(_getProfileId);
  }
  final GetProfileIdUseCase _profileIdUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  String? email;

  void _firstName(FristNameProfileEvent event, Emitter<ProfileState> emit) =>
      emit(state.copyWith(firstName:event.firstName ));

  void _lastName(LastNameProfileEvent event, Emitter<ProfileState> emit) =>
      emit(state.copyWith(lastName: event.lastName));

  void _name(NameProfileEvent event, Emitter<ProfileState> emit) =>
      emit(state.copyWith(name: event.name));

  void _email(EmailProfileEvent event, Emitter<ProfileState> emit) =>
      emit(state.copyWith(email: event.email));

  void _phone(PhoneProfileEvent event, Emitter<ProfileState> emit) =>
      emit(state.copyWith(phone: event.phone));

  void _password(PasswordProfileEvent event, Emitter<ProfileState> emit) =>
      emit(state.copyWith(password: event.password));

  void _gender(GenderProfileEvent event, Emitter<ProfileState> emit) =>
      emit(state.copyWith(gender: event.gender));

  Future<void> _onTapedUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      log("===> ${state.firstName}");
      emit(state.copyWith(requestState: RequestState.loading));
      final result = await _updateProfileUseCase(
        UpdateProfileParameter(
          firstName: state.firstName.isEmpty
              ? state.model!.data.firstName
              : state.firstName,
          username: state.username.isEmpty
              ? state.model!.data.username
              : state.username,
          lastName: state.lastName.isEmpty
              ? state.model!.data.lastName
              : state.lastName,
          phone: state.phone.isEmpty ? state.model!.data.phone : state.phone,
          email: sl<AppPreferences>().getEmail,
          image: state.image?.path,
        ),
      );

      result.fold(
        (left) {
          showSnackBar(message: left.message, isError: true);
          emit(state.copyWith(
              message: left.message, requestState: RequestState.error));
        },
        (right) {
          showSnackBar(message: "تم تحديث البيانات بنجاح");
          // sl<NavigationService>().pop();
          log("=======> $right");
          emit(state.copyWith(requestState: RequestState.loaded, model: right));
        },
      );
      emit(state.copyWith(requestState: RequestState.none));
    }
  }

  Future<void> _getProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _getProfileUseCase();

    result.fold(
      (left) {
        showSnackBar(message: left.message, isError: true);
        emit(state.copyWith(
            message: left.message, requestState: RequestState.error));
      },
      (right) {
        email = right.data.email;
        log("Get Profile Data =======> $right");
        print(right.data);
        // showSnackBar(message: right.message);
        emit(state.copyWith(requestState: RequestState.loaded, model: right));
      },
    );
    emit(state.copyWith(requestState: RequestState.none));
  }

  Future<void> _getProfileId(
      GetProfileIDEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _profileIdUseCase(
      GetProfileIdParameter(id: "${event.id}"),
    );

    result.fold(
      (left) {
        showSnackBar(message: left.message, isError: true);

        emit(state.copyWith(
            message: left.message, requestState: RequestState.error));
      },
      (right) {
        // showSnackBar(message: right.message);
        emit(state.copyWith(requestState: RequestState.loaded, model: right));
      },
    );
    emit(state.copyWith(requestState: RequestState.none));
  }

  void pickImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then(
      (value) {
        if (value != null) {
          emit(
            state.copyWith(
              image: File(value.path),
            ),
          );
          // bloc.add(UpdateProfileImageEvent(value.path));
        }
      },
    );
  }
}
