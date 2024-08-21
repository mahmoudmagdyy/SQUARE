import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';
import 'package:aqarat/presentation/bloc/my_ads/my_ads_cubit.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_details/ad_properties_widget.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_details/additional_option_widget.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_details/price_widget.dart';
import 'package:get/get.dart';


import '../../../../../data/data_source/remote/my_ads/my_ads_remote_data_source.dart';
import '../../../../../data/model/property.dart';

class EditAqarDetailsScreen extends StatefulWidget {
  const EditAqarDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EditAqarDetailsScreen> createState() => _EditAqarDetailsScreenState();
}

class _EditAqarDetailsScreenState extends State<EditAqarDetailsScreen> {
  //   EditMyAdCubit editAdsCubit =
  @override
  void initState() {
    context.read<EditMyAdCubit>().assignDataToControllers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UploadAqarBloc bloc = context.read<UploadAqarBloc>();
    EditMyAdCubit editAdsCubit = context.read<EditMyAdCubit>();

    return BlocBuilder<EditMyAdCubit, EditMyAdState>(
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        // var item = state.property;
        // _detailsController.text = item?.description ?? "";
        // _addressController.text = item?.city ?? '${item?.area}' ?? '';
        return Scaffold(
          appBar: const AppBarWidget(title: 'تفاصيل الاعلان'),
          body: Container(
            padding: gPadding(right: 15, left: 15, bottom: 15),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    25.height,
                    Center(
                      child: TextWidget(
                        AppStrings.detailAqar,
                        style: getTextStyle20(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    25.height,
                    const PriceWidget(),
                    TextInputWidget(
                      '',
                      hintText: "من فضلك ادخل السعر",
                      textInputAction: TextInputAction.done,
                      controller: context.read<EditMyAdCubit>().priceController,
                      keyboardType: TextInputType.number,
                      fillColor: AppColors.white,
                      onChanged: (value) {
                        editAdsCubit.updatePrice(value!);
                      },
                    ),
                    // 16.verticalSpace,
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       // value: state.property.,
                    //       value: true,
                    //       onChanged: (value) {},
                    //     ),
                    //     TextWidget(
                    //       "السعر قابل للتفاوض",
                    //       style: getTextStyle16(
                    //           decoration: TextDecoration.underline,
                    //           color: AppColors.greyDark2.withOpacity(.30)),
                    //     ),
                    //   ],
                    // ),
                    30.height,
                    const AdPropertiesWidget(),
                    25.height,
                    TextWidget(
                      'عمر العقار',
                      style: getTextStyleNormal(
                          color: AppColors.black, fontWeight: FontWeight.w500),
                    ),
                    10.height,
                    ExpandableWidget(
                      title: state.property?.age == null
                          ? "عمر العقار"
                          : '${state.property!.age} عام',
                      color:
                          state.property?.age == null ? null : AppColors.black,
                      array: age,
                      onSelectedValue: (value) {
                        state.property!.age = int.parse(age[value].name);
                        setState(() {});
                        log(state.property!.age.toString());
                        log(value.toString());
                      },
                    ),
                    25.height,
                    TextInputWidget(
                      'مساحه العقار',
                      keyboardType: TextInputType.number,
                      textStyle:
                          getTextStyleNormal(fontWeight: FontWeight.w500),
                      hintStyle: getTextStyleSmall(color: AppColors.textHent),
                      fillColor: AppColors.white,
                      controller:
                          context.read<EditMyAdCubit>().aqarAreaController,
                    ),
                    25.height,
                    TextWidget(
                      'طريقة الدفع',
                      style: getTextStyleNormal(
                          color: AppColors.black, fontWeight: FontWeight.w500),
                    ),
                    10.height,
                    ExpandableWidget(
                      title: state.property?.payment?.isEmpty == null
                          ? 'طريقة الدفع'
                          : state.property!.payment.toString(),
                      color: state.property?.payment?.isEmpty == null
                          ? null
                          : AppColors.black,
                      array: payment,
                      onSelectedValue: (value) {
                        var newValue = payment[value];
                        context
                            .read<EditMyAdCubit>()
                            .changePaymentMethod(newValue.name);
                      },
                    ),
                    // TextWidget(
                    //   'هل تقبل الدفع بالتمويل العقاري',
                    //   style: getTextStyleNormal(
                    //     color: AppColors.black.withOpacity(.40),
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    25.height,
                    TextInputWidget(
                      "عنوان الإعلان",
                      controller:
                          context.read<EditMyAdCubit>().addressController,
                      textStyle:
                          getTextStyleNormal(fontWeight: FontWeight.w500),
                      hintStyle: getTextStyleSmall(color: AppColors.textHent),
                      fillColor: AppColors.white,
                    ),

                    25.height,
                    TextInputWidget(
                      'التفاصيل',
                      controller:
                          context.read<EditMyAdCubit>().detailsController,
                      textStyle:
                          getTextStyleNormal(fontWeight: FontWeight.w500),
                      hintStyle: getTextStyleSmall(color: AppColors.textHent),
                      maxLines: 6,
                      fillColor: AppColors.white,
                    ),
                    25.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          'خيارات اضافية',
                          style: getTextStyleNormal(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SvgPicture.asset(
                          AppImages.arrowdown,
                          height: 8.5.h,
                          width: 15.w,
                        ),
                      ],
                    ),
                    const AdditionalOptionWidget(),
                    TextWidget(
                      "*ليس هناك ما يمنع من التصرف أو الانتفاع من العقار",
                      style: getTextStyleNormal(
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withOpacity(.39),
                      ),
                    ),
                    26.height
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BlocConsumer<MyAdsCubit, MyAdsState>(
            listener: (context, state) {
              if (state.editAdsRequestState == RequestState.loaded) {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.all(16.sp),
                        width: .8.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            16.verticalSpace,
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              radius: 36.r,
                              child: Icon(
                                Icons.check,
                                size: 36.sp,
                                color: Colors.white,
                              ),
                            ),
                            24.verticalSpace,
                            TextWidget(
                              "تم تحديث الاعلان بنجاح",
                              style: getTextStyle16(
                                fontWeight: FontWeight.w800,
                                color: AppColors.black,
                              ),
                            ),
                            16.verticalSpace,
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state.editAdsRequestState == RequestState.error) {
                showSnackBar(
                  message: state.editAdsErrorMessage!,
                  isError: true,
                );
              }
            },
            builder: (context, outerState) {
              return BlocBuilder<EditMyAdCubit, EditMyAdState>(
                builder: (context, state) {
                  return BtnWidget(
                    title: 'تعديل الاعلان',
                    onTap: () async{
                     //await showSnackBar(message: 'Coming Soon');
                     // List<int>?aaaaa=[];
                     // for(int i=0;i<=EditMyAdCubit.deletedImage.length;i++){
                     //   aaaaa.add(EditMyAdCubit.deletedImage![i]);
                     // }
                     // print("aaaaa");
                     // print(aaaaa);
                     print("aaaaaaaaaaaaaaaaaa${EditMyAdCubit.deletedImage}");
                      final List<Map<String, dynamic>> questionss=[];

                      for(int i = 0; i <state.property!.property.questions!.length; i++){
                        late  Map<String, dynamic> questionMap={};
                        questionMap = {
                          for (var ques in state.property!.property.questions!)
                            "id": state.property!.property.questions![i].id,
                          for (var a in state.property!.property.questions!)
                            "value": state.property!.property.questions![i].value,
                        };

                        questionss.add(questionMap);

                      }


                      //tools
                      List<String> toolss = [];
                      List<bool> isExist = [];
                      Set<int> selectedToolIds = {};
                      late Map<int, Tool> toolMap;
                      for(int i = 0; i <state.property!.property.tools!.length; i++){
                        toolss.add(state.property!.property.tools![i].id.toString());
                      }
                      toolMap = {
                        for (var tool
                        in context.read<EditMyAdCubit>().state.property!.property.tools!)
                          tool.id: tool
                      };
                      for (var question in context.read<UploadAqarBloc>().state.extraOptions) {
                        if (toolMap.containsKey(question.id)) {
                          selectedToolIds.add(question.id!);
                          isExist.add(true);
                        } else {
                          isExist.add(false);
                        }
                      }
                      //list images file
                      List<File> imagesfiles=[];
                      for(int i = 0; i <state.property!.images.length; i++){
                       imagesfiles.add(  File(
                         state.property!.images[i].image.toString(),
                       ),);
                      }

                     // images file
                     List<File> mainImage=[];


print(context.read<EditMyAdCubit>().state.property!.property.questions);
                      var space=int.parse(context.read<EditMyAdCubit>().aqarAreaController.text);
                      print(space);
                      var cat_id=state.categoryId;
                      print(cat_id);
                      print(state.aqarCityID);
                      var m=state.property!.area;
                      print(m);

                      var areaId =state.districts[state.aqarCityID!].id;
                       print(state.districts[state.aqarCityID!].id);
                       print(EditMyAdCubit.deletedImage);

                      await MyAdsRemoteDataSource().editMyAds(
                        id: state.property!.id,

                        params: UploadParameter(
                          deletImages: EditMyAdCubit.deletedImage,
                          cat_id:cat_id,
                          space: space,
                          areaId:areaId.toString(),
                          firstImage:File(state.property!.firstImage.toString()),
                          // firstImage: File(context.read<EditMyAdCubit>().currentProperty.firstImage.toString()),
                          typeStatus: state.property!.typeStatus,
                          price: state.property!.price.toString(),
                          title:context.read<EditMyAdCubit>().titleController.text,
                          description: context.read<EditMyAdCubit>().detailsController.text,
                          payment:state.property!.payment,
                          age: state.property!.age.toString(),
                          cityId: state.aqarCityID.toString(),
                          adIdType: state.aqarIdType.toString(),
                          images:imagesfiles,
                          aqarIdType: bloc.state.aqarIdType,
                          lat: state.currentLocation!.latitude.toString(),
                          lng: state.currentLocation!.longitude.toString(),
                          tools: toolss,

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                         questions: questionss,





                        ),
                      );
                      // bloc.add(UploadNewAqarEvent());
                      await showSnackBar(message: 'تم تعديل الاعلان بنجاح');
                     EditMyAdCubit.deletedImage=[];
                       Get.offAll(HomePage());
                      ////////////////////////////////////////

                      // MyAdsRemoteDataSource().editMyAds(id: 10, params: UploadParameter(
                      //     typeStatus:context.read().typeStatus ,
                      //   description:context.read(). description,
                      //   price:context.read().priceController,
                      //   payment:context.read().paymentController ,
                      //   title:context.read().titlecontroller ,
                      //   age:  context.read().agecontroller,
                      //   images:   context.read().imagescontroller,
                      //   lat:  context.read().latcontroller,
                      //   lng:  context.read().lngcontroller,
                      //   questions:  context.read().questionscontroller,
                      //   space:  context.read().spacecontroller,
                      //   tools:  context.read().toolscrollerscontroller,
                      //   adIdType:   context.read().adIdTypecontrolle,
                      //   aqarIdType:   context.read().aqarIdTypecontrolle,
                      //   areaId:   context.read().areaIdcontrolle,
                      //   cityId:   context.read().cityIdcontrolle,
                      //   firstImage:   context.read().firstImagecontrol,
                      //
                      //
                      //
                      //
                      // )

                      // );

                      // ( bloc.state.price.isEmpty || bloc.state.values.length != bloc.state.questions.length ||
                      //         bloc.state.age.isEmpty ||
                      //         bloc.state.title.isEmpty ||
                      //         bloc.state.description.isEmpty ||
                      //         bloc.state.extraOptions.isEmpty)
                      //     ? showSnackBar(
                      //         message: "برجاء استكمال البيانات المطلوبة", isError: true)
                      //     :
                      // bloc.add(UploadNewAqarEvent());

                      // if (state.property!.property.tools!.isEmpty) {
                      //   showSnackBar(
                      //     message: 'يجب عليك تحديد خيارات اضافية',
                      //     isError: true,
                      //   );
                      // }
                      // List<File> images = [];
                      // List<Map<String, dynamic>> questions = [];

                      // for (var image in state.property!.images) {
                      //   if (image.isFileImage == true) {
                      //     images.add(File(image.image));
                      //   }
                      // }

                      // for (var question
                      //     in state.property!.property.questions!) {
                      //   questions.add(
                      //     {
                      //       "id": question.id,
                      //       "value": question.value,
                      //     },
                      //   );
                      // }

                      // context.read<MyAdsCubit>().editMyAd(
                      //       state.property!.id,
                      //       UploadParameter(
                      //         typeStatus: state.aqarIdType.toString(),
                      //         payment: state.property!.payment,
                      //         cityId: state.aqarCityID.toString(),
                      //         adIdType: state.aqarIdType.toString(),
                      //         // areaId: state,
                      //         space: int.parse(context
                      //             .read<EditMyAdCubit>()
                      //             .aqarAreaController
                      //             .text),
                      //         lat: state.property!.lat,
                      //         lng: state.property!.lng,
                      //         images: images,
                      //         price: context
                      //             .read<EditMyAdCubit>()
                      //             .priceController
                      //             .text
                      //             .replaceAll(',', ''),
                      //         questions: questions,
                      //         age: state.property!.age.toString(),
                      //         title: state.property!.title,
                      //         description:
                      //             state.property!.description.toString(),
                      //         tools: state.property!.property.tools!
                      //             .map((e) => e.id.toString())
                      //             .toList(),
                      //       ),
                      //     );
                      // var params = UploadParameter(
                      //   typeStatus: 'يومي',
                      //   payment: 'كاش',
                      //   space: 0,
                      //   // aqarIdType: item.type,
                      //   // cityId: item.city,
                      //   // areaId: item.area,
                      //   lat: item.lat,
                      //   lng: item.lng,
                      //   // firstImage: File('item.firstImage'),
                      //   images: editAdsCubit.state.pickedImage,
                      //   price: item.price,
                      //   questions: item.property.questions!
                      //       .map((e) => {
                      //             "id": e.id,
                      //             "value": e.value,
                      //             "title": e.title,
                      //           })
                      //       .toList(),
                      //   age: item.age.toString(),
                      //   title: item.title,
                      //   description: item.description,
                      //   tools: item.property.tools!.map((e) => e.title).toList(),
                      // );
                      // context.read<MyAdsCubit>().editMyAd(item.id, params);
                    },
                    // onTap: () => (),
                    margin: gPadding(left: 15, right: 15, bottom: 15),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
