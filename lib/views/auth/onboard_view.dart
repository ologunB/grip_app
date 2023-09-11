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
      backgroundColor: Color(index == 0
          ? 0xffD7E2FF
          : index == 1
              ? 0xffCCFFDC
              : 0xffFDFBC2),
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (a) => setState(() => index = a),
            children: [0, 1, 2]
                .map(
                  (e) => Column(
                    children: [
                      SizedBox(height: 120.h),
                      HexText(
                        b[e],
                        fontSize: 28.sp,
                        color: Colors.black,
                        align: TextAlign.center,
                        fontWeight: FontWeight.w900,
                      ),
                      SizedBox(height: 30.h),
                      Expanded(child: Image.asset('onboard$e'.png)),
                      SizedBox(height: 60.h),
                      Visibility(
                        visible: false,
                        maintainState: true,
                        maintainAnimation: true,
                        maintainSize: true,
                        child: bottom(),
                      )
                    ],
                  ),
                )
                .toList(),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottom()),
        ],
      ),
    );
  }

  Widget bottom() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.h),
          child: HexButton(
            'Create Account',
            buttonColor: AppColors.black,
            height: 60,
            fontSize: 16.sp,
            safeArea: false,
            fontWeight: FontWeight.w400,
            textColor: Colors.white,
            borderColor: AppColors.black,
            borderRadius: 10.h,
            onPressed: () {
              push(context, const SignupScreen());
            },
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.h),
          child: HexButton(
            'Log in',
            buttonColor: Colors.white,
            height: 60,
            safeArea: false,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.black,
            borderColor: Colors.transparent,
            borderRadius: 10.h,
            onPressed: () {
              push(context, const LoginScreen());
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 28.h),
          child: SafeArea(
            top: false,
            child: HexText(
              'By continuing, you agree to grip product’s data policy, cookie policy, terms and supplemental conditions',
              fontSize: 16.sp,
              color: Colors.black,
              align: TextAlign.center,
              fontWeight: FontWeight.w400,
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
