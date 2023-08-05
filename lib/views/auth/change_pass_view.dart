import '../widgets/hex_text.dart';
import 'login_view.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: const [
        'Set new password',
        'change',
        'Enter new password',
      ],
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                      color: AppColors.primary,
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
          HexField(
            hintText: 'Confirm Password',
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: cPassword,
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
                      color: AppColors.primary,
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
          SizedBox(height: 50.h),
          HexButton(
            'Set Password',
            height: 60,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            buttonColor: AppColors.black,
            borderColor: Colors.transparent,
            borderRadius: 10.h,
            onPressed: () {
              pushAndRemoveUntil(context, const LoginScreen());
            },
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
