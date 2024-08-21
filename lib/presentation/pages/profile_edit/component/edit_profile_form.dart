import 'package:aqarat/presentation/bloc/profile/profile_bloc.dart';

import '/index.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key, required this.bloc});
  final ProfileBloc bloc;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late TextEditingController name;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController phone;
  late TextEditingController email;

  @override
  void initState() {
    name = TextEditingController(text: sl<AppPreferences>().getUserName);
    firstName =
        TextEditingController(text: sl<AppPreferences>().getFirstName);
    lastName =
        TextEditingController(text: sl<AppPreferences>().getLastName);
    phone = TextEditingController(text: sl<AppPreferences>().getPhone);
    email = TextEditingController(text: sl<AppPreferences>().getEmail);
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    firstName.dispose();
    lastName.dispose();
    phone.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.bloc.formKey,
      child: Column(
        children: [
          15.height,
          TextInputWidget(
            'الاسم الاول',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الاسم الاول مطلوب';
              }
              return null;
            },
            controller: firstName,
            onChanged: (value) =>
                widget.bloc.add(FristNameProfileEvent(firstName: value)),
          ),
          TextInputWidget(
            'الاسم الاخير',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الاسم الاخير مطلوب';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: lastName,
            onChanged: (value) =>
                widget.bloc.add(LastNameProfileEvent(lastName: value)),
          ),
          // 15.height,
          // TextInputWidget(
          //   'الاسم',
          //   validator: (value) {
          //     if (value == null || value.trim().isEmpty) {
          //       return 'الاسم  مطلوب';
          //     }
          //     return null;
          //   },
          //   keyboardType: TextInputType.name,
          //   textInputAction: TextInputAction.next,
          //   controller: name,
          //   onChanged: (value) =>
          //       widget.bloc.add(NameProfileEvent(name: value)),
          // ),
          15.height,
          TextInputWidget(
            'البريد الالكترونى',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'البريد الالكترونى مطلوب';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: email,
            onChanged: (value) =>
                widget.bloc.add(EmailProfileEvent(email: value)),
          ),
          15.height,
          TextInputWidget(
            'رقم الجوال',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'رقم الجوال مطلوب';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            controller: phone,
            onChanged: (value) =>
                widget.bloc.add(PhoneProfileEvent(phone: value)),
          ),
        ],
      ),
    );
  }
}
