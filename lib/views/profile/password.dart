import '../widgets/hex_text.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBG,
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
        color: AppColors.primaryBG,
        padding: EdgeInsets.all(25.h),
        child: HexButton(
          'Change Password',
          buttonColor: AppColors.primary,
          height: 55,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.white,
          borderColor: AppColors.primary,
          borderRadius: 20.h,
          onPressed: () {},
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
                      color: AppColors.black,
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
            hintText: 'Enter new password',
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
                      color: AppColors.black,
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
            hintText: 'Confirm new password',
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
                      color: AppColors.black,
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
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: HexText(
                  'Forgot Password?',
                  fontSize: 15.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
