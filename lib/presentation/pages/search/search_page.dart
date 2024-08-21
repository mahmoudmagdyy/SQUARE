import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/home/home_bloc.dart';
import 'package:aqarat/presentation/pages/home/widgets/card_ad_widget.dart';
import 'package:aqarat/presentation/widgets/empty_list_widget.dart';
import 'package:flutter/cupertino.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final HomeBloc bloc = context.read<HomeBloc>();
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.h,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: gPadding(right: 15, top: 0, left: 15, bottom: 5.0),
              child: Row(
                children: [
                  Padding(
                    padding: gPadding(top: 17.5),
                    child: IconButton.filled(
                      style: IconButton.styleFrom(
                        fixedSize: Size(45.h, 47.5.h),
                        shape: RoundedRectangleBorder(borderRadius: 4.radius),
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () => i<NavigationService>().pop(),
                      icon: SvgPicture.asset(
                        AppImages.arrowRightLine,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextInputWidget(
                      '',
                      hintText: 'ابحث عن منزل ، شقة ، إلخ',
                      prefixIcon: CupertinoIcons.search,
                      prefixColor: AppColors.orange,
                      controller: bloc.controller,
                      onChanged: (value) =>
                          bloc.add(const GetSearchProductsEvent()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: (state.search.isEmpty && bloc.controller.text.isEmpty)
              ? SingleChildScrollView(
                  child: EmptyListWidget(
                    image: AppImages.search,
                    subTitle: AppStrings.subTitleSearch,
                  ),
                )
              : (state.requestStateSearch == RequestState.loaded)
                  ? (state.search.isEmpty || bloc.controller.text.isEmpty)
                      ? SingleChildScrollView(
                          child: EmptyListWidget(
                            image: AppImages.search,
                            subTitle: AppStrings.subTitleSearch,
                          ),
                        )
                      : ListView.separated(
                          padding:
                              gPadding(right: 15, top: 5, left: 15, bottom: 15),
                          itemCount: bloc.state.search.length,
                          separatorBuilder: (context, index) => 15.height,
                          itemBuilder: (context, index) {
                            return CardAdWidget(
                              adsModel: bloc.state.search[index],
                            );
                          },
                        )
                  : const LoadingWidget(color: AppColors.loadingColor),
        );
      },
    );
  }
}
