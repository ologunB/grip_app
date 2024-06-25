import 'package:flutter/foundation.dart';
import 'package:hexcelon/views/widgets/visibility.dart';

import '../../core/vms/auth_vm.dart';
import '../widgets/hex_text.dart';
import 'login_view.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController password =
      TextEditingController(text: kDebugMode ? 'Topetope@17' : null);
  TextEditingController email =
      TextEditingController(text: kDebugMode ? 'dan@gmail.com' : null);

  TextEditingController name =
      TextEditingController(text: kDebugMode ? 'Dani' : null);

  bool hideText = true;
  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int tick = kDebugMode ? 1 : 0;
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: const ['Join us', 'Create your account'],
      body: BaseView<AuthViewModel>(
        builder: (_, AuthViewModel model, __) => Form(
          key: formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              HexField(
                hintText: 'Username',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: name,
                validator: (a) {
                  return Utils.isValidName(a, type: 'Username', length: 4);
                },
              ),
              SizedBox(height: 20.h),
              HexField(
                hintText: 'Email address',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: email,
                validator: Utils.isValidEmail,
              ),
              SizedBox(height: 20.h),
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
                      tick = tick == 0 ? 1 : 0;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'tick$tick'.png,
                          height: 24.h,
                          color: context.primary,
                        ),
                        SizedBox(width: 16.h),
                        HexText(
                          'I agree to the ',
                          fontSize: 14.sp,
                          color: AppColors.grey2,
                          fontWeight: FontWeight.normal,
                        ),
                        HexText(
                          'terms of use',
                          fontSize: 14.sp,
                          color: context.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              HexButton(
                'Create Account',
                buttonColor: AppColors.secondary,
                height: 48,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                borderRadius: 10.h,
                safeArea: false,
                busy: model.busy,
                onPressed: () {
                  autoValidate = true;
                  setState(() {});
                  if (tick == 0) {
                    errorSnackBar(context, 'Agree with the terms of use');
                    return;
                  }
                  if (formKey.currentState!.validate()) {
                    Utils.offKeyboard();
                    Map<String, dynamic> userData = {
                      "email": email.text.trim(),
                      "username": name.text.trim(),
                      "password": password.text.trim(),
                    };

                    model.signup(userData);
                  }
                },
              ),
              SizedBox(height: 16.h),
              HexText(
                'or sign up with',
                fontSize: 14.sp,
                color: AppColors.grey2,
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
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HexText(
                    'Already have an account? ',
                    fontSize: 14.sp,
                    color: AppColors.grey2,
                    fontWeight: FontWeight.normal,
                  ),
                  InkWell(
                    onTap: () {
                      push(context, const LoginScreen());
                    },
                    child: HexText(
                      'Log in',
                      fontSize: 14.sp,
                      color: context.primary,
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
