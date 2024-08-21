part of 'main_bloc.dart';

class MainState extends Equatable {
  MainState({this.currentIndex = 0});
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  final int currentIndex;

  List<Widget> get pages => [
         HomePage(),
        const MapPage(),
        const TalabatyPage(),
        const SupportScreen(),
        const MainChatScreen()
      ];

  final List<String> images = [
    AppImages.home,
    AppImages.map,
    AppImages.talabaty,
    AppImages.incomes,
    AppImages.commuinty,
  ];
  final List<String> titles = [
    AppStrings.home,
    AppStrings.map,
    AppStrings.talabaty,
    'البلاغات',
    'المحادثات'
  ];

  @override
  List<Object> get props => [key, images, titles, currentIndex];
}

final class MainInitial extends MainState {}
