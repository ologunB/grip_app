import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcelon/views/home/main_layout.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../views/auth/follow_topics_view.dart';
import '../../views/auth/otp_view.dart';
import '../../views/widgets/hex_text.dart';
import '../apis/auth_api.dart';
import '../models/category_model.dart';
import '../models/error_util.dart';
import 'base_vm.dart';

class AuthViewModel extends BaseModel {
  final AuthApi _api = locator<AuthApi>();
  String? error;

  LoginModel? loginResponse;
  void setLoginResponse(LoginModel e) {
    loginResponse = e;
    notifyListeners();
  }

  Future<void> signup(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      LoginModel res = await _api.signup(a);
      vmContext.read<AuthViewModel>().setLoginResponse(res);
      push(vmContext, const OTPScreen());
      showVMSnackbar('Verify your account');
      setBusy(false);
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<void> verify(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _api.verify(a);
      LoginModel? user = vmContext.read<AuthViewModel>().loginResponse;
      user?.user?.verificationStatus = true;
      AppCache.setUser(user!);
      pushAndRemoveUntil(vmContext, const MainLayout());
      push(vmContext, const FollowTopicsScreen());
      showVMSnackbar('Account has been verified successfully');
      setBusy(false);
    } on GripException catch (e) {
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
    } on GripException catch (e) {
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
    } on GripException catch (e) {
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
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<void> login(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      LoginModel res = await _api.login(a);
      if (!res.user!.verificationStatus!) {
        await resendOTP(res.user!.email);
        vmContext.read<AuthViewModel>().setLoginResponse(res);
        push(vmContext, const OTPScreen());
      } else {
        AppCache.setUser(res);
        pushAndRemoveUntil(vmContext, const MainLayout());
      }
      setBusy(false);
    } on GripException catch (e) {
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
    } on GripException catch (e) {
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
    } on GripException catch (e) {
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
    } on GripException catch (e) {
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
      LoginModel? user = AppCache.getUser();
      user?.user = m;
      AppCache.setUser(user!);
      setBusy(false);
      showVMSnackbar('Profile has been updated');

      return true;
    } on GripException catch (e) {
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
    } on GripException catch (e) {
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
      LoginModel? user = AppCache.getUser();
      user?.user?.image = link;
      AppCache.setUser(user!);
      setBusy(false);
      return link;
    } on GripException catch (e) {
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
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      setBusy(false);
    } catch (e) {
      setBusy(false);
      showVMSnackbar(e.toString(), err: true);
    }
  }

  Future signInApple() async {
    if (!await TheAppleSignIn.isAvailable()) {
      return null;
    }

    final res = await TheAppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (res.status) {
      case AuthorizationStatus.authorized:
        //Get Token
        final AppleIdCredential? appleIdCredential = res.credential;

        dynamic decoded = JwtDecoder.tryDecode(
            String.fromCharCodes(appleIdCredential?.identityToken ?? []));
        Logger().d(decoded);

        final prefs = await SharedPreferences.getInstance();
        String? username = appleIdCredential?.fullName?.givenName;
        String? googleId = appleIdCredential?.fullName?.familyName;
        String? email = decoded['email'] ?? appleIdCredential?.email;
        if (email != null) {
          await prefs.setString('username', username ?? 'John');
          await prefs.setString('googleId', googleId ?? 'Doe');
          await prefs.setString('email', email);
        }

        Map<String, dynamic> data = {
          "username": username ?? prefs.getString('username') ?? '',
          "googleId": googleId ?? prefs.getString('googleId') ?? '',
          "email": email ?? prefs.getString('email') ?? '',
          "picture": '',
        };

        if (data['email'] == '' || data['email'] == null) {
          setBusy(false);
          showVMSnackbar('The operation could not be completed', err: true);
          break;
        }
        socialSignup(data);
        setBusy(false);

        break;
      case AuthorizationStatus.error:
        setBusy(false);
        showVMSnackbar(res.error?.localizedDescription ?? '', err: true);
        break;
      case AuthorizationStatus.cancelled:
        setBusy(false);
        showVMSnackbar('The operation could not be completed', err: true);

        break;
    }
  }

  Future<void> socialSignup(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      LoginModel res = await _api.social(a);

      AppCache.setUser(res);
      pushAndRemoveUntil(vmContext, const MainLayout());
      if (res.user!.categories!.isEmpty) {
        push(vmContext, const FollowTopicsScreen());
      }
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return null;
    }
  }
}
