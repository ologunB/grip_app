import '../widgets/hex_text.dart';
import 'verses.dart';

class PassageScreen extends StatefulWidget {
  const PassageScreen({
    super.key,
    required this.value,
    required this.name,
    this.popWhenDone = false,
  });

  final int value;
  final String name;
  final bool popWhenDone;
  @override
  State<PassageScreen> createState() => _PassageScreenState();
}

class _PassageScreenState extends State<PassageScreen> {
  late int value;
  late String name;
  late bool popWhenDone;
  @override
  void initState() {
    value = widget.value;
    name = widget.name;
    popWhenDone = widget.popWhenDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 147.h) / 5;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: HexText(
          name,
          fontSize: 20.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(25.h),
            child: Wrap(
              spacing: 24.h,
              runSpacing: 24.h,
              children: List.generate(value, (i) => i + 1)
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        if (popWhenDone) {
                          Navigator.pop(context);
                          Navigator.pop(context, [name, e]);
                        } else {
                          pushReplacement(
                              context, VersesScreen(book: name, chapter: e));
                        }
                      },
                      borderRadius: BorderRadius.circular(20.h),
                      child: Container(
                        width: width,
                        height: width * 64 / 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.h),
                          border: Border.all(
                            width: 1.h,
                            color: const Color(0xffDCDCDC),
                          ),
                        ),
                        child: HexText(
                          '$e',
                          fontSize: 16.sp,
                          color: Colors.black,
                          align: TextAlign.center,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
