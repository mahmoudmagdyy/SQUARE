import '/index.dart';

class DefineInterestsFindMePage extends StatelessWidget {
  const DefineInterestsFindMePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'الرائد',
      'الرحاب',
      'الرسالة',
      'الرمال',
      'الرائد',
      'الرحاب',
      'الرسالة',
      'الرمال',
    ];
    return Scaffold(
      appBar: const AppBarWidget(title: 'تحديد اهتمامات ابحث لي'),
      body: SingleChildScrollView(
        child: Container(
          padding: gPaddingSymmetric(horizontal: 5),
          alignment: Alignment.center,
          child: Column(
            children: [
              _buildSearchBarContent(),
              19.height,
              TextWidget(
                "اختر المدينة التي ترغب في العمل بها في ابحث لي",
                style: getTextStyle16(),
              ),
              ...List.generate(
                titles.length,
                (index) => MyCheckboxListTile(titles[index]),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BtnWidget(
        title: AppStrings.done,
        onTap: () => i<NavigationService>().toNamed(Routes.selectAqarType),
        margin: gPadding(left: 15, right: 15, bottom: 15),
      ),
    );
  }

  Padding _buildSearchBarContent() {
    return Padding(
      padding: gPadding(right: 15, left: 15),
      child: const TextInputWidget(
        '',
        hintText: 'البحث',
        prefixIcon: Icons.search,
        prefixColor: AppColors.textColor,
      ),
    );
  }
}
