import 'dart:io';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';

class MainImageWidget extends StatefulWidget {
  const MainImageWidget({super.key});

  @override
  State<MainImageWidget> createState() => _MainImageWidgetState();
}

class _MainImageWidgetState extends State<MainImageWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyAdCubit, EditMyAdState>(
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        return DottedBorder(
          borderType: BorderType.Rect,
          color: AppColors.primary,
          dashPattern: const [10, 8],
          radius: const Radius.circular(100).r,
          padding: gPaddingSymmetric(horizontal: 15, vertical: 15),
          child: state.property?.firstImage != null
              ? SizedBox(
                  height: 120.h,
                  // width: 80.w,
                  child: Stack(
                    children: [
                      if (state.property!.firstImage!.contains('https://') ||
                          state.property!.firstImage!.contains('http://') ||
                          state.property!.firstImage!.contains('visooft.com'))
                        Image.network(
                          state.property!.firstImage.toString(),
                          alignment: AlignmentDirectional.center,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      if (state.property!.firstImage!.contains('cache'))
                        Image.file(
                          File(
                            state.property!.firstImage.toString(),
                          ),
                          alignment: AlignmentDirectional.center,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                context
                                    .read<EditMyAdCubit>()
                                    .deleteFirstImage();
                              },
                            );
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.red.shade100,
                            child: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text(
                    'لا يوجد صور لعرضها ',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
