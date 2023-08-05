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
        'Recover Your Password',
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
          SizedBox(height: 50.h),
          HexButton(
            'Reset',
            buttonColor: AppColors.black,
            borderColor: Colors.transparent,
            height: 60,
            fontSize: 16.sp,
            borderRadius: 10.h,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            onPressed: () {
              push(context, const OTPScreen());
            },
          ),
        ],
      ),
    );
  }
}
