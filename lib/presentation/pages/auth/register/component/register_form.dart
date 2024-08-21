import 'package:flutter/cupertino.dart';

import '/index.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.bloc});
  final RegisterBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: bloc.formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextInputWidget(
                  'الاسم الاول',
                  // hintText: "",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'الرجاء ادخال  الاسم الاول';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) =>
                      bloc.add(FristNameRegisterEvent(firstName: value)),
                ),
              ),
              10.width,
              Expanded(
                child: TextInputWidget(
                  'الاسم الاخير',
                  // hintText: "",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'الرجاء ادخال  الاسم الاخير';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) =>
                      bloc.add(LastNameRegisterEvent(lastName: value)),
                ),
              ),
            ],
          ),
          15.height,
          TextInputWidget(
            'الكنية',
            // hintText: "",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء ادخال ';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onChanged: (value) =>
                bloc.add(NickNameRegisterEvent(nickname: value)),
          ),
          15.height,
          TextInputWidget(
            'البريد الالكترونى',
            // hintText: "",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء ادخال البريد الالكترونى';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (value) => bloc.add(EmailRegisterEvent(email: value)),
          ),
          15.height,
          TextInputWidget(
            'رقم الجوال',
            // hintText: "",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء ادخال رقم الجوال';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            onChanged: (value) => bloc.add(PhoneRegisterEvent(phone: value)),
          ),
          15.height,
          TextInputWidget(
            'كلمة المرور',
            // hintText: "",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء ادخال كلمة المرور';
              }
              return null;
            },

            keyboardType: TextInputType.visiblePassword,
            suffixIcon: bloc.state.isPassword
                ? CupertinoIcons.eye_slash
                : CupertinoIcons.eye,
            textInputAction: TextInputAction.done,
            onChanged: (value) =>
                bloc.add(PasswordRegisterEvent(password: value)),
            isPassword: bloc.state.isPassword,
            onPressed: () => bloc
                .add(HiddenPasswordEvent(isPassword: !bloc.state.isPassword)),
          ),
          15.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RadioListTileWiget(
                  title: "ذكر",
                  value: 0,
                  groupValue: bloc.state.gender,
                  onChanged: (value) =>
                      bloc.add(GenderRegisterEvent(gender: value as int)),
                ),
              ),
              Expanded(
                child: RadioListTileWiget(
                  title: "انثى",
                  value: 1,
                  groupValue: bloc.state.gender,
                  onChanged: (value) =>
                      bloc.add(GenderRegisterEvent(gender: value as int)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
