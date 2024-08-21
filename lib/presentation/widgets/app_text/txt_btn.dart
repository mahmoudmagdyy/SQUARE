import '/index.dart';

class TxtBtn extends StatelessWidget {
  const TxtBtn(
    this.child, {
    Key? key,
    required this.onTap,
    this.onLongpr,
    this.clipper,
    this.color  ,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final CustomClipper<Path>? clipper;
  final VoidCallback? onLongpr;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: clipper,
      child: TextButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(color)),
        onPressed: onTap,
        onLongPress: onLongpr,
        child: child,
      ),
    );
  }
}
