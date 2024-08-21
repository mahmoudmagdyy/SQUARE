import '/index.dart';

List<String> adTypeList = [AppStrings.sale, AppStrings.rent];

class TypeAqarContent extends StatelessWidget {
  // required this.bloc,

  const TypeAqarContent({
    super.key,
    required this.title,
    required this.color,
    required this.array,
    required this.onSelectedValue,
  });
  // final UploadAqarBloc bloc;
  final String title;
  final Color? color;
  final List<dynamic> array;
  final void Function(int) onSelectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          AppStrings.aqarType,
          style: getTextStyle16(fontWeight: FontWeight.w600),
        ),
        5.height,
        ExpandableWidget(
          title: title,
          color: color,
          array: array,
          onSelectedValue: onSelectedValue,
          // title: bloc.state.aqarType.isEmpty
          //     ? AppStrings.aqarType
          //     : bloc.state.aqarType,
          // color: bloc.state.aqarType.isEmpty ? null : AppColors.black,

          // array: bloc.state.types,

          // onSelectedValue: (value) => bloc.add(
          //   GetTypeAqarEvent(
          //     aqarIdType: bloc.state.types[value].id.toString(),
          //     aqarType: bloc.state.types[value].name.toString(),
          //   ),
          // ),
        ),
      ],
    );
  }
}
