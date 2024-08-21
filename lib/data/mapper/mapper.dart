import '../../index.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return AppConstants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return AppConstants.zero;
    } else {
      return this!;
    }
  }
}

/* extension SignResponseMapper on SignRespons? {
  SignEntity toDomain() {
    return SignEntity(
      id: this?.id.orZero() ?? AppConstant.zero,
      name: this?.name.orEmpty() ?? AppConstant.empty,
      firstName: this?.firstName.orEmpty() ?? AppConstant.empty,
      middleName: this?.middleName.orEmpty() ?? AppConstant.empty,
      lastName: this?.lastName.orEmpty() ?? AppConstant.empty,
      phone: this?.phone.orEmpty() ?? AppConstant.empty,
      email: this?.email.orEmpty() ?? AppConstant.empty,
      token: this?.token.orEmpty() ?? AppConstant.empty,
      avatar: this?.avatar.orEmpty() ?? AppConstant.empty,
      gender: this?.gender.orEmpty() ?? AppConstant.empty,
      status: this?.status.orEmpty() ?? AppConstant.empty,
      createdAt: this?.createdAt.orEmpty() ?? AppConstant.empty,
    );
  }
} */

/* extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.signRespons);
  }
} */
