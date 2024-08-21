import '/index.dart';

class TypeReldContent extends StatelessWidget {
  const TypeReldContent({
    super.key,
    // required this.bloc,
    required this.title,
    this.color,
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
          'طريقة الدفع',
          style: getTextStyleNormal(
              color: AppColors.black, fontWeight: FontWeight.w500),
        ),
        10.height,
        ExpandableWidget(
          title: title,
          color: color,
          array: array,
          onSelectedValue: onSelectedValue,
          // title: bloc.state.realedType.isEmpty
          //     ? 'نوع الايجار'
          //     : bloc.state.realedType,
          // color: bloc.state.realedType.isEmpty ? null : AppColors.black,
          // array: reldContent,
          // onSelectedValue: (value) =>
          //     bloc.add(GetRealedTypeEvent(realedType: reldContent[value].name)),
        ),
      ],
    );
  }
}
