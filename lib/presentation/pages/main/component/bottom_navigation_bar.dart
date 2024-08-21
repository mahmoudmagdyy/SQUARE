import '/index.dart';

class BottomNavigatiBar extends StatelessWidget {
   BottomNavigatiBar({super.key, required this.bloc});
  final MainBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFAAAAAA).withOpacity(0.35),
            blurRadius: 5,
            offset: const Offset(-2, 2),
          ),
        ],
      ),
      child: BottomAppBar(
        height: 68.h,
        elevation: 0.0,
        // clipBehavior: Clip.hardEdge,
        // notchMargin: 7.5.w,
        color: AppColors.white,
        child:sl<SharedPreferences>().getBool("isAnonymous")==false? Row(
          children: [
            ...List.generate(
              bloc.state.titles.length + 1,
              (index) {
                int x = index > 2 ? index - 1 : index;
                return index == 2
                    ? const Spacer()
                    : _buildMaterialButtonWidget(
                        callback: () {
                          bloc.add(ChangePage(index: x));
                        },
                        image: bloc.state.images[x],
                        title: bloc.state.titles[x],
                        isSelected: bloc.state.currentIndex == x ? true : false,
                      );
              },
            )
          ],
        ):Center(
          child: _buildMaterialButtonWidget(
            callback: () {
              bloc.add(ChangePage(index: 0));
            },
            image: bloc.state.images[0],
            title: bloc.state.titles[0],
            isSelected: bloc.state.currentIndex == 0 ? true : false,
          )
          ,
        ),
      ),
    );
  }

  Widget _buildMaterialButtonWidget({
    required VoidCallback callback,
    required String image,
    required String title,
    required bool isSelected,
  }) {
    return MaterialButton(
      minWidth: 60.w,
      onPressed: callback,
      hoverColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            color: isSelected ? AppColors.primaryDeep : AppColors.textGray1,
            height: 20.h,
            width: 20.h,
          ),
          5.height,
          TextWidget(
            title,
            style: getTextStyleNormal(
              color: isSelected ? AppColors.primaryDeep : AppColors.textGray1,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
