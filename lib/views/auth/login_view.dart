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

bool get creator => true;

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController password = TextEditingController(
      text: !kDebugMode
          ? null
          : creator
              ? 'johnDoe20!@'
              : 'Topetope@17');
  TextEditingController email = TextEditingController(
      text: !kDebugMode
          ? null
          : creator
              ? 'johndoe1@mail.com'
              : 'dan@gmail.com');

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
                hintText: 'you@example.com',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: email,
                validator: Utils.isValidEmail,
              ),
              SizedBox(height: 30.h),
              HexField(
                hintText: '********',
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
              SizedBox(height: 16.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      push(context, const ForgotScreen());
                    },
                    child: HexText(
                      'Forgot Password?',
                      fontSize: 14.sp,
                      color: context.textColor,
                      align: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              HexButton(
                'Log in',
                buttonColor: AppColors.secondary,
                height: 48,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                borderColor: AppColors.secondary,
                borderRadius: 4.h,
                safeArea: false,
                busy: model.busy,
                onPressed: () {
                  autoValidate = true;
                  setState(() {});

                  if (formKey.currentState!.validate()) {
                    Utils.offKeyboard();
                    Map<String, dynamic> userData = {
                      "email": email.text.trim(),
                      "password": password.text.trim(),
                    };

                    model.login(userData);
                  }
                },
              ),
              SizedBox(height: 16.h),
              HexText(
                'or sign in with',
                fontSize: 14.sp,
                color: context.textColor,
                align: TextAlign.center,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 16.h),
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
                      height: 48,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.black,
                      borderColor: AppColors.white,
                      borderRadius: 4.h,
                      onPressed: () {
                        model.signInWithGoogle();
                      },
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
                          height: 48,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.white,
                          borderColor: AppColors.black,
                          borderRadius: 4.h,
                          onPressed: () {
                            model.signInApple();
                          },
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HexText(
                    'Don’t have an account? ',
                    fontSize: 14.sp,
                    color: AppColors.grey2,
                    fontWeight: FontWeight.w500,
                  ),
                  InkWell(
                    onTap: () {
                      push(context, const SignupScreen());
                    },
                    child: HexText(
                      'Sign up',
                      fontSize: 14.sp,
                      color: context.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 71.h),
              Image.asset(
                'logo20'.png,
                height: 53.h,
              ),
              SizedBox(height: 21.h),
            ],
          ),
        ),
      ),
    );
  }
}
