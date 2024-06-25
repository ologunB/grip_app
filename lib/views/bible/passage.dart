import '../widgets/hex_text.dart';
import 'verses.dart';

class PassageScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 147.h) / 5;
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.bgColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: context.primary),
        title: HexText(
          name,
          fontSize: 20.sp,
          color: context.textColor,
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
                          push(context, VersesScreen(book: name, chapter: e));
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
                          color: context.textColor,
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
