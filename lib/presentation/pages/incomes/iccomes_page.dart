import '/index.dart';

class IncomesPage extends StatelessWidget {
  const IncomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "المحادثات", isShowBackButton: false),
      body: Container(
        padding: gPaddingSymmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildBodyContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent() => Column(
        children: [
          _searchbar(),
          15.height,
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _buildChatContent(),
            itemCount: 6,
          )
        ],
      );

  Column _buildChatContent() {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: gPadding(),
          leading: GestureDetector(
            onTap: () => i<NavigationService>().toNamed(Routes.settings),
            child: Container(
              height: 52.h,
              width: 52.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.grey),
                image: const DecorationImage(
                  image: AssetImage(''),
                ),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                'تطبيق العقارات',
                style: getTextStyle16(fontWeight: FontWeight.w600),
              ),
              const TextWidget('28/2/2023'),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                'عديتك مع تطبيق العقارات',
                style: getTextStyleNormal(color: AppColors.textColor11),
              ),
              Container(
                height: 27.h,
                width: 27.h,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: TextWidget(
                  '1',
                  style: getTextStyle18(color: AppColors.white),
                ),
              )
            ],
          ),
        ),
        const Divider(color: AppColors.grey)
      ],
    );
  }

  TextInputWidget _searchbar() {
    return const TextInputWidget(
      '',
      hintText: 'ابحث عن رساىْل العملاء',
      prefixIcon: Icons.search,
      prefixColor: AppColors.orange,
    );
  }
}
