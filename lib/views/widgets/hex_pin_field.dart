import 'hex_text.dart';

class HexPinField extends StatelessWidget {
  final String? title;
  final int maxLength;
  final TextEditingController controller;
  final Color? color;
  final Color? textColor;
  final Function(String?)? onDone;
  final Function(String?)? onChanged;

  HexPinField({
    super.key,
    this.title,
    this.onDone,
    this.onChanged,
    required this.maxLength,
    required this.controller,
    this.color,
    this.textColor,
  });

  final pinTheme = PinTheme(
    height: 45.h,
    width: 45.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.h),
      border: Border.all(color: AppColors.grey, width: 1.h),
    ),
    textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: HexText(
                  title!,
                  fontSize: 12.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
        Pinput(
          length: maxLength,
          onCompleted: onDone,
          onChanged: onChanged,
          controller: controller,
          autofocus: true,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          focusedPinTheme: PinTheme(
            height: 72.h,
            width: 63.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15.h),
              border: Border.all(color: color ?? AppColors.primary, width: 1.h),
            ),
            textStyle: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24.sp,
              color: textColor ?? AppColors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
          submittedPinTheme: PinTheme(
            height: 72.h,
            width: 63.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: color ?? AppColors.primary, width: 1.h),
              borderRadius: BorderRadius.circular(15.h),
            ),
            textStyle: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: textColor ?? AppColors.black,
            ),
          ),
          defaultPinTheme: PinTheme(
            height: 72.h,
            width: 63.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: color?.withOpacity(.2) ??
                      AppColors.primary.withOpacity(.2),
                  width: 1.h),
              borderRadius: BorderRadius.circular(15.h),
            ),
            textStyle: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: textColor ?? AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
