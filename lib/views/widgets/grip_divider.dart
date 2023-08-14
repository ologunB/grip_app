import 'hex_text.dart';

class GripDivider extends StatelessWidget {
  const GripDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child:
          Divider(height: 0.h, thickness: 1.h, color: const Color(0xffE6E6E6)),
    );
  }
}
