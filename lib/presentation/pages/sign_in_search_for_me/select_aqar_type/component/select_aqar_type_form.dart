import 'package:aqarat/core/utils/app_colors.dart';
import 'package:aqarat/core/utils/extension.dart';
import 'package:aqarat/domain/entities/upload/city_entity.dart';
import 'package:aqarat/presentation/widgets/app_text/text_styles.dart';
import 'package:aqarat/presentation/widgets/app_text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '/index.dart';
import '../../../../bloc/search_for_me_bloc/search_for_me_bloc.dart';
import '../../../../bloc/search_for_me_cubit/search_for_me_cubit.dart';

class SelectAqarTypeForm extends StatefulWidget {
  const SelectAqarTypeForm({super.key, required this.bloc});
  final SearchForMeBloc bloc;

  @override
  State<SelectAqarTypeForm> createState() => _SelectAqarTypeFormState();
}

class _SelectAqarTypeFormState extends State<SelectAqarTypeForm> {
  late int selectedIdx;
  @override
  void initState() {
    selectedIdx = -1;
    super.initState();
  }

  void setSelectedIndex(int index) {
    setState(() {
      selectedIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.bloc.uploadBloc.state.types.toString());
    return Column(
      children: [
        ...List.generate(
          widget.bloc.uploadBloc.state.types.length,
          (index) => _ChoseAqarTypeListTile(
            name: widget.bloc.uploadBloc.state.types[index].name!,
            bloc: widget.bloc,
            onTap: () => setSelectedIndex(index),
            isSelected: selectedIdx == index,
            areaEntity: widget.bloc.uploadBloc.state.types[index],
          ),
        )
      ],
    );
  }
}

class _ChoseAqarTypeListTile extends StatefulWidget {
  const _ChoseAqarTypeListTile({
    required this.name,
    required this.bloc,
    required this.onTap,
    required this.isSelected,
    required this.areaEntity,
  });
  final String name;
  final SearchForMeBloc bloc;
  final VoidCallback onTap;
  final bool isSelected;
  final AreaEntity areaEntity;

  @override
  State<_ChoseAqarTypeListTile> createState() => _ChoseAqarTypeListTileState();
}

class _ChoseAqarTypeListTileState extends State<_ChoseAqarTypeListTile> {
  bool isCheckBox1Selected = false;
  bool isCheckBox2Selected = false;

  @override
  Widget build(BuildContext context) {
    SearchForMeCubit searchForMeCubit =
        BlocProvider.of<SearchForMeCubit>(context);
    return Container(
      height: 50.h,
      key: ValueKey("#${widget.name}"),
      decoration: BoxDecoration(
          color: AppColors.containerBackground2,
          borderRadius: 10.radius,
          border: Border.all(color: AppColors.grey)),
      padding: gPadding(right: 15),
      margin: gPadding(bottom: 12.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextWidget(
              widget.name,
              style: getTextStyle16(fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: [
              Checkbox(
                  // key: ValueKey("#$name")
                  value: widget.isSelected &&
                      widget.bloc.state.isCheckBox1 &&
                      isCheckBox1Selected,
                  onChanged: (value) {
                    searchForMeCubit.type = 0;
                    searchForMeCubit.catId = widget.areaEntity.id!;
                    print('0000000000000${searchForMeCubit.catId}');
                    setState(() {
                      isCheckBox1Selected = !isCheckBox1Selected;
                      isCheckBox2Selected = false;
                    });

                    widget.onTap();
                    widget.bloc.add(GetCheckBox1Event(isCheckBox1: value!));
                  }),
              10.width,
              Checkbox(
                value: widget.isSelected &&
                    widget.bloc.state.isCheckBox2 &&
                    isCheckBox2Selected,
                onChanged: (value) {
                  searchForMeCubit.type = 1;
                  searchForMeCubit.catId = widget.areaEntity.id!;
                  print('0000000000000${searchForMeCubit.catId}');
                  setState(() {
                    isCheckBox2Selected = !isCheckBox2Selected;
                    isCheckBox1Selected = false;
                  });

                  widget.onTap();
                  widget.bloc.add(GetCheckBox2Event(isCheckBox2: value!));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
