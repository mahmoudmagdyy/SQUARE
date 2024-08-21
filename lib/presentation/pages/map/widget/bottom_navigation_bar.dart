import 'package:aqarat/presentation/bloc/filter/filter_bloc.dart';
import 'package:aqarat/presentation/bloc/home/home_bloc.dart';

import '/index.dart';
import '../../../../data/model/cities_with_area_model.dart';

class BtmNavBarAllAqaratMap extends StatelessWidget {
  const BtmNavBarAllAqaratMap({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      padding: gPadding(right: 25, top: 15, left: 25, bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BtnWidget(
            height: 50,
            onTap: () => citiesBottomSheet(context),
            title: 'قائمة المدن',
            backgroundColor: AppColors.primary,
          ),
          // TextWidget(
          //   'حدد الأحياء التي ترغب بتصفح الاعلانات لها',
          //   style: getTextStyleSimSmall(color: AppColors.textGray1),
          // ),
          20.height,
          BtnWidget(
            height: 50,
            onTap: () {
              if (BlocProvider.of<HomeBloc>(context).selectedCityIDAtMap == 0) {
                showSnackBar(
                  message: 'من فضلك اختر مدينة اولا',
                );
                return;
              } else {
                areaBottomSheet(context);
              }
            },
            title: 'قائمة الأحياء',
            backgroundColor: AppColors.primary,
          )
        ],
      ),
    );
  }

  citiesBottomSheet(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColors.scaffoldBackground,
      shape: RoundedRectangleBorder(borderRadius: 25.radius),
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 0.55.sh,
            child: Stack(
              children: [
                Positioned(
                  bottom: 100,
                  right: 0,
                  left: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      borderRadius: 25.radius,
                    ),
                    padding: gPadding(top: 15, bottom: 15),
                    child: const MyCitiesCheckboxListTile(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    color: AppColors.scaffoldBackground,
                    child: BtnWidget(
                      title: 'تم',
                      onTap: () {
                        if (BlocProvider.of<HomeBloc>(context)
                                .selectedCityIDAtMap ==
                            0) {
                          showSnackBar(
                            message: 'من فضلك اختر مدينة اولا',
                          );
                          return;
                        } else {
                          homeBloc.listOfSelectedArea.clear();
                          i<NavigationService>().pop();
                          areaBottomSheet(context);
                        }
                      },
                      margin:
                          gPadding(left: 20, right: 20, bottom: 30, top: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

areaBottomSheet(BuildContext context) {
  HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: AppColors.scaffoldBackground,
    shape: RoundedRectangleBorder(borderRadius: 25.radius),
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 0.55.sh,
          child: Stack(
            children: [
              Positioned(
                bottom: 100,
                right: 0,
                left: 0,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: 25.radius,
                  ),
                  padding: gPadding(top: 15, bottom: 15),
                  child: const MyAreaCheckboxListTile(),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: AppColors.scaffoldBackground,
                  child: BtnWidget(
                    title: 'تم',
                    onTap: () async {
                      await BlocProvider.of<FilterBloc>(context)
                          .setNullLatAndLng();
                      i<NavigationService>().pop();
                      i<NavigationService>().toNamed(
                        Routes.filter,
                        arguments: {
                          'cityId': homeBloc.selectedCityIDAtMap,
                          'listOfAreas': homeBloc.listOfSelectedArea,
                        },
                      );
                    },
                    margin: gPadding(left: 20, right: 20, bottom: 30, top: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

TextInputWidget _buildSearchBarContent() {
  return const TextInputWidget(
    '',
    hintText: "البحث",
    prefixIcon: Icons.search,
    prefixColor: AppColors.textColor,
  );
}

class MyCitiesCheckboxListTile extends StatefulWidget {
  const MyCitiesCheckboxListTile({super.key});

  @override
  State<MyCitiesCheckboxListTile> createState() =>
      _MyCitiesCheckboxListTileState();
}

class _MyCitiesCheckboxListTileState extends State<MyCitiesCheckboxListTile> {
  int selectedItemId = -1;

  TextEditingController controller = TextEditingController();
  late List<CityAndArea>? cities;
  @override
  void initState() {
    super.initState();
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context, listen: false);
    cities = homeBloc.state.cityWithAreaModel?.cities;
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context, listen: false);
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context, listen: false);
    return Column(
      children: [
        TextWidget(
          "المدن",
          style: getTextStyle16(fontWeight: FontWeight.w800),
        ),
        10.height,
        TextInputWidget(
          '',
          hintText: "البحث",
          prefixIcon: Icons.search,
          controller: controller,
          prefixColor: AppColors.textColor,
          onChanged: (value) {
            if (controller.text.isNotEmpty) {
              cities = homeBloc.state.cityWithAreaModel?.cities
                  .where((element) => element.name.contains(value!))
                  .toList();
            } else {
              cities = homeBloc.state.cityWithAreaModel?.cities;
            }
            setState(() {});
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cities?.length ?? 0,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                title: Text(
                  cities?[index].name ?? '',
                ),
                value: selectedItemId == cities?[index].id,
                onChanged: (newValue) {
                  homeBloc.listOfSelectedArea.clear();
                  if (newValue != null) {
                    setState(() {
                      selectedItemId =
                          newValue ? (cities?[index].id ?? -1) : -1;
                      homeBloc.selectedCityIDAtMap = cities?[index].id ?? 0;
                      filterBloc.listofAreaIds.clear();
                    });
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class MyAreaCheckboxListTile extends StatefulWidget {
  const MyAreaCheckboxListTile({super.key});

  @override
  State<MyAreaCheckboxListTile> createState() => _MyAreaCheckboxListTileState();
}

class _MyAreaCheckboxListTileState extends State<MyAreaCheckboxListTile> {
  late List<bool> checkedValues;
  late int itemCount;
  // controller
  TextEditingController controller = TextEditingController();
  late List<Area>? areas;
  late CityAndArea? selectedCity;
  @override
  void initState() {
    super.initState();
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context, listen: false);
    // selectedCity
    selectedCity = homeBloc.state.cityWithAreaModel?.cities
        .firstWhere((element) => element.id == homeBloc.selectedCityIDAtMap);
    areas = selectedCity?.areas;
    itemCount = areas?.length ?? 0;
    checkedValues = List<bool>.filled(itemCount, false);
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    return Column(
      children: [
        TextWidget(
          "الأحياء",
          style: getTextStyle16(fontWeight: FontWeight.w800),
        ),
        10.height,
        TextInputWidget(
          '',
          hintText: "البحث",
          controller: controller,
          prefixIcon: Icons.search,
          prefixColor: AppColors.textColor,
          onChanged: (value) {
            if (controller.text.isNotEmpty) {
              areas = homeBloc.state.cityWithAreaModel
                  ?.cities[homeBloc.selectedCityIDAtMap].areas
                  .where((element) => element.name.contains(value!))
                  .toList();
              setState(() {
                itemCount = areas?.length ?? 0;
                checkedValues = List<bool>.filled(itemCount, false);
              });
            } else {
              areas = selectedCity?.areas;
              setState(() {
                itemCount = areas?.length ?? 0;
                checkedValues = List<bool>.filled(itemCount, false);
              });
            }
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount:
                areas?.length ?? 0, // Replace with your actual item count
            itemBuilder: (context, index) {
              return CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                title: Text(
                    areas?[index].name ?? ''), // Replace with your item name
                value: checkedValues[index],
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    setState(() {
                      checkedValues[index] = newValue;
                    });
                    BlocProvider.of<HomeBloc>(context)
                        .addAndRemoveArea((areas?[index])!);
                    filterBloc.addAndRemoveAreaId(
                      (areas?[index].id).toString(),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class MyCheckboxListTile extends StatefulWidget {
  const MyCheckboxListTile(this.name, {super.key});
  final String name;
  @override
  State<MyCheckboxListTile> createState() => _MyCheckboxListTileState();
}

class _MyCheckboxListTileState extends State<MyCheckboxListTile> {
  bool checkedValues = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: gPaddingSymmetric(horizontal: 15),
      title: TextWidget(widget.name, style: getTextStyle16()),
      value: checkedValues,
      onChanged: (newValue) {
        setState(() => checkedValues = !checkedValues);
      },
    );
  }
}
