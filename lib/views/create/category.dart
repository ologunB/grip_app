import '../widgets/hex_text.dart';

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({super.key});

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBG,
        elevation: 0,
        centerTitle: true,
        title: HexText(
          'Categories',
          fontSize: 20.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.h),
        child: HexButton(
          'Update',
          buttonColor: AppColors.primary,
          height: 55,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.white,
          borderColor: AppColors.primary,
          borderRadius: 20.h,
          onPressed: () {
            Navigator.pop(context, selected);
          },
        ),
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
        itemCount: [].length,
        itemBuilder: (c, i) {
          String a = [][i];
          bool contains = selected.contains(a);

          return InkWell(
            onTap: () {
              if (contains) {
                selected.remove(a);
              } else {
                selected.add(a);
              }
              setState(() {});
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
                  contains
                      ? Image.asset('tick'.png, height: 24.h)
                      : SizedBox(height: 24.h)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
