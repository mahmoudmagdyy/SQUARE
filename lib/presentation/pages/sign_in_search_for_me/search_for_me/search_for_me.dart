// import '/index.dart';
import 'package:aqarat/core/utils/app_colors.dart';
import 'package:aqarat/core/utils/app_images.dart';
import 'package:aqarat/core/utils/extension.dart';
import 'package:aqarat/presentation/widgets/app_bar_widget.dart';
import 'package:aqarat/presentation/widgets/app_text/text_widget.dart';
import 'package:aqarat/presentation/widgets/buttons/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/search_for_me_bloc/search_for_me_bloc.dart';

class SearchForMePage extends StatelessWidget {
  const SearchForMePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> searchForMeTypeList = ["جديدة", "نشطة", "مغلقة"];

    return BlocConsumer<SearchForMeBloc, SearchForMeInitial>(
      listener: (context, state) {},
      bloc: context.read<SearchForMeBloc>(),
      /* buildWhen: (previous, current) => !current.requestState.isLoading, */
      builder: (context, state) {
        final SearchForMeBloc bloc = context.read<SearchForMeBloc>();
        return Scaffold(
          appBar: const AppBarWidget(title: 'ابحث لي'),
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
                            titleColor: bloc.state.searchForMeType ==
                                    searchForMeTypeList[index]
                                ? AppColors.white
                                : AppColors.textGray1,
                            backgroundColor: bloc.state.searchForMeType ==
                                    searchForMeTypeList[index]
                                ? AppColors.primary
                                : AppColors.textGray4.withOpacity(.6),
                            radius: 16,
                            border: Border.all(
                              color: bloc.state.searchForMeType ==
                                      searchForMeTypeList[index]
                                  ? AppColors.primary
                                  : AppColors.textGray4.withOpacity(.6),
                            ),
                            title: searchForMeTypeList[index],
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  57.height,
                  SvgPicture.asset(
                    AppImages.talabatyEmpty,
                    height: 211.h,
                    width: 302..w,
                  ),
                  54.height,
                  const TextWidget('لا توجد لديك اي طلبات أضف طلبك الأول'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
