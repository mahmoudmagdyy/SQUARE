import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyAdCubit, EditMyAdState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BtnWidget(
              title: "الميزانية",
              width: 140,
              height: 45,
              style: getTextStyle16(
                  fontWeight: FontWeight.w600, color: AppColors.white),
              radius: 8,
              onTap: null,
            ),
            Row(
              children: [
                TextWidget(
                  // state.property?.price.toString() ?? "0.00",
                  context.read<EditMyAdCubit>().priceController.text ?? "0.00",
                  // bloc.state.price.isEmpty
                  //     ? "0.00"
                  //     : OtherMethods.format(
                  //         int.parse(bloc.state.price)),
                  style: getTextStyle18(
                    color: AppColors.textGray22,
                  ),
                ),
                5.width,
                TextWidget(
                  'ريال',
                  style: getTextStyle18(
                    color: AppColors.textGray22,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
