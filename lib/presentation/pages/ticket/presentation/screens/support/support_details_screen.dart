import 'package:aqarat/core/widgets/text_form_field_with_title_widget.dart';
import 'package:aqarat/index.dart';

import '../../../data/models/ticket.dart';

class SupportDetailsScreen extends StatelessWidget {
  const SupportDetailsScreen({Key? key, required this.data}) : super(key: key);
  final TickerData data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'السؤال:',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: getTextStyle16(
                color: AppColors.black,
              ),
            ),
            16.verticalSpace,
            Container(
              padding: EdgeInsets.all(8.sp),
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
                    data.problem.toString(),
                    style: getTextStyle18(
                      color: AppColors.primary,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    data.createdAt.toString(),
                    style: getTextStyle16(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            26.verticalSpace,
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  color: getColor(data.status ?? 0),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                width: 95.w,
                height: 30.h,
                child: Text(
                  getStatus(data.status ?? 0),
                  style: getTextStyle18(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            8.verticalSpace,
            Text(
              'الجواب :',
              style: getTextStyle18(
                color: AppColors.black,
              ),
            ),
            12.verticalSpace,
            Container(
              padding: EdgeInsetsDirectional.only(
                start: 8.sp,
                end: 8.sp,
                top: 16.sp,
              ),
              height: 150.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xffF9A636),
                ),
              ),
              child: Text(
                data.answer.toString(),
                style: getTextStyle16(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
