import '../widgets/hex_text.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold(
      {super.key, required this.body, required this.title, this.other = false});
  final Widget body;
  final List<String> title;
  final bool other;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Utils.offKeyboard,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: context.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: context.primary),
          elevation: 0,
        ),
        body: Container(
          decoration: other
              ? null
              : BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('auth-${context.themeName}-bg'.png),
                    fit: BoxFit.cover,
                  ),
                ),
          child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  if (title.length == 3)
                    Padding(
                      padding: EdgeInsets.only(bottom: 60.h),
                      child: Image.asset(
                        title[1].png,
                        height: 120.h,
                        color: context.primary,
                      ),
                    ),
                  HexText(
                    title.first,
                    style: other
                        ? AppThemes.header2.copyWith(color: context.primary)
                        : AppThemes.header1.copyWith(color: context.primary),
                    align: TextAlign.center,
                  ),
                  SizedBox(height: 5.h),
                  HexText(
                    title.last,
                    style: AppThemes.subHeading16.copyWith(
                      color:
                          context.isLight ? AppColors.darkGrey : AppColors.grey,
                    ),
                    align: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),
                  body,
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
