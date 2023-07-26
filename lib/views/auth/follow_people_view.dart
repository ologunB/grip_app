import '../home/main_layout.dart';
import '../widgets/hex_text.dart';

class FollowPeopleScreen extends StatefulWidget {
  const FollowPeopleScreen({super.key});

  @override
  State<FollowPeopleScreen> createState() => _FollowPeopleScreenState();
}

class _FollowPeopleScreenState extends State<FollowPeopleScreen> {
  List<int> selected = [];
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
                'Select some people you would like\nto see on your feed',
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
                  child: ListView.separated(
                    separatorBuilder: (_, __) => SizedBox(height: 20.h),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 20.h),
                    itemCount: 10,
                    itemBuilder: (c, i) {
                      bool contains = selected.contains(i);
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 30.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.h),
                              child: Image.asset('placeholder'.png),
                            ),
                          ),
                          SizedBox(width: 18.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HexText(
                                'Pastor Tobe',
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 8.h),
                              HexText(
                                'Minister and lover of God',
                                fontSize: 12.sp,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(width: 8.h),
                          InkWell(
                            onTap: () {
                              if (contains) {
                                selected.remove(i);
                              } else {
                                selected.add(i);
                              }
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.h, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.h),
                                border: Border.all(
                                  width: 1.h,
                                  color: AppColors.black,
                                ),
                                color: !contains
                                    ? Colors.transparent
                                    : AppColors.primary,
                              ),
                              child: HexText(
                                contains ? 'Following' : 'Follow',
                                fontSize: 12.sp,
                                color:
                                    contains ? Colors.white : AppColors.black,
                                align: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      );
                    },
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
                onPressed: selected.isEmpty
                    ? null
                    : () {
                        pushAndRemoveUntil(context, const MainLayout());
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
