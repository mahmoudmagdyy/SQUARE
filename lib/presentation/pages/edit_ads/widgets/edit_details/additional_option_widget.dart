import 'dart:developer';

import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';

class AdditionalOptionWidget extends StatefulWidget {
  const AdditionalOptionWidget({super.key});

  @override
  State<AdditionalOptionWidget> createState() => _AdditionalOptionWidgetState();
}

class _AdditionalOptionWidgetState extends State<AdditionalOptionWidget> {
  List<bool> isExist = [];
  Set<int> selectedToolIds = {};
  late Map<int, Tool> toolMap;
  void handleTap(int toolId) {
    if (selectedToolIds.contains(toolId)) {
      selectedToolIds.remove(toolId);
    } else {
      if (selectedToolIds.length < 4) {
        selectedToolIds.add(toolId);
      } else {
        showSnackBar(
          message: 'يجب عليك اختيار 4 اختيارات فقط',
          isError: true,
        );
      }
    }
    log(selectedToolIds.toList().toString());

    setState(() {});
  }

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UploadAqarBloc bloc = context.read<UploadAqarBloc>();

    return BlocBuilder<EditMyAdCubit, EditMyAdState>(
      builder: (context, state) {
        return Padding(
          padding: gPadding(top: 15, bottom: 5),
          child: Wrap(
            spacing: 15.w,
            runSpacing: 10.h,
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(
              bloc.state.extraOptions.length,
              (index) {
                return BoxWidget(
                  title: bloc.state.extraOptions[index].title.toString(),
                  backgroundColor: selectedToolIds
                          .contains(bloc.state.extraOptions[index].id)
                      ? AppColors.primary
                      : null,
                  titleColor: selectedToolIds
                          .contains(bloc.state.extraOptions[index].id)
                      ? AppColors.white
                      : null,
                  callback: () {
                    handleTap(bloc.state.extraOptions[index].id!);
                    state.property!.property.tools = selectedToolIds
                        .map((e) => Tool(id: e, title: '$e title'))
                        .toList();
                    log(state.property!.property.tools.toString());
                    // if (state.property!.property.tools!.contains(
                    //   Tool(
                    //     id: bloc.state.extraOptions[index].id!,
                    //     title: bloc.state.extraOptions[index].title!,
                    //   ),
                    // )) {
                    //   state.property!.property.tools!.remove(
                    //     Tool(
                    //       id: bloc.state.extraOptions[index].id!,
                    //       title: bloc.state.extraOptions[index].title!,
                    //     ),
                    //   );
                    // } else {
                    //   state.property!.property.tools!.add(
                    //     Tool(
                    //       id: bloc.state.extraOptions[index].id!,
                    //       title: bloc.state.extraOptions[index].title!,
                    //     ),
                    //   );
                    // }
                    // setState(() {});
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
