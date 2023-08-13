import '../../core/vms/auth_vm.dart';
import '../profile/edit.dart';
import '../widgets/hex_text.dart';
import 'book.dart';
import 'verses.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController book = TextEditingController();
  TextEditingController chapter = TextEditingController();
  TextEditingController verse = TextEditingController();
  TextEditingController desc = TextEditingController();
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      builder: (_, AuthViewModel model, __) => Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.primary),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.h),
          child: HexButton(
            'Publish Post',
            buttonColor: AppColors.primary,
            height: 55,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            borderColor: AppColors.primary,
            borderRadius: 20.h,
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.h),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 60.h),
              IntrinsicHeight(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.h),
                      child: Image.asset(
                        'placeholder'.png,
                        height: 210.h,
                        width: 150.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(13.h),
                      child: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () async {},
                              borderRadius: BorderRadius.circular(20.h),
                              child: Container(
                                width: 68.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.h),
                                  color: AppColors.grey,
                                ),
                                child: HexText(
                                  'Preview',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                dynamic a = await showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context, useRootNavigator: true,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50.h),
                                      topLeft: Radius.circular(50.h),
                                    ),
                                  ),
                                  builder: (c) {
                                    return const SelectPhoto(
                                      title: 'Upload cover photo',
                                    );
                                  },
                                );
                                if (a != null) {}
                              },
                              borderRadius: BorderRadius.circular(20.h),
                              child: Container(
                                width: 68.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.h),
                                  color: AppColors.grey,
                                ),
                                child: HexText(
                                  'Edit',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              HexField(
                labelText: 'Add a title',
                hintText: 'Add a title',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: title,
              ),
              SizedBox(height: 27.h),
              Row(
                children: [
                  Image.asset('categories'.png, height: 24.h),
                  SizedBox(width: 10.h),
                  HexText(
                    'Select Categories (Post topics)',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  const Spacer(),
                  Image.asset('down'.png, height: 24.h),
                ],
              ),
              SizedBox(height: 15.h),
              Wrap(
                spacing: 5.h,
                runSpacing: 10.h,
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
                          height: 45.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: contains ? 10.h : 22.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.h),
                            border: Border.all(
                              width: 1.h,
                              color: contains
                                  ? AppColors.black
                                  : const Color(0xff868686),
                            ),
                            color: !contains
                                ? Colors.transparent
                                : AppColors.black,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  HexText(
                                    e,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: contains
                                        ? Colors.white
                                        : const Color(0xff868686),
                                    align: TextAlign.center,
                                  ),
                                  if (contains)
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.h),
                                      child: Image.asset(
                                        'mark'.png,
                                        height: 16.h,
                                      ),
                                    )
                                ],
                              )
                            ],
                          )),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 17.h),
              HexField(
                labelText: 'Description',
                hintText: 'Write something about your post',
                textInputType: TextInputType.text,
                maxLines: 5,
                textInputAction: TextInputAction.next,
                controller: desc,
                onTap: () {},
              ),
              SizedBox(height: 17.h),
              HexField(
                labelText: 'Scripture Reference (Optional)',
                hintText: 'Select bible book',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: book,
                readOnly: true,
                suffix: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12.h),
                      child: Image.asset('down'.png, height: 24.h),
                    )
                  ],
                ),
                onTap: () async {
                  dynamic a =
                      await push(context, const ChooseBookScreen(), true);
                  if (a != null) {
                    book.text = a[0];
                    chapter.text = a[1];
                    verse.text = a[2];
                    setState(() {});
                  }
                },
              ),
              SizedBox(height: 10.h),
              HexField(
                hintText: 'Select a book to show chapters',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: chapter,
                readOnly: true,
                suffix: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12.h),
                      child: Image.asset('down'.png, height: 24.h),
                    )
                  ],
                ),
                onTap: () async {
                  dynamic a = await push(
                      context,
                      book.text.isEmpty
                          ? const ChooseBookScreen()
                          : VersesScreen(
                              data: [book.text],
                              type: 'chapter',
                              popNumber: 2,
                            ),
                      true);
                  if (a != null) {
                    book.text = a[0];
                    chapter.text = a[1];
                    verse.text = a[2];
                    setState(() {});
                  }
                },
              ),
              SizedBox(height: 10.h),
              HexField(
                hintText: 'Select a chapter to show verse',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: verse,
                readOnly: true,
                onTap: () async {
                  dynamic a = await push(
                    context,
                    book.text.isEmpty
                        ? const ChooseBookScreen()
                        : chapter.text.isEmpty
                            ? VersesScreen(
                                data: [book.text],
                                type: 'chapter',
                                popNumber: 2,
                              )
                            : VersesScreen(
                                type: 'verse',
                                data: [book.text, chapter.text],
                                popNumber: 1,
                              ),
                    true,
                  );
                  if (a != null) {
                    book.text = a[0];
                    chapter.text = a[1];
                    verse.text = a[2];
                    setState(() {});
                  }
                },
                suffix: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12.h),
                      child: Image.asset('down'.png, height: 24.h),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> get topics => [
      'Inspiration',
      'Love',
      'Peace',
      'Fasting',
      'Relationship',
      'Encouragement',
      'Prayer',
      'Validation',
      'Joy',
      'Anxiety',
      'Rejection',
      'Praise',
      'Purpose',
      'Healing',
      'Money',
      'Self Control',
      'Righteousness',
      'Breakthrough',
      'Career',
    ];
