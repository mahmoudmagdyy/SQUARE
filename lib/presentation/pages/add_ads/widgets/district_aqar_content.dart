import '/index.dart';

class DistrictAqarContent extends StatelessWidget {
  const DistrictAqarContent({
    super.key,
    required this.title,
    this.color,
    required this.array,
    required this.onSelectedValue,
    required this.absorbing,
    // required this.uploadAqarBloc,
  });
  // final UploadAqarBloc uploadAqarBloc;
  final String title;
  final Color? color;
  final List<dynamic> array;
  final void Function(int) onSelectedValue;
  final bool absorbing;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          AppStrings.districtAqar,
          style: getTextStyle16(fontWeight: FontWeight.w600),
        ),
        5.height,
        AbsorbPointer(
          // absorbing: uploadAqarBloc.state.city.isEmpty ? true : false,
          absorbing: absorbing,
          child: ExpandableWidget(
            title: title,
            array: array,
            onSelectedValue: onSelectedValue,
            color: color,
          ),
        ),
      ],
    );
  }
}
