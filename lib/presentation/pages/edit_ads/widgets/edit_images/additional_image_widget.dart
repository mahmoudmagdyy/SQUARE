import 'dart:io';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';

class AdditionalImageWidget extends StatefulWidget {
  const AdditionalImageWidget({
    super.key,
  });

  @override
  State<AdditionalImageWidget> createState() => _AdditionalImageWidgetState();
}

class _AdditionalImageWidgetState extends State<AdditionalImageWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyAdCubit, EditMyAdState>(
      builder: (context, state) {
        return state.property?.images.isEmpty ?? true
            ? Center(
                child: TextWidget(
                  "لا يوجد صور لعرضها ",
                  style: getTextStyle20(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : Wrap(
                spacing: 8.w,
                runSpacing: 24.h,
                children: List.generate(
                  state.property?.images.length ?? 0,
                  (index) => Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child:
                            state.property!.images[index].isFileImage == true ||
                                    state.property!.images[index].isFileImage !=
                                        null
                                ? Image.file(
                                    File(
                                      state.property!.images[index].image,
                                    ),
                                    height: 1.sw / 3.5,
                                    width: 1.sw / 3.5,
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    state.property!.images[index].image,
                                    height: 1.sw / 3.5,
                                    width: 1.sw / 3.5,
                                    fit: BoxFit.fill,
                                  ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(
                            () {
                              context
                                  .read<EditMyAdCubit>()
                                  .deleteNewAdditionalPickedImage(index);


                            },
                          );
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
