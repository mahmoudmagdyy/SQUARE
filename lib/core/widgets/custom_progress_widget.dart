import 'package:aqarat/core/widgets/custom_loading_widget.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';

class CustomProgressWidget extends StatelessWidget {
  const CustomProgressWidget(
      {super.key, required this.condition, required this.loadedWidget});
  final bool condition;
  final Widget loadedWidget;

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall:
          condition, // i should pass the condition here is state is changed
      blurEffectIntensity: 4,
      progressIndicator: const CustomLoadingWidget(),
      child: loadedWidget,
    );
  }
}
