import '../widgets/hex_text.dart';

class ChooseBookScreen extends StatefulWidget {
  const ChooseBookScreen({super.key});

  @override
  State<ChooseBookScreen> createState() => _ChooseBookScreenState();
}

class _ChooseBookScreenState extends State<ChooseBookScreen> {
  List<String> books = [
    'Genesis',
    'Psalms',
    'John',
    'Luke',
    'Excodus',
    'Titus'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBG,
        elevation: 0,
        centerTitle: true,
        title: HexText(
          'Select Bible book',
          fontSize: 20.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.h),
          child: Divider(
            height: 0.h,
            thickness: 1.h,
            color: const Color(0xffE6E6E6),
          ),
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: books.length,
        itemBuilder: (c, i) {
          String a = books[i];

          return InkWell(
            onTap: () {
              Navigator.pop(context, a);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 15.h),
              child: Row(
                children: [
                  HexText(
                    a,
                    fontSize: 16.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                  SizedBox(width: 8.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
