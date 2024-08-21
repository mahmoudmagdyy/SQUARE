part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent({
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password,
    this.gender,
    this.id,
  });
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? password;
  final int? gender;
  final int? id;
  @override
  List<Object?> get props =>
      [name, firstName, lastName, phone, email, password, gender, id];
}

class GenderProfileEvent extends ProfileEvent {
  const GenderProfileEvent({super.gender});
}

class PhoneProfileEvent extends ProfileEvent {
  const PhoneProfileEvent({super.phone});
}

class PasswordProfileEvent extends ProfileEvent {
  const PasswordProfileEvent({super.password});
}

class FristNameProfileEvent extends ProfileEvent {
  const FristNameProfileEvent({super.firstName});
}

class LastNameProfileEvent extends ProfileEvent {
  const LastNameProfileEvent({super.lastName});
}

class NameProfileEvent extends ProfileEvent {
  const NameProfileEvent({super.name});
}

class EmailProfileEvent extends ProfileEvent {
  const EmailProfileEvent({super.email});
}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();
}

class UpdateProfileEvent extends ProfileEvent {
  const UpdateProfileEvent();
}

class GetProfileIDEvent extends ProfileEvent {
  const GetProfileIDEvent({super.id});
}
