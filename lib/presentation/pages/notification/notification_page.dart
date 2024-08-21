import 'dart:developer';

import 'package:aqarat/presentation/bloc/notification/notification_cubit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/index.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  initState() {
    sl<NotificationCubit>().getAllNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "الاشعارات"),
      body: SafeArea(
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            switch (state.getAllNotificationRequestState) {
              case RequestState.none:
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.loaded:
                return state.allNotification?.data?.isEmpty ?? true
                    ? Center(
                        child: TextWidget(
                          "لا يوجد اشعارات",
                          style: getTextStyleLarge(
                            color: AppColors.black,
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          sl<NotificationCubit>().getAllNotification();
                        },
                        child: ListView.separated(
                          padding: gPaddingSymmetric(horizontal: 15),
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.allNotification?.data?.length ?? 0,
                          itemBuilder: (context, index) => Slidable(
                            key: UniqueKey(),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onPressed: (context) {
                                    context
                                        .read<NotificationCubit>()
                                        .removeNotification(
                                          state.allNotification!.data![index]
                                              .id!,
                                        );
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: state.allNotification!.data![index]
                                            .status ==
                                        0
                                    ? Colors.red.withOpacity(.1)
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      log('ID ${state.allNotification!.data![index].id}');
                                      if (state.allNotification!.data![index]
                                              .status ==
                                          0) {
                                        context
                                            .read<NotificationCubit>()
                                            .updateNotificationStatus(
                                              state.allNotification!
                                                  .data![index].id!,
                                              index,
                                            );
                                      }
                                    },
                                    contentPadding: gPaddingSymmetric(),
                                    dense: true,
                                    leading: Icon(
                                      Icons.notifications,
                                      color: AppColors.textGray22,
                                      size: 24.w,
                                    ),
                                    title: TextWidget(
                                      state
                                          .allNotification!.data![index].title!,
                                      style: getTextStyle16(
                                          color: AppColors.textGray22),
                                    ),
                                    subtitle: TextWidget(
                                      state.allNotification!.data![index].body!,
                                      style: getTextStyle16(
                                          color: AppColors.textGray22),
                                    ),
                                    trailing: TextWidget(
                                      state.allNotification!.data![index]
                                          .createdAt!,
                                      style: getTextStyle16(
                                          color: AppColors.textGray22),
                                    ),
                                  ),
                                  const Divider(color: AppColors.grey)
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return 8.verticalSpace;
                          },
                        ),
                      );
              case RequestState.error:
                return const Center(
                  child: TextWidget(
                    "Error",
                  ),
                );
            }
          },
        ),
        // child: SingleChildScrollView(
        //   child: Padding(
        //     padding: gPaddingSymmetric(horizontal: 15),
        //     child: Column(
        //       children: [
        //         20.height,
        //         _buildBodyContent(),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Column _buildBodyContent() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) => Column(
            children: [
              ListTile(
                contentPadding: gPaddingSymmetric(),
                dense: true,
                leading: SvgPicture.asset(
                  AppImages.done,
                  height: 36.h,
                  width: 36.h,
                ),
                title: TextWidget(
                  "عزيزي تم قبول اعلانك شقة للايجار في الرياض اضغط لعرض الاعلان",
                  style: getTextStyle16(color: AppColors.textGray22),
                ),
              ),
              const Divider(color: AppColors.grey)
            ],
          ),
        ),
      ],
    );
  }
}
