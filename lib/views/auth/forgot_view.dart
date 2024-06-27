import 'package:flutter/foundation.dart';

import '../../core/vms/auth_vm.dart';
import '../widgets/hex_text.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController email =
      TextEditingController(text: kDebugMode ? 'dan@gmail.com' : null);

  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: const [
        'Recover Your Password',
        'forgot',
        'Confirm your email to\nrecover your password',
      ],
      other: true,
      body: BaseView<AuthViewModel>(
        builder: (_, AuthViewModel model, __) => Form(
          key: formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HexField(
                hintText: 'you@example.com',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: email,
                validator: Utils.isValidEmail,
              ),
              SizedBox(height: 50.h),
              HexButton(
                'Submit',
                buttonColor: AppColors.secondary,
                height: 48,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                borderRadius: 4.h,
                busy: model.busy,
                onPressed: () {
                  autoValidate = true;
                  setState(() {});
                  if (formKey.currentState!.validate()) {
                    Utils.offKeyboard();
                    model.forgotPassword(email.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
