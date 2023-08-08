import 'package:hexcelon/core/apis/base_api.dart';
import 'package:hexcelon/views/widgets/user_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/models/login_model.dart';
import '../../core/vms/auth_vm.dart';
import '../auth/follow_topics_view.dart';
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
  TextEditingController category = TextEditingController();
  List<String> selected = [];
  File? file;
  String? imageUrl;

  @override
  void initState() {
    UserModel? user = AppCache.getUser()?.user;
    phone = TextEditingController(text: user?.phone);
    email = TextEditingController(text: user?.email);
    name = TextEditingController(text: user?.username);
    selected = user?.categories?.map((e) => e.name!).toList() ?? [];
    category = TextEditingController(text: selected.join(', '));
    imageUrl = user?.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Utils.offKeyboard,
      child: BaseView<AuthViewModel>(
        builder: (_, AuthViewModel model, __) => Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(25.h),
            color: Colors.white,
            child: HexButton(
              'Update',
              buttonColor: AppColors.black,
              height: 60,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              textColor: AppColors.white,
              borderColor: Colors.transparent,
              borderRadius: 10.h,
              busy: model.busy,
              onPressed: () {
                model.update({
                  "username": name.text,
                  "phone": phone.text,
                  "category": selected
                });
              },
            ),
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: AppColors.primary),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UserImage(
                    size: 107.h,
                    radius: 107.h,
                    imageUrl: imageUrl,
                    file: file,
                  ),
                  SizedBox(height: 8.h),
                  if (!model.busy)
                    InkWell(
                      onTap: () async {
                        if (file != null) {
                          String? a = await model.uploadMedia(file!);
                          file = null;
                          imageUrl = a;
                          setState(() {});
                        } else {
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
                                return const SelectPhoto();
                              });
                          if (a != null) {
                            file = File(a);
                            setState(() {});
                          }
                        }
                      },
                      child: HexText(
                        file != null ? 'Confirm' : 'Change Picture',
                        fontSize: 14.sp,
                        align: TextAlign.center,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
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
                      readOnly: true,
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
                      maxLength: 11,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h),
                    child: HexField(
                      labelText: 'Category',
                      hintText: 'Choose Category',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: category,
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.primary,
                            size: 24.h,
                          )
                        ],
                      ),
                      readOnly: true,
                      onTap: () async {
                        dynamic a = await push(context,
                            FollowTopicsScreen(previous: selected), true);
                        if (a != null) {
                          selected = a;
                          category =
                              TextEditingController(text: selected.join(', '));
                          setState(() {});
                        }
                      },
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
            if (image != null) {
              Navigator.pop(context, image.path);
            }
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
            if (image != null) Navigator.pop(context, image.path);
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
