import '../widgets/hex_text.dart';
import 'one_version.dart';

class AllVersionScreen extends StatefulWidget {
  const AllVersionScreen({super.key});

  @override
  State<AllVersionScreen> createState() => _AllVersionScreenState();
}

class _AllVersionScreenState extends State<AllVersionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: HexText(
          'Bibles',
          fontSize: 20.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Divider(
            height: 0.h,
            thickness: 1.h,
            color: const Color(0xffE6E6E6),
          ),
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 15.h),
        itemCount: 10,
        itemBuilder: (c, i) {
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HexText(
                    'KJV',
                    fontSize: 16.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  HexText(
                    'King James Version',
                    fontSize: 14.sp,
                    color: AppColors.black,
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(width: 8.h),
              InkWell(
                onTap: () {
                  if (!selected.contains(i)) {
                    download(i);
                  } else {
                    push(context, const OneVersionScreen());
                  }
                },
                child: HexText(
                  selected.contains(i) ? 'Open' : 'Download',
                  fontSize: 16.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  align: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<int> selected = [];

  download(int i) {
    selected.add(i);
    setState(() {});
  }
}
