import 'package:hexcelon/core/apis/base_api.dart';

import '../../core/vms/auth_vm.dart';
import '../widgets/hex_text.dart';
import '../widgets/visibility.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  bool hideText = true;

  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      builder: (_, AuthViewModel model, __) => Form(
        key: formKey,
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            title: HexText(
              'Change Password',
              fontSize: 16.sp,
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
            elevation: 0,
          ),
          bottomSheet: Container(
            color: Colors.white,
            padding: EdgeInsets.all(25.h),
            child: HexButton(
              'Change Password',
              buttonColor: AppColors.black,
              height: 60,
              fontSize: 16.sp,
              busy: model.busy,
              fontWeight: FontWeight.w400,
              textColor: AppColors.white,
              borderColor: Colors.transparent,
              borderRadius: 10.h,
              onPressed: () async {
                autoValidate = true;
                setState(() {});

                if (formKey.currentState!.validate()) {
                  Utils.offKeyboard();
                  bool a = await model.changePassword({
                    'oldPassword': oldPassword.text.trim(),
                    'newPassword': password.text.trim(),
                  });
                  if (a) {
                    Navigator.pop(context);
                    successSnackBar(
                        context, '"Password has been successfully changed');
                  }
                }
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(25.h),
            children: [
              HexField(
                hintText: 'Enter old password',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: oldPassword,
                obscureText: hideText,
                suffix: GripVisibility(
                  onTap: () {
                    hideText = !hideText;
                    setState(() {});
                  },
                  hideText: hideText,
                ),
                validator: (a) {
                  return Utils.isValidPassword(a);
                },
              ),
              SizedBox(height: 20.h),
              HexField(
                hintText: 'Enter new password',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: password,
                obscureText: hideText,
                suffix: GripVisibility(
                  onTap: () {
                    hideText = !hideText;
                    setState(() {});
                  },
                  hideText: hideText,
                ),
                validator: (a) {
                  return Utils.isValidPassword(a);
                },
              ),
              SizedBox(height: 20.h),
              HexField(
                hintText: 'Confirm new password',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: cPassword,
                obscureText: hideText,
                suffix: GripVisibility(
                  onTap: () {
                    hideText = !hideText;
                    setState(() {});
                  },
                  hideText: hideText,
                ),
                validator: (a) {
                  if (a!.isEmpty) {
                    return 'Password cannot be Empty';
                  } else if (a != password.text) {
                    return 'Passwords doesn\'t match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.h),
              BaseView<AuthViewModel>(
                builder: (_, AuthViewModel fModel, __) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    fModel.busy
                        ? const HexProgress()
                        : InkWell(
                            onTap: () {
                              fModel.forgotPassword(
                                  AppCache.getUser()?.user?.email);
                            },
                            child: HexText(
                              'Forgot Password?',
                              fontSize: 14.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
