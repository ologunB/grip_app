import 'hex_text.dart';

class HexDialog extends StatefulWidget {
  const HexDialog({super.key, required this.child, this.close});

  final Widget child;
  final Function()? close;
  @override
  State<HexDialog> createState() => _HexDialogState();
}

class _HexDialogState extends State<HexDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(20.h),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.h)),
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 30.h),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: widget.child,
            ),
          ),
          Positioned(
            top: -15.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.h),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  if (widget.close != null) {
                    widget.close!();
                  }
                },
                borderRadius: BorderRadius.circular(15.h),
                child: Image.asset(
                  'g-close'.png,
                  height: 30.h,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
