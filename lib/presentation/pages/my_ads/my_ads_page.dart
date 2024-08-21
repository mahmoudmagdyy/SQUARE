import 'package:aqarat/core/widgets/custom_error_widget.dart';
import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/my_ads/my_ads_cubit.dart';
import 'package:aqarat/presentation/widgets/my_ads/my_ads_item_widget.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({Key? key}) : super(key: key);

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  @override
  void initState() {
    final UploadAqarBloc bloc = BlocProvider.of<UploadAqarBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "اعلاناتي"),
      body: BlocBuilder<MyAdsCubit, MyAdsState>(
        builder: (context, state) {
          switch (state.getMyAdsState) {
            case RequestState.none:
            case RequestState.loading:
              return const LoadingWidget(color: AppColors.primary);
            case RequestState.loaded:
              return state.myAds?.isEmpty ?? true
                  ? Center(
                      child: Text(
                        'لا توجد اعلانات',
                        style: getTextStyleLarge(),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async =>
                          context.read<MyAdsCubit>().getMyAds(),
                      child: ListView.builder(
                        itemCount: state.myAds?.length ?? 0,
                        itemBuilder: (context, index) {
                          return MyAdsItemWidget(
                            item: state.myAds![index],
                            index: index,
                          );
                        },
                      ),
                    );
            case RequestState.error:
              return CustomErrorWidget(
                errorMessage: state.getMyAdsErrorMessage ?? 'حدث خطأ ما',
                onRetry: () {
                  context.read<MyAdsCubit>().getMyAds();
                },
              );
          }
        },
      ),
    );
  }
}
