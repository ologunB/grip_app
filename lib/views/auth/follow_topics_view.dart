import '../widgets/hex_text.dart';
import 'follow_people_view.dart';

class FollowTopicsScreen extends StatefulWidget {
  const FollowTopicsScreen({super.key});

  @override
  State<FollowTopicsScreen> createState() => _FollowTopicsScreenState();
}

class _FollowTopicsScreenState extends State<FollowTopicsScreen> {
  List<String> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.all(25.h),
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage('bg'.png)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              HexText(
                'Welcome to GRIP',
                fontSize: 28.sp,
                color: AppColors.primary,
                align: TextAlign.center,
                fontWeight: FontWeight.w900,
              ),
              SizedBox(height: 16.h),
              HexText(
                'Select at least 5 topics to\npersonalise your feed',
                fontSize: 16.sp,
                color: Colors.black,
                align: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: ListView(
                    children: [
                      Wrap(
                        spacing: 12.h,
                        runSpacing: 12.h,
                        children: topics.map(
                          (e) {
                            bool contains = selected.contains(e);
                            return InkWell(
                              onTap: () {
                                if (contains) {
                                  selected.remove(e);
                                } else {
                                  selected.add(e);
                                }
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 26.h, vertical: 14.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.h),
                                  border: Border.all(
                                    width: 1.h,
                                    color: AppColors.black,
                                  ),
                                  color: !contains
                                      ? Colors.transparent
                                      : AppColors.primary,
                                ),
                                child: HexText(
                                  e,
                                  fontSize: 16.sp,
                                  color:
                                      contains ? Colors.white : AppColors.black,
                                  align: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ),
              HexButton(
                'Continue',
                buttonColor: AppColors.primary,
                height: 55,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                borderColor: AppColors.primary,
                borderRadius: 20.h,
                onPressed: selected.length < 5
                    ? null
                    : () {
                        push(context, const FollowPeopleScreen());
                      },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> get topics => [
        'Inspiration',
        'Love',
        'Peace',
        'Relationship',
        'Encouragement',
        'Prayer',
        'Validation',
        'Career',
        'Anxiety',
        'Rejection',
        'Praise',
        'Purpose',
        'Healing',
        'Money',
        'Self Control',
        'Fasting',
        'Joy',
        'Righteousness',
        'Breakthrough',
      ];
}
