import 'package:aqarat/data/model/search_for_me_model.dart';
import 'package:aqarat/presentation/bloc/search_for_me_cubit/search_for_me_cubit.dart';

import '/index.dart';

class TalabatyPage extends StatefulWidget {
  const TalabatyPage({super.key});

  @override
  State<TalabatyPage> createState() => _TalabatyPageState();
}

class _TalabatyPageState extends State<TalabatyPage> {
  List<String> searchForMeTypeList = ["جديدة", "نشطة", "مغلقة"];
  int currentIndex = 0;
  late List<Property> selectedlist;

  @override
  initState() {
    super.initState();
    BlocProvider.of<SearchForMeCubit>(context).getSearchForMe().then((value) {
      selectedlist = BlocProvider.of<SearchForMeCubit>(context)
          .getSelectedListUsingIndex(currentIndex);
    });
  }

  void onChangedPage(int index) {
    setState(() {
      currentIndex = index;
      selectedlist = BlocProvider.of<SearchForMeCubit>(context)
          .getSelectedListUsingIndex(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "طلباتي", isShowBackButton: false),
      body: SingleChildScrollView(
        child: Container(
          padding: gPaddingSymmetric(horizontal: 15),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.height,
              Row(
                children: [
                  ...List.generate(
                    searchForMeTypeList.length,
                    (index) => Expanded(
                      child: BtnWidget(
                        height: 43,
                        margin: gPadding(right: 14),
                        titleColor: currentIndex == index
                            ? AppColors.white
                            : AppColors.textGray1,
                        backgroundColor: currentIndex == index
                            ? AppColors.primary
                            : AppColors.textGray4.withOpacity(.6),
                        radius: 16,
                        border: Border.all(
                          color: currentIndex == index
                              ? AppColors.primary
                              : AppColors.textGray4.withOpacity(.6),
                        ),
                        title: searchForMeTypeList[index],
                        onTap: () {
                          onChangedPage(index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              57.height,
              BlocBuilder<SearchForMeCubit, SearchForMeCubitState>(
                builder: (context, state) {
                  switch (state.getSearchForMeRequestState) {
                    case RequestState.none:
                    case RequestState.loading:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          200.verticalSpace,
                          const Center(
                              child: CircularProgressIndicator.adaptive()),
                        ],
                      );
                    case RequestState.loaded:
                      return selectedlist.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                100.verticalSpace,
                                Text(
                                  'لا يوجد طلبات',
                                  style: getTextStyle18(),
                                ),
                                20.height,
                                SvgPicture.asset(
                                  AppImages.talabatyEmpty,
                                  height: 211.h,
                                  width: 302..w,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                ...List.generate(
                                  selectedlist.length,
                                  (index) => Card(
                                    child: ListTile(
                                      title: Text(
                                          selectedlist[index].category.name),
                                      subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${selectedlist[index].area.name} - ${selectedlist[index].price.from} : ${selectedlist[index].price.to}'),
                                          selectedlist[index].desc != ''
                                              ? Text(
                                                  selectedlist[index].desc,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : const SizedBox.shrink()
                                        ],
                                      ),
                                      trailing: Text(selectedlist[index].type),
                                    ),
                                  ),
                                ),
                              ],
                            );
                    case RequestState.error:
                      return SvgPicture.asset(
                        'حدث خطأ ما',
                        height: 211.h,
                        width: 302..w,
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
