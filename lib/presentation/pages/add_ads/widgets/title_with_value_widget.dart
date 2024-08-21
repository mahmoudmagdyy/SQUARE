import 'package:aqarat/index.dart';

class TitleWithValueWidget extends StatelessWidget {
  const TitleWithValueWidget({
    super.key,
    required this.title,
    required this.values,
    required this.onSelectedValue,
    required this.backgroundColor,
    required this.color,
  });
  final String title;
  final List<String> values;
  final ValueChanged<int> onSelectedValue;
  final Color? backgroundColor;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(title, style: getTextStyle16()),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              values.length,
              (index) => GestureDetector(
                onTap: () => onSelectedValue(index),
                child: Container(
                  height: 38.h,
                  width: 38.h,
                  margin: gPadding(right: 5.0, bottom: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    // ? AppColors.primary
                    // : AppColors.greyLight,
                    borderRadius: 8.radius,
                  ),
                  child: TextWidget(
                    values[index].toString(),
                    style: getTextStyle16(
                      fontWeight: FontWeight.w600,
                      color: color?? AppColors.textColor,
                      
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
