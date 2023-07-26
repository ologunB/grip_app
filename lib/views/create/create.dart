import '../profile/edit.dart';
import '../widgets/hex_text.dart';
import 'book.dart';
import 'category.dart';
import 'verses.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController book = TextEditingController();
  TextEditingController chapter = TextEditingController();
  TextEditingController verse = TextEditingController();
  TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
            SizedBox(
              height: MediaQuery.of(context).padding.top + 36.h,
              width: 30,
            ),
            InkWell(
              onTap: () async {
                dynamic a = await showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.h),
                      topLeft: Radius.circular(50.h),
                    ),
                  ),
                  builder: (c) {
                    return const SelectPhoto(title: 'Upload cover photo');
                  },
                );
                if (a != null) {}
              },
              borderRadius: BorderRadius.circular(12.h),
              child: Image.asset('gallery'.png, height: 65.h),
            ),
            SizedBox(height: 8.h),
            HexText(
              'Select a Cover photo',
              fontSize: 14.sp,
              color: Colors.grey,
              align: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 50.h),
            HexField(
              labelText: 'Add a title',
              hintText: 'Add a title',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: title,
            ),
            SizedBox(height: 7.h),
            HexField(
              labelText: 'Categories (Post topics)',
              hintText: 'Select the related topic',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: category,
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
                List? a =
                    await push(context, const ChooseCategoryScreen(), true);
                if (a != null) {
                  category.text = a.join(', ');
                  setState(() {});
                }
              },
            ),
            SizedBox(height: 7.h),
            HexField(
              labelText: 'Scripture Reference',
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
                String? a = await push(context, const ChooseBookScreen(), true);
                if (a != null) {
                  book.text = a;
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
                String? a = await push(context, const VersesScreen(), true);
                if (a != null) {
                  chapter.text = a;
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
                String? a = await push(
                    context, const VersesScreen(type: 'verse'), true);
                if (a != null) {
                  verse.text = a;
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
            HexField(
              labelText: 'Description',
              hintText: 'Write something about your post',
              textInputType: TextInputType.text,
              maxLines: 5,
              textInputAction: TextInputAction.next,
              controller: desc,
              readOnly: true,
              onTap: () {},
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
