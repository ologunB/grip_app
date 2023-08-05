import '../widgets/hex_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 25.h),
                Expanded(
                  child: CupertinoTextField(
                    prefix: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          child: Image.asset(
                            'search'.png,
                            height: 24.h,
                            color: const Color(0xffE0E0E0),
                          ),
                        ),
                      ],
                    ),
                    placeholder: 'Search',
                    placeholderStyle: TextStyle(
                      fontFamily: 'Nova',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffE0E0E0),
                    ),
                    padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.h),
                      border: Border.all(
                        color: const Color(0xffE0E0E0),
                      ),
                    ),
                    maxLines: 3,
                    minLines: 1,
                  ),
                ),
                SizedBox(width: 25.h),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: HexText(
                    'Cancel',
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 25.h),
              ],
            )
          ],
        ),
      ),
    );
  }
}
