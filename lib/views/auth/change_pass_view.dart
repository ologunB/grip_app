import 'package:hexcelon/core/apis/base_api.dart';

import '../../core/vms/auth_vm.dart';
import '../widgets/hex_text.dart';
import '../widgets/visibility.dart';
import 'login_view.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key, required this.data});

  final Map<String, dynamic> data;
  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  bool hideText = true;

  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: const [
        'Set new password',
        'change',
        'Enter new password',
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
                hintText: 'Password',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: password,
                obscureText: hideText,
                suffix: GripVisibility(
                  hideText: hideText,
                  onTap: () {
                    hideText = !hideText;
                    setState(() {});
                  },
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
                suffix: GripVisibility(
                  hideText: hideText,
                  onTap: () {
                    hideText = !hideText;
                    setState(() {});
                  },
                ),
                validator: (a) {
                  if (a!.isEmpty) {
                    return 'Password cannot be empty';
                  } else if (a != password.text.trim()) {
                    return 'Passwords doesnt match';
                  }
                  return null;
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
                busy: model.busy,
                onPressed: () async {
                  autoValidate = true;
                  setState(() {});

                  if (formKey.currentState!.validate()) {
                    Utils.offKeyboard();
                    Map<String, dynamic> userData = {
                      "password": password.text.trim(),
                      "confirmPassword": password.text.trim(),
                    };
                    userData.addAll(widget.data);

                    bool a = await model.resetPassword(userData);
                    if (a) {
                      if (AppCache.getUser() == null) {
                        pushAndRemoveUntil(context, const LoginScreen());
                      } else {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                      successSnackBar(context, 'Password reset successfully');
                    }
                  }
                },
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
