part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final RequestState requestState;
  final ProfileEntity? model;
  final String message;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final int gender;
  final File? image;
  const ProfileState({
    this.requestState = RequestState.none,
    this.model,
    this.message = '',
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.gender = 1,
    this.image,
  });

  ProfileState copyWith({
    RequestState? requestState,
    ProfileEntity? model,
    String? message,
    int? gender,
    String? name,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? password,
    File? image,
  }) =>
      ProfileState(
        model: model ?? this.model,
        requestState: requestState ?? this.requestState,
        message: message ?? this.message,
        gender: gender ?? this.gender,
        username: name ?? username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        password: password ?? this.password,
        image: image ?? this.image,
      );

  @override
  List<Object?> get props => [
        model,
        requestState,
        message,
        gender,
        username,
        firstName,
        lastName,
        phone,
        email,
        password,
        image,
      ];
}
