import 'package:aqarat/core/utils/enums.dart';
import 'package:aqarat/presentation/pages/ticket/logic/ticket_cubit.dart';
import 'package:aqarat/presentation/widgets/app_text/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/routes/routes.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_error_widget.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../widgets/snack_bar_widget.dart';
import '../../widgets/support/support_item_widget.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  void initState() {
    BlocProvider.of<TicketCubit>(context).getAllTicket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم الفني'),
      ),
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          switch (state.getAllTicketRequestState) {
            case RequestState.none:
            case RequestState.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case RequestState.loaded:
              if (state.allTickets?.data?.isEmpty ?? true) {
                return Center(
                  child: Text(
                    'لا يوجد تذاكر',
                    style: getTextStyle16(
                      color: AppColors.primary,
                    ),
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<TicketCubit>().getAllTicket();
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    itemBuilder: (context, index) {
                      return SupportItemWidget(
                        title: state.allTickets?.data?[index].title ?? '',
                        description:
                            state.allTickets!.data![index].problem.toString(),
                        bgColor: getColor(
                          state.allTickets?.data?[index].status ?? 0,
                        ),
                        date: state.allTickets?.data?[index].createdAt ?? '',
                        status: getStatus(
                          state.allTickets?.data?[index].status ?? 0,
                        ),
                        onTap: () {
                          if (state.allTickets?.data?[index].status == 1 ||
                              state.allTickets?.data?[index].status == 2) {
                            navigator!.pushNamed(
                              Routes.supportDetailsRoute,
                              arguments: state.allTickets!.data![index],
                            );
                          } else {
                            showSnackBar(
                              message: 'مازلت تحت المراجعه',
                            );
                          }
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return 8.verticalSpace;
                    },
                    itemCount: state.allTickets?.data?.length ?? 0,
                  ),
                );
              }
            case RequestState.error:
              return AppErrorWidget(
                message: state.allTicketsErrorMessage.toString(),
                onTap: () {
                  context.read<TicketCubit>().getAllTicket();
                },
              );
          }
        },
      ),
    );
  }
}
