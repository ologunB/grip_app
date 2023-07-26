import '../widgets/hex_text.dart';
import 'login_view.dart';
import 'signup_view.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50.h),
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage('bg'.png)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset('logo'.png, height: 48.h),
              SizedBox(height: 40.h),
              HexText(
                'Growing In Purpose',
                fontSize: 28.sp,
                color: Colors.black,
                fontFamily: 'avenir',
                align: TextAlign.center,
                fontWeight: FontWeight.w900,
              ),
              SizedBox(height: 18.h),
              HexText(
                'GRIP is home to curated\ndevotionals from Christian content\ncreators',
                fontSize: 16.sp,
                fontFamily: 'avenir',
                color: Colors.black,
                align: TextAlign.center,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 18.h),
              const Spacer(),
              SizedBox(height: 18.h),
              HexButton(
                'Get Started',
                buttonColor: AppColors.primary,
                height: 70,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                borderColor: AppColors.primary,
                borderRadius: 20.h,
                onPressed: () {
                  push(context, const SignupScreen());
                },
              ),
              SizedBox(height: 14.h),
              HexButton(
                'Log in',
                buttonColor: Colors.transparent,
                height: 70,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.black,
                borderColor: AppColors.black,
                borderRadius: 20.h,
                onPressed: () {
                  push(context, const LoginScreen());
                },
              ),
              SizedBox(height: 44.h),
              HexText(
                'By continuing, you agree to grip product’s data policy, cookie policy, terms and supplemental conditions',
                fontSize: 16.sp,
                fontFamily: 'avenir',
                color: Colors.black,
                align: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
