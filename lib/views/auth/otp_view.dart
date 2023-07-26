import '../widgets/hex_text.dart';
import 'change_pass_view.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: const [
        'Verify your email',
        'done',
        'Enter the Verification code you just\nreceived',
      ],
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HexField(
            hintText: 'OTP',
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 4,
            textAlign: TextAlign.center,
            controller: email,
          ),
          SizedBox(height: 35.h),
          HexButton(
            'Verify OTP',
            buttonColor: AppColors.primary,
            height: 55,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            borderColor: AppColors.primary,
            borderRadius: 20.h,
            onPressed: () {
              push(context, const ChangePassScreen());
            },
          ),
          SizedBox(height: 35.h),
        ],
      ),
    );
  }
}
