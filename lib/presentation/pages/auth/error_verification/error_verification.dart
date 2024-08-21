import '/index.dart';

class ErrorVerificationScreen extends StatelessWidget {
  const ErrorVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BtnWidget(
        title: 'الرجوع للخلف',
        onTap: () => Navigator.pushNamed(context, Routes.main),
        margin: gPadding(left: 20, right: 20, bottom: 32),
      ),
      body: Container(
        width: 375.w,
        padding: gPaddingSymmetric(horizontal: 20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                122.height,
                TextWidget(
                  "! حدث خطأ غير متوقع",
                  textAlign: TextAlign.center,
                  style: getTextStyleLarge(fontWeight: FontWeight.w500),
                ),
                30.height,
                authImg(AppImages.error, hi: 236, we: 354),
                162.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
