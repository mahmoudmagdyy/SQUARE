
import 'package:aqarat/index.dart';

class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({
    super.key,
    required this.array,
    required this.title,
    required this.onSelectedValue,
    this.borderColor,
    this.backgroundColor,
    this.isShowLeading = false,
    this.color,
  });
  final List array;
  final String title;
  final Color? color;
  final ValueChanged<int> onSelectedValue;
  final Color? borderColor;
  final Color? backgroundColor;
  final bool isShowLeading;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  final ExpansionTileController _controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: _controller,
      childrenPadding: gPadding(right: 5, left: 5),
      tilePadding: gPadding(right: 15, top: -2.5, left: 15, bottom: -2.5),
      // iconColor: AppColors.primary,
      clipBehavior: Clip.hardEdge,
      collapsedBackgroundColor: widget.backgroundColor,
      backgroundColor: widget.backgroundColor,
      // trailing:  SvgImageWidget(AppImages.arrowDown , size: 20.h),
      // leading:
      //     widget.isShowLeading ? const SvgImageWidget(AppImages.location) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(
            width: 1.5,
            color: widget.borderColor ?? AppColors.grey.withOpacity(0.6)),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(
            color: widget.borderColor ?? AppColors.grey.withOpacity(0.6)),
      ),
      title: TextWidget(
        widget.title,
        style: getTextStyleNormal(
          color: widget.color ?? AppColors.textHent,
        ),
      ),
      children: List.generate(
        widget.array.length,
        (index) {
          return TextButton(
            onPressed: () {
              widget.onSelectedValue(index);
              _controller.collapse();

              setState(() {});
            },
            style: TextButton.styleFrom(
              fixedSize: Size(ScreenUtil().screenWidth, 35.h),
              alignment: AlignmentDirectional.centerStart,
            ),
            child: TextWidget(
              (widget.array[index] is QuestionsModel)
                  ? widget.array[index].title
                  : widget.array[index].name,
              style: getTextStyleNormal(color: AppColors.black),
            ),
          );
        },
      ),
    );
  }
}

/* class MyExpansionTile extends StatefulWidget {
  const MyExpansionTile({super.key});

  @override
  State<MyExpansionTile> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool _isExpanded = false;

  void _onItemPressed() {
    setState(() {
      _isExpanded = false;
    });
    log(_isExpanded.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ExpansionTile(
            title: const Text('Expandable List'),
            initiallyExpanded: _isExpanded,
            controller: controller,
            children: [
              GestureDetector(
                onTap: () {
                  controller.collapse();
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Item 1'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _onItemPressed();
                },
                child: const ListTile(
                  title: Text('Item 2'),
                ),
              ),
            ],
            onExpansionChanged: (isExpanded) {
              setState(() {
                _isExpanded = isExpanded;
              });
            },
          ),
          if (_isExpanded) const SizedBox(height: 0, width: double.infinity),
        ],
      ),
    );
  }
}
 */