import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcelon/views/home/main_layout.dart';

import '../../views/auth/follow_topics_view.dart';
import '../../views/auth/otp_view.dart';
import '../../views/widgets/hex_text.dart';
import '../apis/auth_api.dart';
import '../models/category_model.dart';
import 'base_vm.dart';

class AuthViewModel extends BaseModel {
  final AuthApi _api = locator<AuthApi>();
  String? error;

  LoginResponse? loginResponse;
  void setLoginResponse(LoginResponse e) {
    loginResponse = e;
    notifyListeners();
  }

  Future<void> signup(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      LoginResponse res = await _api.signup(a);
      vmContext.read<AuthViewModel>().setLoginResponse(res);
      push(vmContext, const OTPScreen());
      showVMSnackbar('Verify your account');
      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<void> verify(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _api.verify(a);
      LoginResponse? user = vmContext.read<AuthViewModel>().loginResponse;
      user?.user?.verificationStatus = true;
      AppCache.setUser(user!);
      pushAndRemoveUntil(vmContext, const MainLayout());
      push(vmContext, const FollowTopicsScreen());
      showVMSnackbar('Account has been verified successfully');
      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<void> resendOTP(String? id) async {
    setBusy(true);
    try {
      await _api.resendOTP(id);
      showVMSnackbar('OTP resent successfully, Check your email');
      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  List<Category>? categories;
  Future<void> getCategories() async {
    setBusy(true);
    try {
      categories = await _api.getCategories();

      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  List<UserModel>? creators;
  Future<void> getCreators() async {
    setBusy(true);
    try {
      creators = await _api.getCreators();
      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<void> login(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      LoginResponse res = await _api.login(a);
      if (!res.user!.verificationStatus!) {
        await resendOTP(res.user!.email);
        vmContext.read<AuthViewModel>().setLoginResponse(res);
        push(vmContext, const OTPScreen());
      } else {
        AppCache.setUser(res);
        pushAndRemoveUntil(vmContext, const MainLayout());
      }
      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<void> forgotPassword(String? email, {bool refresh = false}) async {
    setBusy(true);
    try {
      await _api.forgotPassword(email);
      if (refresh) {
        showVMSnackbar('Reset OTP resent successfully');
      } else {
        push(vmContext, OTPScreen(email: email));
      }
      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<bool> resetPassword(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _api.resetPassword(a);
      setBusy(false);
      return true;
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> changePassword(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _api.changePassword(a);
      setBusy(false);
      return true;
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> update(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      UserModel m = await _api.update(a);
      LoginResponse? user = AppCache.getUser();
      user?.user = m;
      AppCache.setUser(user!);
      setBusy(false);
      showVMSnackbar('Profile has been updated');

      return true;
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> follow(String? a) async {
    setBusy(true);
    try {
      await _api.follow(a);
      setBusy(false);
      return true;
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<String?> uploadMedia(File image) async {
    setBusy(true);
    try {
      String? link = await _api.uploadMedia(image);
      LoginResponse? user = AppCache.getUser();
      user?.user?.image = link;
      AppCache.setUser(user!);
      setBusy(false);
      return link;
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return null;
    }
  }

  Future<void> signInWithGoogle() async {
    setBusy(true);
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        Map<String, dynamic> data = {
          "googleId": googleSignInAccount.id,
          "username": googleSignInAccount.displayName ?? '',
          "email": googleSignInAccount.email,
          "picture": googleSignInAccount.photoUrl,
        };
        socialSignup(data);
      } else {
        setBusy(false);
        showVMSnackbar('Choose an account', err: true);
      }
    } on PlatformException catch (e) {
      setBusy(false);
      print(e);
      showVMSnackbar(e.message!, err: true);
    } on ZoperException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      setBusy(false);
    } catch (e) {
      setBusy(false);
      showVMSnackbar(e.toString(), err: true);
    }
  }

  Future<void> socialSignup(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      LoginResponse res = await _api.social(a);

      AppCache.setUser(res);
      pushAndRemoveUntil(vmContext, const MainLayout());
      if (res.user!.categories!.isEmpty) {
        push(vmContext, const FollowTopicsScreen());
      }
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return null;
    }
  }
}
