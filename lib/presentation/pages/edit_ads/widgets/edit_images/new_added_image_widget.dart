// import 'dart:io';

// import 'package:aqarat/index.dart';
// import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';

// class NewAddedImageWidget extends StatelessWidget {
//   const NewAddedImageWidget({
//     super.key,
//     required this.image,
//     required this.index,
//   });
//   final File image;
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80.h,
//       width: 80.w,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadiusDirectional.only(
//           topStart: Radius.circular(16.r),
//           bottomEnd: Radius.circular(16.r),
//         ),
//         border: Border.all(
//           color: AppColors.baseColor,
//         ),
//       ),
//       child: Stack(
//         fit: StackFit.expand,
//         clipBehavior: Clip.none,
//         children: [
//           Image.file(
//             image,
//             fit: BoxFit.fill,
//           ),
//           PositionedDirectional(
//             end: -24.0.w,
//             top: -24.h,
//             child: IconButton(
//               onPressed: () {
//                 context.read<EditMyAdCubit>().deletePickedImage(index);
//               },
//               icon: CircleAvatar(
//                 radius: 12.r,
//                 backgroundColor: Colors.red.shade100,
//                 child: Icon(
//                   Icons.clear,
//                   color: Colors.red,
//                   size: 16.sp,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
