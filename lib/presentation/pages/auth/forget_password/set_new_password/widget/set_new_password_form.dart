import 'package:aqarat/presentation/bloc/auth/forget_password/forget_password_bloc.dart';
import '/index.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key, required this.bloc});
  final ForgetPasswordBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputWidget(
          'رقم الجوال',
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          onChanged: (value) => bloc.add(ForgetPassPhoneEvent(phone: value!)),
        ),
        15.height,
      ],
    );
  }
}
