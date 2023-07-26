import '../widgets/hex_text.dart';
import 'otp_view.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: const [
        'Recover Your\nPassword',
        'forgot',
        'Confirm your email to recover your\npassword',
      ],
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HexField(
            hintText: 'Email',
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: email,
          ),
          SizedBox(height: 35.h),
          HexButton(
            'Reset Password',
            buttonColor: AppColors.primary,
            height: 55,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            borderColor: AppColors.primary,
            borderRadius: 20.h,
            onPressed: () {
              push(context, const OTPScreen());
            },
          ),
        ],
      ),
    );
  }
}
