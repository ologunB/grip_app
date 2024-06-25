import 'package:google_fonts/google_fonts.dart';

import 'hex_text.dart';

class AppColors {
  static const Color orange2 = Color(0xffFFA953);
  static const Color deep = Color(0xff1F115C);
  static const Color black2 = Color(0xff2F2F2F);
  static const Color pressedButton = Color(0xff433499);
  static const Color primary = Color(0xffCCFD54);
  static const Color secondary = Color(0xff5441BF);
  static const Color black = Color(0xff191919);
  static const Color white = Color(0xffFFFFFF);
  static const Color secondary2 = Color(0xff927FFF);
  static const Color linearStart = Color(0xff5840C6);
  static const Color linearEnd = Color(0xffFFD7AD);
  static const Color grey = Color(0xffC6C6C6);
  static const Color grey2 = Color(0xff828282);

  static const Color orange = Color(0xffFFCE9C);
  static const Color darkModeBG = Color(0xff121212);
  static const Color lightModeBG = Color(0xffFAFAFA);
  static const Color darkGrey = Color(0xff86878B);
  static Color secondary30 = secondary.withOpacity(.3);
  static Color primary30 = primary.withOpacity(.3);
  static const Color bottomSheetBG = Color(0xff272727);
  static const Color red = Color(0xffEA4335);
}

extension ColorExtension on BuildContext {
  bool get isLight => Theme.of(this).brightness == Brightness.light;

  Color get textColor => isLight ? AppColors.black : AppColors.white;
  Color get bgColor => isLight ? AppColors.lightModeBG : AppColors.darkModeBG;
  Color get primary => isLight ? AppColors.secondary : AppColors.primary;

  String get transformaSans => 'TransformaSans';

  String get themeName => isLight ? 'light' : 'dark';
}

class AppThemes {
  static String get transformaSans => 'transformaSans';
  static TextStyle header1 = TextStyle(
    fontFamily: transformaSans,
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle header2 = TextStyle(
    fontFamily: transformaSans,
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle subHeading16 = TextStyle(
    fontFamily: transformaSans,
    fontSize: 16.sp,
  );
  static TextStyle bodyText1 = TextStyle(
    fontFamily: transformaSans,
    fontSize: 14.sp,
  );
  static TextStyle bodyText2 = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyText3 = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
  );
  static TextStyle taskBarText = GoogleFonts.nunito(
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
  );
  static TextStyle taskBarBold = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle buttonText = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
  );
  static TextStyle buttonText2 = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle pillText = TextStyle(
    fontFamily: transformaSans,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle profileNameXL = GoogleFonts.nunito(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle profileNameL = GoogleFonts.nunito(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle profileNameM = GoogleFonts.nunito(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle profileNameS = GoogleFonts.nunito(
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle tabHeader = TextStyle(
    fontFamily: transformaSans,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle time = GoogleFonts.inter(fontSize: 8.sp);
  static TextStyle title = GoogleFonts.nunito(
    fontSize: 15.sp,
    fontWeight: FontWeight.w900,
  );
  static TextStyle iconText = GoogleFonts.inter(fontSize: 13.sp);
  static TextStyle commentText = GoogleFonts.inter(fontSize: 14.sp);
  static TextStyle mainProfileName = GoogleFonts.nunito(
    fontSize: 18.sp,
    fontWeight: FontWeight.w800,
  );
  static TextStyle counterL = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle counterTitle = GoogleFonts.inter(fontSize: 16.sp);
  static TextStyle taskBarTitle = GoogleFonts.inter(fontSize: 16.sp);
  static TextStyle bibleTitle = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle bibleVersionText = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
  );
  static TextStyle inputErrorText = GoogleFonts.nunito(
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);
  static TextStyle notificationDayText = GoogleFonts.nunito(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
}
