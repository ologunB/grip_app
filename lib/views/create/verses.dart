import '../widgets/hex_text.dart';

class VersesScreen extends StatefulWidget {
  const VersesScreen(
      {super.key,
      required this.type,
      required this.data,
      required this.popNumber});

  final String type;
  final List<String> data;
  final int popNumber;
  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  List<String> data = [];

  @override
  void initState() {
    data.addAll(widget.data);
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
          widget.type == 'verse' ? 'Verse' : 'Chapter',
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
              children: List.generate(150, (i) => i + 1)
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        if (widget.type == 'verse') {
                          data.add(e.toString());
                          for (dynamic _ in List.filled(widget.popNumber, 0)) {
                            Navigator.pop(context, data);
                          }
                        } else {
                          data.add(e.toString());
                          push(
                            context,
                            VersesScreen(
                              type: 'verse',
                              data: data,
                              popNumber: widget.popNumber,
                            ),
                          );
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
