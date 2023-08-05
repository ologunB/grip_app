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
          SizedBox(height: 50.h),
          HexButton(
            'Submit',
            buttonColor: AppColors.black,
            borderColor: Colors.transparent,
            height: 60,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            borderRadius: 10.h,
            onPressed: () {
              push(context, const ChangePassScreen());
            },
          ),
        ],
      ),
    );
  }
}
