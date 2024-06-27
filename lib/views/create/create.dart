import 'package:hexcelon/views/widgets/grip_divider.dart';

import '../../core/models/category_model.dart';
import '../../core/models/post_model.dart';
import '../../core/vms/auth_vm.dart';
import '../../core/vms/post_vm.dart';
import '../profile/edit.dart';
import '../widgets/hex_text.dart';
import '../widgets/retry_widget.dart';
import 'book.dart';
import 'verses.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen(
      {super.key, this.file, this.type = 'image', this.post});
  final Uint8List? file;
  final String type;
  final Post? post;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController book = TextEditingController();
  TextEditingController chapter = TextEditingController();
  TextEditingController verse = TextEditingController();
  TextEditingController desc = TextEditingController();
  List<Category> categories = [];
  File? coverPic;
  bool hideCategories = false;
  Post? post;

  @override
  void initState() {
    post = widget.post;
    if (post != null) {
      title = TextEditingController(text: post?.title);
      book = TextEditingController(text: post?.bibleBook);
      chapter = TextEditingController(text: post?.bibleChapter);
      verse = TextEditingController(text: post?.bibleVerse);
      desc = TextEditingController(text: post?.description);
      categories = post?.categories ?? [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      onModelReady: (m) => m.getCategories(),
      builder: (_, AuthViewModel aModel, __) => BaseView<PostViewModel>(
        builder: (_, PostViewModel pModel, __) => GestureDetector(
          onTap: Utils.offKeyboard,
          child: Scaffold(
            backgroundColor: context.bgColor,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: context.bgColor,
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.secondary),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.h),
              child: HexButton(
                post != null ? 'Update Post' : 'Publish Post',
                buttonColor: AppColors.secondary,
                height: 48,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                borderRadius: 10.h,
                busy: pModel.busy,
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

                  if (post != null) {
                    Navigator.pop(context, {
                      "title": title.text,
                      "bible_book": book.text,
                      "bible_chapter": chapter.text,
                      "bible_verse": verse.text,
                      "description": desc.text
                    });
                    return;
                  }

                  if (coverPic == null) {
                    errorSnackBar(context, 'Select a cover picture');
                    return;
                  }
                  Map<String, dynamic> data = {
                    'file_type': widget.type,
                    'title': title.text,
                    'description': desc.text,
                    'category': categories.map((e) => e.toJson()),
                    if (book.text.isNotEmpty) 'bible_book': book.text,
                    if (chapter.text.isNotEmpty) 'bible_chapter': chapter.text,
                    if (verse.text.isNotEmpty) 'bible_verse': verse.text,
                  };
                  bool a =
                      await pModel.createPost(data, [widget.file!, coverPic!]);
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
                  if (post == null)
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
                                          backgroundColor: context.sheetBG,
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
                                            return PreviewPhoto(
                                                file: coverPic!);
                                          },
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(20.h),
                                      child: Container(
                                        width: 70.h,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.h),
                                          color: AppColors.grey2,
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
                                        backgroundColor: context.sheetBG,
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                        color: AppColors.grey2,
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
                    onTap: () =>
                        setState(() => hideCategories = !hideCategories),
                    borderRadius: BorderRadius.circular(6.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        children: [
                          Image.asset(
                            'categories'.png,
                            height: 24.h,
                            color: context.primary,
                          ),
                          SizedBox(width: 10.h),
                          HexText(
                            'Select Categories (Post topics)',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: context.primary,
                          ),
                          const Spacer(),
                          RotatedBox(
                            quarterTurns: !hideCategories ? 2 : 0,
                            child: Image.asset(
                              'down'.png,
                              height: 24.h,
                              color: context.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  hideCategories
                      ? HexText(
                          categories
                              .map((e) => e.name?.toTitleCase())
                              .join(', '),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: context.textColor,
                        )
                      : aModel.busy
                          ? const Center(child: HexProgress())
                          : aModel.categories == null
                              ? RetryItem(
                                  onTap: () {
                                    aModel.getCategories();
                                  },
                                )
                              : Wrap(
                                  spacing: 5.h,
                                  runSpacing: 10.h,
                                  children: aModel.categories!.map(
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
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                        child: Container(
                                          height: 50.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.h),
                                            border: Border.all(
                                                width: 1.h,
                                                color: contains
                                                    ? AppColors.primary
                                                    : (context.isLight
                                                        ? AppColors.darkGrey
                                                        : AppColors.grey2)),
                                            color: !contains
                                                ? Colors.transparent
                                                : AppColors.secondary,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  HexText(
                                                    '#${e.name?.toTitleCase()}',
                                                    style: AppThemes.pillText
                                                        .copyWith(
                                                      color: contains
                                                          ? AppColors.white
                                                          : (context.isLight
                                                              ? AppColors.black
                                                              : const Color(
                                                                  0xff868686)),
                                                    ),
                                                    align: TextAlign.center,
                                                  ),
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
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 13.h, bottom: 7.h),
                        child: HexText(
                          'Scripture Reference (Optional)',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: context.primary,
                        ),
                      ),
                      const Spacer(),
                      if (book.text.isNotEmpty)
                        CupertinoButton(
                            child: HexText(
                              'Clear',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey2,
                            ),
                            onPressed: () {
                              book.clear();
                              chapter.clear();
                              verse.clear();
                              setState(() {});
                            }),
                    ],
                  ),
                  HexField(
                    hintText: 'Select bible book',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: book,
                    readOnly: true,
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 12.h),
                          child: Image.asset(
                            'down'.png,
                            height: 24.h,
                            color: context.primary,
                          ),
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
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 12.h),
                          child: Image.asset(
                            'down'.png,
                            height: 24.h,
                            color: context.primary,
                          ),
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
                                  value: Utils.allBooks[book.text],
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
                                    value: Utils.allBooks[book.text],
                                  )
                                : VersesScreen(
                                    type: 'verse',
                                    data: [book.text, chapter.text],
                                    value: Utils.allBooks[book.text],
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
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 12.h),
                          child: Image.asset(
                            'down'.png,
                            height: 24.h,
                            color: context.primary,
                          ),
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
      ),
    );
  }
}

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
                  color: context.textColor,
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
                    color: context.textColor,
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
