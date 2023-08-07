import '../widgets/hex_text.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.body, required this.title});
  final Widget body;
  final List<String> title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Utils.offKeyboard,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.primary),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                if (title.length == 3)
                  Padding(
                    padding: EdgeInsets.only(bottom: 60.h),
                    child: Image.asset(title[1].png, height: 120.h),
                  ),
                HexText(
                  title.first,
                  fontSize: 32.sp,
                  color: AppColors.primary,
                  align: TextAlign.center,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: 5.h),
                HexText(
                  title.last,
                  fontSize: 16.sp,
                  color: AppColors.grey,
                  align: TextAlign.center,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(height: 40.h),
                body,
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
