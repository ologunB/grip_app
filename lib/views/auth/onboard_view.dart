import '../widgets/hex_text.dart';
import 'login_view.dart';
import 'signup_view.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      index = (index + 1) % 3;
      if (index == 0) {
        controller.jumpToPage(0);
        return;
      }
      controller.animateToPage(
        index,
        duration: const Duration(seconds: 2),
        curve: Curves.linear,
      );
    });
    super.initState();
  }

  PageController controller = PageController();

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('auth-${context.themeName}-bg'.png),
          ),
        ),
        child: Stack(
          children: [
            PageView(
              controller: controller,
              onPageChanged: (a) => setState(() => index = a),
              children: [0, 1, 2]
                  .map(
                    (e) => Column(
                      children: [
                        SizedBox(height: 100.h),
                        HexText(
                          b[e],
                          fontSize: 32.sp,
                          color: context.textColor,
                          align: TextAlign.center,
                          fontWeight: FontWeight.w600,
                          fontFamily: context.transformaSans,
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.h),
                            child: Image.asset(
                              'onboard$e'.png,
                              height: 350.h,
                              fit: BoxFit.cover,
                              width: 225.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            Align(alignment: Alignment.bottomCenter, child: bottom()),
          ],
        ),
      ),
    );
  }

  Widget bottom() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 14.h,
          alignment: Alignment.center,
          child: ListView.builder(
              itemCount: b.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: index != i ? 20.h : 80.h,
                      height: 6.h,
                      margin: EdgeInsets.all(3.h),
                      decoration: BoxDecoration(
                        color: context.isLight
                            ? (index == i
                                ? AppColors.secondary
                                : AppColors.secondary30)
                            : index == i
                                ? AppColors.secondary
                                : AppColors.secondary,
                        borderRadius: BorderRadius.circular(30.h),
                      ),
                      padding: EdgeInsets.all(3.h),
                    )
                  ],
                );
              }),
        ),
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: HexButton(
            'Create Account',
            buttonColor: AppColors.secondary,
            height: 48,
            fontSize: 14.sp,
            safeArea: false,
            fontWeight: FontWeight.w400,
            textColor: AppColors.black,
            borderColor: AppColors.secondary,
            borderRadius: 10.h,
            onPressed: () {
              push(context, const SignupScreen());
            },
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: HexButton(
            'Log in',
            buttonColor: AppColors.secondary,
            height: 48,
            safeArea: false,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            borderColor: AppColors.secondary,
            borderRadius: 10.h,
            onPressed: () {
              push(context, const LoginScreen());
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 28.h),
          child: SafeArea(
            top: false,
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: 'By proceeding, I accept the terms for ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.textColor,
                      fontFamily: context.transformaSans,
                    ),
                  ),
                  TextSpan(
                    text: 'GRIP Services',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: context.transformaSans,
                      color: context.textColor,
                    ),
                  ),
                  TextSpan(
                    text: ' and confirm that I have read ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: context.transformaSans,
                      color: context.textColor,
                    ),
                  ),
                  TextSpan(
                    text: 'GRIP’s Privacy Policy. ',
                    style: TextStyle(
                      fontFamily: context.transformaSans,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: context.textColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<String> get b => [
        'Discover Stories from\nChristian Creators',
        'Explore the Bible with\nAmazing Creator',
        'Experience Bible\nStudy with Creators',
      ];
}
