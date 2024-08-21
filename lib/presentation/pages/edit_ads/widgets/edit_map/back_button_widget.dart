import 'package:aqarat/index.dart';
import 'package:flutter/cupertino.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.h,
      right: 20.w,
      left: 20.w,
      child: Row(
        children: [
          Padding(
            padding: gPadding(top: 25),
            child: IconButton.filled(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: 4.radius),
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                i<NavigationService>().pop();
              },
              icon: Icon(
                CupertinoIcons.arrow_right,
                color: AppColors.white,
                size: 20.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
