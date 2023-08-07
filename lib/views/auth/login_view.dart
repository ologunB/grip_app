import 'package:flutter/foundation.dart';

import '../../core/vms/auth_vm.dart';
import '../widgets/hex_text.dart';
import '../widgets/visibility.dart';
import 'forgot_view.dart';
import 'signup_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController password =
      TextEditingController(text: kDebugMode ? 'Topetope@17' : null);
  TextEditingController email =
      TextEditingController(text: kDebugMode ? 'dan@gmail.com' : null);

  bool hideText = true;
  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: const ['Welcome back', 'Sign in to your account'],
      body: BaseView<AuthViewModel>(
        builder: (_, AuthViewModel model, __) => Form(
          key: formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              HexField(
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: email,
                validator: Utils.isValidEmail,
              ),
              SizedBox(height: 30.h),
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
              SizedBox(height: 30.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      push(context, const ForgotScreen());
                    },
                    child: HexText(
                      'Forgot Password?',
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      align: TextAlign.center,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 45.h),
              HexButton(
                'Log in',
                buttonColor: AppColors.black,
                height: 60,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                borderColor: AppColors.black,
                borderRadius: 10.h,
                busy: model.busy,
                onPressed: () {
                  autoValidate = true;
                  setState(() {});

                  if (formKey.currentState!.validate()) {
                    Utils.offKeyboard();
                    Map<String, dynamic> userData = {
                      "email": email.text,
                      "password": password.text,
                    };

                    model.login(userData);
                  }
                },
              ),
              SizedBox(height: 12.h),
              HexText(
                'or sign in with',
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
                      height: 60,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.black,
                      borderColor: AppColors.grey,
                      borderRadius: 10.h,
                      onPressed: () {},
                    ),
                  ),
                  if (Platform.isIOS)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.h),
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
                          height: 60,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.white,
                          borderColor: AppColors.black,
                          borderRadius: 10.h,
                          onPressed: () {},
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HexText(
                    'Don’t have an account? ',
                    fontSize: 14.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  InkWell(
                    onTap: () {
                      push(context, const SignupScreen());
                    },
                    child: HexText(
                      'Sign up',
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
        ),
      ),
    );
  }
}
