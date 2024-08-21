import 'package:aqarat/index.dart';

class SupportItemWidget extends StatelessWidget {
  const SupportItemWidget({
    super.key,
    required this.title,
    required this.date,
    required this.bgColor,
    required this.status,
    required this.onTap,
    required this.description,
  });
  final String title;
  final String description;
  final String date;
  final Color bgColor;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.sp),
        // height: 78.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.primary,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getTextStyle18(
                color: AppColors.black,
              ),
            ),
            8.verticalSpace,
            Text(
              date,
              style: getTextStyle16(
                color: AppColors.greyDark2,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle16(
                      color: AppColors.greyDark2,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  width: 110.w,
                  height: 30.h,
                  child: Text(
                    status,
                    style: getTextStyle18(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
