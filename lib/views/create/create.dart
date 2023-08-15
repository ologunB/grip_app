import 'package:hexcelon/views/widgets/grip_divider.dart';

import '../../core/vms/post_vm.dart';
import '../profile/edit.dart';
import '../widgets/hex_text.dart';
import 'book.dart';
import 'verses.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, this.file, this.type = 'image'});
  final Uint8List? file;
  final String type;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController book = TextEditingController();
  TextEditingController chapter = TextEditingController();
  TextEditingController verse = TextEditingController();
  TextEditingController desc = TextEditingController();
  List<String> categories = [];
  File? coverPic;
  bool hideCategories = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      builder: (_, PostViewModel model, __) => GestureDetector(
        onTap: Utils.offKeyboard,
        child: Scaffold(
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
              buttonColor: AppColors.black,
              height: 60,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              textColor: AppColors.white,
              borderColor: AppColors.black,
              borderRadius: 10.h,
              busy: model.busy,
              onPressed: () async {
                if (title.text.isEmpty) {
                  errorSnackBar(context, 'Title cannot be empty');
                  return;
                }
                if (categories.isEmpty) {
                  errorSnackBar(context, 'Select Categories');
                  return;
                }
                if (desc.text.isEmpty) {
                  errorSnackBar(context, 'Description cannot be empty');
                  return;
                }
                if (coverPic == null) {
                  errorSnackBar(context, 'Select a cover picture');
                  return;
                }
                if (book.text.isNotEmpty ||
                    chapter.text.isNotEmpty ||
                    verse.text.isNotEmpty) {
                  if (book.text.isEmpty) {
                    errorSnackBar(
                        context, 'Book cannot be empty if others are filled');
                    return;
                  }
                  if (chapter.text.isEmpty) {
                    errorSnackBar(context,
                        'Chapter cannot be empty if others are filled');
                    return;
                  }
                  if (verse.text.isEmpty) {
                    errorSnackBar(
                        context, 'Verse cannot be empty if others are filled');
                    return;
                  }
                }
                Map<String, dynamic> data = {
                  'file_type': widget.type,
                  'title': title.text,
                  'description': desc.text,
                  'category': categories.map((e) => e.toLowerCase()),
                  if (book.text.isNotEmpty) 'bible_book': book.text,
                  if (chapter.text.isNotEmpty) 'bible_chapter': chapter.text,
                  if (verse.text.isNotEmpty) 'bible_verse': verse.text,
                };
                bool a = await model.create(data, [widget.file!, coverPic!]);
                if (a) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  successSnackBar(context, 'Post created successfully');
                }
              },
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
                        child: coverPic != null
                            ? Image.file(
                                coverPic!,
                                height: 210.h,
                                width: 150.h,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
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
                              if (coverPic != null)
                                InkWell(
                                  onTap: () async {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      context: context,
                                      useRootNavigator: true,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(50.h),
                                          topLeft: Radius.circular(50.h),
                                        ),
                                      ),
                                      builder: (c) {
                                        return PreviewPhoto(file: coverPic!);
                                      },
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(20.h),
                                  child: Container(
                                    width: 70.h,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
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
                                    context: context,
                                    useRootNavigator: true,
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
                                  if (a != null) {
                                    coverPic = File(a);
                                    setState(() {});
                                  }
                                },
                                borderRadius: BorderRadius.circular(20.h),
                                child: Container(
                                  width: 70.h,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.h),
                                    color: AppColors.grey,
                                  ),
                                  child: HexText(
                                    coverPic == null ? 'Choose' : 'Edit',
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
                SizedBox(height: 22.h),
                InkWell(
                  onTap: () => setState(() => hideCategories = !hideCategories),
                  borderRadius: BorderRadius.circular(6.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Row(
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
                        RotatedBox(
                          quarterTurns: !hideCategories ? 2 : 0,
                          child: Image.asset('down'.png, height: 24.h),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                hideCategories
                    ? HexText(
                        categories.join(', '),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      )
                    : Wrap(
                        spacing: 5.h,
                        runSpacing: 10.h,
                        children: topics.map(
                          (e) {
                            bool contains = categories.contains(e);
                            return InkWell(
                              onTap: () {
                                if (contains) {
                                  categories.remove(e);
                                } else {
                                  categories.add(e);
                                }
                                setState(() {});
                              },
                              borderRadius: BorderRadius.circular(6.h),
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
                                          fontWeight: FontWeight.w500,
                                          color: contains
                                              ? Colors.white
                                              : const Color(0xff868686),
                                          align: TextAlign.center,
                                        ),
                                        if (contains)
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.h),
                                            child: Image.asset(
                                              'mark'.png,
                                              height: 16.h,
                                            ),
                                          )
                                      ],
                                    )
                                  ],
                                ),
                              ),
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

class PreviewPhoto extends StatelessWidget {
  const PreviewPhoto({super.key, required this.file});

  final File file;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50.h),
        topLeft: Radius.circular(50.h),
      ),
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .9),
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
              children: [
                SizedBox(height: 20.h),
                const GripDivider(),
                Image.file(
                  file,
                  width: MediaQuery.of(context).size.width,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Align(
                alignment: Alignment.topCenter,
                child: HexText(
                  'Preview Photo',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  align: TextAlign.center,
                  color: AppColors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25.h, top: 20.h),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'close'.png,
                    height: 24.h,
                    width: 24.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
