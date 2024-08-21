import '/index.dart';

List<AgeModel> reldContent = [
  const AgeModel(id: 1, name: 'يومي'),
  const AgeModel(id: 2, name: 'شهري'),
  const AgeModel(id: 3, name: 'سنوي'),
];

class CityAqarContent extends StatelessWidget {
  const CityAqarContent({
    super.key,
    // required this.uploadAqarBloc,
    required this.title,
    this.color,
    required this.array,
    required this.onSelectedValue,
  });
  // final UploadAqarBloc uploadAqarBloc;
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
          AppStrings.cityAqar,
          style: getTextStyle16(fontWeight: FontWeight.w600),
        ),
        5.height,
        ExpandableWidget(
          title: title,
          color: color,
          array: array,
          onSelectedValue: onSelectedValue,
          // title: uploadAqarBloc.state.city.isEmpty
          //     ? AppStrings.cityAqar
          //     : uploadAqarBloc.state.city,
          // color: uploadAqarBloc.state.city.isEmpty ? null : AppColors.black,
          // array: uploadAqarBloc.state.cities,
          // onSelectedValue: (value) => uploadAqarBloc.add(
          //   GetCityAqarEvent(
          //     city: uploadAqarBloc.state.cities[value].name.toString(),
          //     cityId: uploadAqarBloc.state.cities[value].id.toString(),
          //     selectedCity: value,
          //   ),
          // ),
        ),
      ],
    );
  }
}
