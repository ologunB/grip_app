import 'package:hexcelon/core/apis/base_api.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
      appBar: PreferredSize(
        preferredSize: Size(0, 55.h),
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
                          color: const Color(0xffE0E0E0),
                        ),
                      ),
                    ],
                  ),
                  placeholder: 'Search',
                  controller: controller,
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
              SizedBox(width: 10.h),
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
          ),
        ),
      ),
      body: controller.text.isEmpty
          ? empty('Search through the scriptures')
          : filtered.isEmpty
              ? empty('No verse fits "${controller.text}"')
              : ScrollablePositionedList.separated(
                  itemCount: filtered.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, __) =>
                      Divider(height: 0, thickness: 1.h, color: Colors.black12),
                  padding: EdgeInsets.zero,
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
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    String highlightedText = v.text.splitMapJoin(
      RegExp(controller.text, caseSensitive: false),
      onMatch: (match) => '<highlight>${match.group(0)}</highlight>',
      onNonMatch: (nonMatch) => nonMatch,
    );

    TextStyle style = TextStyle(
      fontFamily: 'Nova',
      fontSize: 16.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    );
    highlightedText.split('<highlight>').forEach((segment) {
      if (segment.contains('</highlight>')) {
        var parts = segment.split('</highlight>');
        spans.add(
          TextSpan(
            text: parts.first,
            style: style.copyWith(
              backgroundColor: Colors.yellow,
              color: AppColors.primary,
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

  Widget empty(String a) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('empty'.png, height: 100.h, color: Colors.black),
          HexText(
            a,
            fontSize: 18.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
