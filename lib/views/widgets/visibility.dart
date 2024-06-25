import 'hex_text.dart';

class GripVisibility extends StatelessWidget {
  const GripVisibility(
      {super.key, required this.hideText, required this.onTap});

  final bool hideText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: Icon(
              hideText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: context.textColor,
              size: 22.h,
            ),
          )
        ],
      ),
    );
  }
}
