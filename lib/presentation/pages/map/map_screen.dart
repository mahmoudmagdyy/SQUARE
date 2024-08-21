import 'package:aqarat/presentation/pages/map/widget/maps/google%20maps_widget.dart';
import 'package:flutter/cupertino.dart';

import '/index.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapSampleState();
}

class MapSampleState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BtmNavBarAllAqaratMap(),
      appBar: _buildHeaderContent(),
      body: Padding(
        padding: gPadding(top: 15),
        child: const GoogleMapWidget(),
      ),
    );
  }

  AppBar _buildHeaderContent() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => i<NavigationService>().toNamed(Routes.notification),
            child: Container(
              padding: gPaddingSymmetric(horizontal: 12.5, vertical: 12.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary),
              ),
              child: Icon(
                CupertinoIcons.bell,
                size: 15.h,
                color: AppColors.greyDark,
              ),
            ),
          ),
          TextWidget(
            "خريطة الإعلانات",
            style: getTextStyle16(
                color: AppColors.black, fontWeight: FontWeight.w600),
          ),
          GestureDetector(
            onTap: () => i<NavigationService>().toNamed(Routes.settings),
            child: CircleAvatar(
              radius: 22.5.r,
              backgroundColor: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
