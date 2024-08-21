import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';

class AdPropertiesWidget extends StatefulWidget {
  const AdPropertiesWidget({super.key});

  @override
  State<AdPropertiesWidget> createState() => _AdPropertiesWidgetState();
}

class _AdPropertiesWidgetState extends State<AdPropertiesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyAdCubit, EditMyAdState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.property!.property.questions!.length,
          itemBuilder: (context, index) {
            String value =
                state.property!.property.questions![index].value.toString();

            // var currentValue =
            //     item.property.questions![index].value.toString();
            late int existingIndex;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  state.property!.property.questions![index].title,
                  style: getTextStyle16(),
                ),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    7,
                    (innerIndex) {
                      return GestureDetector(
                        onTap: () {
                          var newValue = state
                              .property!
                              .property
                              .questions![index]
                              .value = (innerIndex + 1).toString();
                          if (newValue == '7') {
                            newValue = '7+';
                            value = newValue.toString();
                          } else {
                            value = newValue.toString();
                          }
                          log(newValue.toString());
                          log(value.toString());

                          setState(() {});
                        },
                        child: Container(
                          height: 38.h,
                          width: 38.h,
                          margin: gPadding(right: 5.0, bottom: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: state.property!.property.questions![index]
                                            .value ==
                                        '7+' &&
                                    innerIndex == 6
                                ? AppColors.primary
                                : value == (innerIndex + 1).toString()
                                    ? AppColors.primary
                                    : AppColors.greyLight,
                            borderRadius: 8.radius,
                          ),
                          child: TextWidget(
                            innerIndex == 6
                                ? '+ ${innerIndex + 1}'
                                : '${innerIndex + 1}',
                            style: getTextStyle16(
                              fontWeight: FontWeight.w600,
                              color: value == (innerIndex + 1).toString() ||
                                      (state.property!.property
                                                  .questions![index].value ==
                                              '7+' &&
                                          innerIndex == 6)
                                  ? AppColors.white
                                  : AppColors.textColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // children: List.generate(
                  //   item.property.questions!.length,
                  //   (i) {
                  //     (() {
                  //       [];
                  //       existingIndex =
                  //           item.property.questions!.indexWhere(
                  //         (element) =>
                  //             item.property.questions![index].id
                  //                 .toString() ==
                  //             element.id,
                  //       );
                  //       // log("Existing Index ======> ");
                  //       // log("value ======> ");
                  //     }());
                  //     return GestureDetector(
                  //       // onTap: () => bloc.add(
                  //       //   GetValueAqarEvent(value: {
                  //       //     "id": bloc.state.questions[index].id
                  //       //         .toString(),
                  //       //     "value": bloc
                  //       //         .state.questions[index].values[i],
                  //       //   }),
                  //       // ),
                  //       child: Container(
                  //         height: 38.h,
                  //         width: 38.h,
                  //         margin: gPadding(right: 5.0, bottom: 15),
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           color: value.isEmpty
                  //               ? AppColors.greyLight
                  //               : item.property.questions![index]
                  //                           .value ==
                  //                       value
                  //                   ? AppColors.primary
                  //                   : AppColors.greyLight,
                  //           borderRadius: 8.radius,
                  //         ),
                  //         child: TextWidget(
                  //           item.property.questions![index].value
                  //               .toString(),
                  //           style: getTextStyle16(
                  //             fontWeight: FontWeight.w600,
                  //             color: value.isEmpty
                  //                 ? AppColors.textColor
                  //                 : item.property.questions![index]
                  //                             .value ==
                  //                         value
                  //                     ? AppColors.white
                  //                     : AppColors.textColor,
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
