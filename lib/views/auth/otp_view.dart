import 'package:hexcelon/core/apis/base_api.dart';
import 'package:hexcelon/views/auth/change_pass_view.dart';

import '../../core/models/navigator.dart';
import '../../core/vms/auth_vm.dart';
import '../widgets/hex_text.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, this.email});

  final String? email;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController code = TextEditingController();
  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginResponse? login =
        AppNavigator.navKey.currentContext!.read<AuthViewModel>().loginResponse;

    return AuthScaffold(
      title: const [
        'Verify your email',
        'done',
        'Enter the Verification code you just\nreceived',
      ],
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
                hintText: 'OTP',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                maxLength: 5,
                autoFocus: true,
                textAlign: TextAlign.center,
                controller: code,
                validator: (a) {
                  if (a!.isEmpty) {
                    return 'OTP cannot be empty';
                  } else if (a.length != 5) {
                    return 'OTP length must be 5';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50.h),
              HexButton(
                'Submit',
                buttonColor: AppColors.black,
                borderColor: Colors.transparent,
                height: 60,
                fontSize: 16.sp,
                busy: model.busy,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                borderRadius: 10.h,
                onPressed: () {
                  autoValidate = true;
                  setState(() {});

                  if (formKey.currentState!.validate()) {
                    Utils.offKeyboard();

                    if (widget.email == null) {
                      model.verify({"id": login?.user?.id, "code": code.text});
                    } else {
                      push(
                        context,
                        ChangePassScreen(
                          data: {'email': widget.email, 'code': code.text},
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 50.h),
              BaseView<AuthViewModel>(
                builder: (_, AuthViewModel rModel, __) => rModel.busy
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [HexProgress()],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HexText(
                            'Didnt get OTP? ',
                            fontSize: 14.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                          InkWell(
                            onTap: () {
                              rModel.resendOTP(login?.user?.email);
                            },
                            child: HexText(
                              'Resend',
                              fontSize: 14.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(height: 21.h),
            ],
          ),
        ),
      ),
    );
  }
}
