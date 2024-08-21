import 'package:flutter/cupertino.dart';

import '/index.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.bloc});
  final LoginBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: bloc.formKey,
      child: Column(
        children: [
          TextInputWidget(
            'رقم الجوال',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء ادخال رقم الجوال';
              }
              return null;
            },
            onChanged: (value) => bloc.add(GetPhoneEvent(phone: value!)),
          ),
          16.height,
          LoginPasswordWidget(bloc: bloc),
        ],
      ),
    );
  }
}

class LoginPasswordWidget extends StatefulWidget {
  const LoginPasswordWidget({super.key, required this.bloc});
  final LoginBloc bloc;

  @override
  State<LoginPasswordWidget> createState() => _LoginPasswordWidgetState();
}

class _LoginPasswordWidgetState extends State<LoginPasswordWidget> {
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      'كلمة المرور',
      // hintText: "",
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      isPassword: isPassword,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'الرجاء ادخال كلمة المرور';
        }
        return null;
      },
      suffixIconWidget: IconButton(
        onPressed: () {
          setState(() {
            isPassword = !isPassword;
          });
        },
        icon: Icon(
            isPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash_fill),
      ),
      onChanged: (value) => widget.bloc.add(GetPasswordEvent(password: value!)),
    );
  }
}
