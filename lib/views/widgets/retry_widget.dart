import 'hex_text.dart';

class RetryItem extends StatelessWidget {
  const RetryItem({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HexText(
            'An error occurred, Do you want to retry?',
            fontSize: 18.sp,
            color: AppColors.secondary,
            align: TextAlign.center,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: HexButton(
                  'Retry',
                  buttonColor: AppColors.white,
                  height: 50,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.secondary,
                  borderColor: AppColors.secondary,
                  borderRadius: 10.h,
                  onPressed: onTap,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          )
        ],
      ),
    );
  }
}
