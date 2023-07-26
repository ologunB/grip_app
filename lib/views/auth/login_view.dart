import '../home/main_layout.dart';
import '../widgets/hex_text.dart';
import 'forgot_view.dart';
import 'signup_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: const ['Welcome back', 'Sign in to your account'],
      body: Column(
        children: [
          HexField(
            hintText: 'Email',
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: email,
          ),
          SizedBox(height: 20.h),
          HexField(
            hintText: 'Password',
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: password,
            obscureText: hideText,
            suffix: Padding(
              padding: EdgeInsets.only(right: 12.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      hideText = !hideText;
                      setState(() {});
                    },
                    child: Icon(
                      hideText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.black,
                      size: 22.h,
                    ),
                  )
                ],
              ),
            ),
            validator: (a) {
              return Utils.isValidPassword(a);
            },
          ),
          SizedBox(height: 30.h),
          HexButton(
            'Sign in',
            buttonColor: AppColors.primary,
            height: 55,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            borderColor: AppColors.primary,
            borderRadius: 20.h,
            onPressed: () {
              pushAndRemoveUntil(context, const MainLayout());
            },
          ),
          SizedBox(height: 12.h),
          HexText(
            'or sign in with',
            fontSize: 14.sp,
            color: Colors.black,
            align: TextAlign.center,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: HexButton(
                  '  Google',
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset('google'.png, height: 25.h)],
                  ),
                  buttonColor: AppColors.white,
                  height: 55,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black,
                  borderColor: AppColors.grey,
                  borderRadius: 20.h,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: HexButton(
                  '  Apple',
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'apple'.png,
                        height: 25.h,
                        color: Colors.white,
                      )
                    ],
                  ),
                  buttonColor: AppColors.black,
                  height: 55,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.white,
                  borderColor: AppColors.black,
                  borderRadius: 20.h,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 26.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HexText(
                'Don’t have an account? ',
                fontSize: 14.sp,
                color: AppColors.black,
                fontWeight: FontWeight.normal,
              ),
              InkWell(
                onTap: () {
                  push(context, const SignupScreen());
                },
                child: HexText(
                  'Sign up',
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 21.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  push(context, const ForgotScreen());
                },
                child: HexText(
                  'Forgot Password?',
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
