import '../widgets/hex_text.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.body, required this.title});
  final Widget body;
  final List<String> title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Image.asset(
                  'bg'.png,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SafeArea(
            child: ListView(
              children: [
                SizedBox(height: 25.h),
                Image.asset('logo'.png, height: 48.h),
                SizedBox(height: 70.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 42.h, horizontal: 25.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.h),
                      topRight: Radius.circular(50.h),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      if (title.length == 3)
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Image.asset(title[1].png, height: 160.h),
                        ),
                      HexText(
                        title.first,
                        fontSize: 28.sp,
                        color: Colors.black,
                        align: TextAlign.center,
                        fontWeight: FontWeight.w900,
                      ),
                      SizedBox(height: 5.h),
                      HexText(
                        title.last,
                        fontSize: 16.sp,
                        color: Colors.black,
                        align: TextAlign.center,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(height: 21.h),
                      body
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
