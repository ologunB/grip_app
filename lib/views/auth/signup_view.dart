import '../widgets/hex_text.dart';
import 'follow_topics_view.dart';
import 'login_view.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  bool hideText = true;

  int tick = 0;
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: const ['Join us', 'Create your account'],
      body: Column(
        children: [
          HexField(
            hintText: 'Username',
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: name,
          ),
          SizedBox(height: 20.h),
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
          SizedBox(height: 20.h),
          InkWell(
            onTap: () {
              tick = tick == 0 ? 1 : 0;
              setState(() {});
            },
            child: Row(
              children: [
                Image.asset('tick$tick'.png, height: 24.h),
                SizedBox(width: 16.h),
                HexText(
                  'I agree to the ',
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                HexText(
                  'terms of use',
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          HexButton(
            'Create Account',
            buttonColor: AppColors.primary,
            height: 55,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            borderColor: AppColors.primary,
            borderRadius: 20.h,
            onPressed: () {
              push(context, const FollowTopicsScreen());
            },
          ),
          SizedBox(height: 12.h),
          HexText(
            'or sign up with',
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
                'Already have an account?',
                fontSize: 14.sp,
                color: AppColors.black,
                fontWeight: FontWeight.normal,
              ),
              InkWell(
                onTap: () {
                  push(context, const LoginScreen());
                },
                child: HexText(
                  'Log in',
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 21.h),
        ],
      ),
    );
  }
}
