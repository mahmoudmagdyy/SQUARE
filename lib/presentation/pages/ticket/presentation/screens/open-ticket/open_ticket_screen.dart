import 'package:aqarat/core/services/services_locator.dart';
import 'package:aqarat/presentation/widgets/app_text/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/params/ticket_params.dart';
import '../../../../../../core/services/navigation_service.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/custom_progress_widget.dart';
import '../../../../../../core/widgets/show_error_under_tff_widget.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../widgets/snack_bar_widget.dart';
import '../../../logic/ticket_cubit.dart';

class OpenTicketScreen extends StatefulWidget {
  const OpenTicketScreen({Key? key, this.tableId, this.isQuestion})
      : super(key: key);
  final int? tableId;
  final bool? isQuestion;
  @override
  State<OpenTicketScreen> createState() => _OpenTicketScreenState();
}

class _OpenTicketScreenState extends State<OpenTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _clearAllController() {
    _titleController.clear();
    _descriptionController.clear();
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketCubit, TicketState>(
      listener: (BuildContext context, TicketState state) {
        if (state.createTicketRequestState == RequestState.loaded) {
          _clearAllController();
          i<NavigationService>().pop();

          showSnackBar(
            message: 'تم ارسال التذكرة بنجاح',
          );
        } else if (state.createTicketRequestState == RequestState.error) {
          showSnackBar(
            message: state.createTicketErrorMessage!.message.toString(),
          );
        }
      },
      builder: (context, state) {
        return CustomProgressWidget(
          condition: state.createTicketRequestState == RequestState.loading,
          loadedWidget: Scaffold(
            appBar: AppBar(
              title: const Text('فتح تذكرة', style: TextStyle(fontSize: 18)),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(8.sp),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<TicketCubit>().createNewTicket(
                          TicketParams(
                            title: _titleController.text.trim(),
                            name: _nameController.text.trim(),
                            phone: _phoneController.text.trim(),
                            problem: _descriptionController.text.trim(),
                            email: _emailController.text.trim(),
                            tableId: widget.tableId,
                            isQuestion: widget.isQuestion,
                          ),
                        );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  'ارسال',
                  style: getTextStyle16(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Column(
                  children: [
                    16.verticalSpace,
                    TextFormFieldWithTitleWidget(
                      errorWidget: state.createTicketRequestState ==
                                  RequestState.error &&
                              state.createTicketErrorMessage!.data != null &&
                              state.createTicketErrorMessage!.data!
                                  .containsKey('title')
                          ? ShowErrorUnderTFFWidget(
                              title: (state.createTicketErrorMessage!
                                      .data!['title'] as List)
                                  .map((e) => e.toString())
                                  .join(', '),
                              condition: true,
                            )
                          : const SizedBox.shrink(),
                      controller: _titleController,
                      title: 'عنوان البلاغ',
                      hint: 'عنوان البلاغ',
                      filled: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يجب ادخال العنوان';
                        }
                        return null;
                      },
                      fillColor: AppColors.greyLight,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                    ),
                    24.verticalSpace,
                    TextFormFieldWithTitleWidget(
                      controller: _nameController,
                      errorWidget: state.createTicketRequestState ==
                                  RequestState.error &&
                              state.createTicketErrorMessage!.data != null &&
                              state.createTicketErrorMessage!.data!
                                  .containsKey('name')
                          ? ShowErrorUnderTFFWidget(
                              title: (state.createTicketErrorMessage!
                                      .data!['name'] as List)
                                  .map((e) => e.toString())
                                  .join(', '),
                              condition: true,
                            )
                          : const SizedBox.shrink(),
                      title: 'الاسم',
                      hint: 'الاسم',
                      filled: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يجب ادخال الاسم';
                        }
                        return null;
                      },
                      fillColor: AppColors.greyLight,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                    ),
                    24.verticalSpace,
                    TextFormFieldWithTitleWidget(
                      errorWidget: state.createTicketRequestState ==
                                  RequestState.error &&
                              state.createTicketErrorMessage!.data != null &&
                              state.createTicketErrorMessage!.data!
                                  .containsKey('phone')
                          ? ShowErrorUnderTFFWidget(
                              title: (state.createTicketErrorMessage!
                                      .data!['phone'] as List)
                                  .map((e) => e.toString())
                                  .join(', '),
                              condition: true,
                            )
                          : const SizedBox.shrink(),
                      controller: _phoneController,
                      title: 'الجوال',
                      hint: 'الجوال',
                      filled: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يجب ادخال رقم الجوال';
                        }
                        return null;
                      },
                      fillColor: AppColors.greyLight,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                    ),
                    24.verticalSpace,
                    TextFormFieldWithTitleWidget(
                      controller: _descriptionController,
                      errorWidget: state.createTicketRequestState ==
                                  RequestState.error &&
                              state.createTicketErrorMessage!.data != null &&
                              state.createTicketErrorMessage!.data!
                                  .containsKey('problem')
                          ? ShowErrorUnderTFFWidget(
                              title: (state.createTicketErrorMessage!
                                      .data!['problem'] as List)
                                  .map((e) => e.toString())
                                  .join(', '),
                              condition: true,
                            )
                          : const SizedBox.shrink(),
                      maxLines: 6,
                      title: ' ما هي مشكلتك ؟؟',
                      hint: ' ما هي مشكلتك ؟؟',
                      filled: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يجب ادخال الوصف';
                        }
                        return null;
                      },
                      fillColor: AppColors.greyLight,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
