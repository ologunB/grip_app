import 'hex_text.dart';

class HexProgress extends StatelessWidget {
  const HexProgress({this.size = 20, super.key});

  final double size;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      SizedBox(
        height: size.h,
        width: size.h,
        child: CircularProgressIndicator(
          strokeWidth: 3.h,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      )
    ],);
  }
}
