import '/index.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});
  final PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          OnboardingBloc bloc = BlocProvider.of<OnboardingBloc>(context);
          return SafeArea(
            child: Stack(
              children: <Widget>[
                PageView(
                  controller: controller,
                  onPageChanged: (index) => bloc.add(OnChangePage(index)),
                  children: [
                    _buildFirstPageView(context: context, bloc: bloc),
                    _buildSecondPageView(context: context, bloc: bloc),
                    _buildThirdPageView(context: context, bloc: bloc),
                  ],
                ),
                _buildActionSection(context, state, bloc),
              ],
            ),
          );
        },
      ),
    );
  }

  Positioned _buildActionSection(
    BuildContext context,
    OnboardingState state,
    OnboardingBloc bloc,
  ) =>
      Positioned(
        bottom: 45.h,
        right: 0,
        left: 0,
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Column(
            children: [
              SmoothIndicator(count: 3, index: state.currentPage),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state.currentPage != 0)
                    InkWell(
                      onTap: () =>
                          bloc.add(PreviousPage(controller, state.currentPage)),
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: AppColors.white,
                        child: SvgPicture.asset(
                          AppImages.arrowRightLine,
                          color: AppColors.greyDark,
                        ),
                      ),
                    ),
                  if (state.currentPage != 0) 15.width,
                  BtnWidget(
                    title: state.currentPage != 2 ? "التالى" : "لنبدأ الآن",
                    width: 190.w,
                    backgroundColor: AppColors.primary,
                    onTap: () {
                      if (state.currentPage != 2) {
                        bloc.add(NextPage(controller, state.currentPage));
                      } else {
                        bloc.add(GetStartedPressed(context));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  PageViewWidget _buildFirstPageView({
    required BuildContext context,
    required OnboardingBloc bloc,
  }) =>
      PageViewWidget(
        onTap: () => bloc.add(GetStartedPressed(context)),
        image: AppImages.onboarding1,
        title: "ابحث عن أفضل مكان",
        subTitle: "للبقاء فى سعر جيد",
      );

  PageViewWidget _buildSecondPageView({
    required BuildContext context,
    required OnboardingBloc bloc,
  }) =>
      PageViewWidget(
        image: AppImages.onboarding2,
        onTap: () => bloc.add(GetStartedPressed(context)),
        title: 'بيع الممتلكات الخاصة بك بسرعة',
        subTitle: 'بنقرة واحدة فقط',
      );

  PageViewWidget _buildThirdPageView({
    required BuildContext context,
    required OnboardingBloc bloc,
  }) =>
      PageViewWidget(
        image: AppImages.onboarding3,
        onTap: () => bloc.add(GetStartedPressed(context)),
        title: 'اعثر على الخيار الأمثل ',
        subTitle: 'لما تريد',
      );
}
