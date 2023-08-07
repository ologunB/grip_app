import 'hex_text.dart';

void errorSnackBar(BuildContext context, String title) {
  final Flushbar<void> flushBar = Flushbar<void>(
    title: title,
    titleText: Row(
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: AppColors.red,
          size: 22.h,
        ),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            size: 20.h,
            color: AppColors.red,
          ),
        )
      ],
    ),
    messageText: HexText(
      title,
      fontSize: 15.sp,
      color: AppColors.red,
      fontWeight: FontWeight.w600,
    ),
    borderRadius: BorderRadius.circular(8.h),
    margin: EdgeInsets.all(16.h),
    borderColor: AppColors.red,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 2),
    backgroundColor: const Color(0xFFE3CDC6),
  );

  if (!flushBar.isShowing()) {
    flushBar.show(context);
  }
}

void successSnackBar(BuildContext context, String title) {
  final Flushbar<void> flushBar = Flushbar<void>(
    title: title,
    titleText: Row(
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          color: AppColors.primary,
          size: 22.h,
        ),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            size: 20.h,
            color: AppColors.primary,
          ),
        )
      ],
    ),
    messageText: HexText(
      title,
      fontSize: 15.sp,
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
    ),
    borderRadius: BorderRadius.circular(8.h),
    margin: EdgeInsets.all(16.h),
    borderColor: AppColors.primary,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 4),
    backgroundColor: const Color(0xFFE3CDC6),
  );

  if (!flushBar.isShowing()) {
    flushBar.show(context);
  }
}
