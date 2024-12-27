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
  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    UserModel? user = AppCache.getUser()?.user;
    phone = TextEditingController(text: user?.phone);
    if (phone.text.isNotEmpty && phone.text.startsWith('0')) {
      phone.text = '+234${phone.text.substring(1)}';
    }
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
        builder: (_, AuthViewModel model, __) => Form(
          key: formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Scaffold(
            backgroundColor: context.bgColor,
            extendBodyBehindAppBar: true,
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(25.h),
              color: context.bgColor,
              child: HexButton(
                'Update',
                buttonColor: AppColors.secondary,
                height: 48,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                borderRadius: 10.h,
                busy: model.busy,
                onPressed: () {
                  autoValidate = true;
                  setState(() {});
                  if (!formKey.currentState!.validate()) return;
                  model.update({
                    "username": name.text.trim(),
                    "phone": phone.text.trim().replaceAll('+234', '0'),
                    "category": selected
                  });
                },
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: context.bgColor,
              iconTheme: IconThemeData(color: context.primary),
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
                            if (a == null) return;
                            file = null;
                            imageUrl = a;
                            if (mounted) setState(() {});
                          } else {
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
                          color: context.primary,
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
                        maxLength: 20,
                        validator: (a) {
                          return Utils.isValidName(a,
                              type: 'Username', length: 3);
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9_]')),
                        ],
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
                        maxLength: 15,
                        validator: (a) {
                          return Utils.isValidName(a, type: 'Phone', length: 8);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.h),
                      child: HexField(
                        labelText: 'Category',
                        hintText: 'Choose Category',
                        controller: category,
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: context.primary,
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
                            category = TextEditingController(
                                text: selected.join(', '));
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
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                align: TextAlign.center,
                color: context.textColor,
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
                  color: context.textColor,
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
            if (image != null) Navigator.pop(context, image.path);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: HexText(
              'Take a Photo',
              align: TextAlign.center,
              style: AppThemes.buttonText.copyWith(
                color: context.textColor,
              ),
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
              align: TextAlign.center,
              style: AppThemes.buttonText.copyWith(
                color: context.textColor,
              ),
            ),
          ),
        ),
        HexButton(
          'Cancel',
          buttonColor: AppColors.secondary,
          height: 48,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.white,
          borderRadius: 10.h,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
