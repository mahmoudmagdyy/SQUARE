import 'package:aqarat/index.dart';

import '../../bloc/publish_add/publish_add_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    BlocProvider.of<PublishAddCubit>(context).getAdminPhoneNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        MainBloc bloc = BlocProvider.of(context);
        return Scaffold(
          body: bloc.state.pages.elementAt(bloc.state.currentIndex),
          // key: bloc.state.key,
          // extendBody: true,
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          //     ? const FloatingButtonWidget()
          //     : const SizedBox.shrink(),
          bottomNavigationBar: BottomNavigatiBar(bloc: bloc),
        );
      },
    );
  }
}

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: GestureDetector(
        onTap: () async{
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.getBool("isAnonymous")==false? i<NavigationService>().toNamed(Routes.addAdsDetails):{
            i<NavigationService>().toNamed(Routes.login),
            prefs.setBool("isAnonymous",false),
            print(prefs.getBool("isAnonymous")),
            showSnackBar(message: "يجب تسجيل الدخول")
          };
          // i<NavigationService>().toNamed(Routes.addAdsDetails);
        },
        child: CircleAvatar(
          backgroundColor: AppColors.secondary,
          radius: 35.r,
          child: Container(
            height: 25.h,
            width: 25.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.white.withOpacity(.4)),
            child: Icon(
              Icons.add,
              color: AppColors.white,
              size: 18.h,
            ),
          ),
        ),
      ),
    );
  }
}
