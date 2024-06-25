import 'package:google_fonts/google_fonts.dart';
import 'package:hexcelon/core/apis/base_api.dart';

import '../../core/storage/model.dart';
import '../widgets/hex_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Verse> filtered = [];

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: PreferredSize(
        preferredSize: Size(0, 60.h),
        child: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: SafeArea(
            child: Row(
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
                            color: context.primary,
                          ),
                        ),
                      ],
                    ),
                    autofocus: true,
                    placeholder: 'Search',
                    textInputAction: TextInputAction.search,
                    controller: controller,
                    style: GoogleFonts.inter(color: context.textColor),
                    placeholderStyle: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.textColor,
                    ),
                    padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.h),
                      border: Border.all(
                        color: context.textColor,
                      ),
                    ),
                    maxLines: 3,
                    minLines: 1,
                    onChanged: (a) {
                      a = a.trim();
                      if (a.isNotEmpty) {
                        filtered.clear();
                        filtered = objectbox.searchText(a);
                      } else {
                        filtered.clear();
                      }
                      setState(() {});
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: HexText(
                    'Cancel',
                    fontSize: 16.sp,
                    color: context.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 16.h),
              ],
            ),
          ),
        ),
      ),
      body: controller.text.isEmpty
          ? const EmptyOne('Search through the scriptures')
          : filtered.isEmpty
              ? EmptyOne('No verse mentions "${controller.text}"')
              : ListView.separated(
                  itemCount: filtered.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, __) =>
                      Divider(height: 0, thickness: 1.h, color: Colors.black12),
                  padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                  itemBuilder: (context, index) {
                    Verse v = filtered[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pop(
                            context, [v.bookName, v.verse, v.chapter]);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.h, vertical: 8.h),
                        child: Column(
                          key: ValueKey(v.absoluteVerse),
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            highlightText(v),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget highlightText(Verse v) {
    List<TextSpan> spans = [];
    spans.add(
      TextSpan(
        text: '${v.verseName}: ',
        style: TextStyle(
          fontFamily: 'Nova',
          fontSize: 16.sp,
          color: context.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    String ht = v.text.splitMapJoin(
      RegExp(controller.text, caseSensitive: false),
      onMatch: (match) => '<highlight>${match.group(0)}</highlight>',
      onNonMatch: (nonMatch) => nonMatch,
    );

    TextStyle style = TextStyle(
      fontFamily: 'Nova',
      fontSize: 16.sp,
      color: context.textColor,
      fontWeight: FontWeight.w400,
    );
    ht.split('<highlight>').forEach((segment) {
      if (segment.contains('</highlight>')) {
        var parts = segment.split('</highlight>');
        spans.add(
          TextSpan(
            text: parts.first,
            style: style.copyWith(
              backgroundColor: AppColors.secondary.withOpacity(.2),
              color: context.primary,
            ),
          ),
        );
        if (parts.length > 1) {
          spans.add(TextSpan(text: parts.last, style: style));
        }
      } else {
        spans.add(TextSpan(text: segment, style: style));
      }
    });

    return RichText(text: TextSpan(children: spans));
  }
}

class EmptyOne extends StatelessWidget {
  const EmptyOne(
    this.a, {
    super.key,
  });
  final String a;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('empty'.png, height: 100.h, color: context.textColor),
          HexText(
            a,
            fontSize: 18.sp,
            color: context.textColor,
            fontWeight: FontWeight.w700,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
