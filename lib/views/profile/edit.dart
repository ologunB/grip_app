import 'package:image_picker/image_picker.dart';

import '../widgets/hex_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.offKeyboard();
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBG,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(25.h),
          color: AppColors.primaryBG,
          child: HexButton(
            'Update',
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
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset('cover'.png),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: -57.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 57.h,
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(73.h),
                                child: Image.asset(
                                  'placeholder'.png,
                                  height: 107.h,
                                  width: 107.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SafeArea(child: BackButton(color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 10.h, top: MediaQuery.of(context).padding.top),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
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
                              return const SelectPhoto();
                            },
                          );
                        },
                        icon: Image.asset('edit'.png, height: 33.h),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 64.h),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
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
                        return const SelectPhoto();
                      });
                },
                child: HexText(
                  'Change Picture',
                  fontSize: 12.sp,
                  align: TextAlign.center,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 21.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: HexField(
                  labelText: 'Username',
                  hintText: 'Username',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: name,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: HexField(
                  labelText: 'Email Address',
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: email,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: HexField(
                  labelText: 'Phone Number',
                  hintText: 'Phone Number',
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  controller: phone,
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

class SelectPhoto extends StatelessWidget {
  const SelectPhoto({super.key, this.title});

  final String? title;
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.h),
      physics: const ClampingScrollPhysics(),
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: HexText(
                title ?? 'Select a Photo',
                fontSize: 14.sp,
                align: TextAlign.center,
                color: AppColors.black,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
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
          ],
        ),
        SizedBox(height: 20.h),
        Divider(
          height: 0.h,
          thickness: 1.h,
          color: const Color(0xffE6E6E6),
        ),
        InkWell(
          onTap: () async {
            final XFile? image =
                await picker.pickImage(source: ImageSource.camera);
            if (image != null) Navigator.pop(context, image);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: HexText(
              'Take a Photo',
              fontSize: 14.sp,
              align: TextAlign.center,
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Divider(
          height: 0.h,
          thickness: 1.h,
          color: const Color(0xffE6E6E6),
        ),
        InkWell(
          onTap: () async {
            final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
            if (image != null) Navigator.pop(context, image);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: HexText(
              'Choose from Gallery',
              fontSize: 14.sp,
              align: TextAlign.center,
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        HexButton(
          'Cancel',
          buttonColor: AppColors.white,
          height: 55,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.red,
          borderColor: AppColors.grey,
          borderRadius: 10.h,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
