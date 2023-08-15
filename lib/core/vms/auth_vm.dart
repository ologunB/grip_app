import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcelon/views/home/user_layout.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../views/auth/follow_topics_view.dart';
import '../../views/auth/otp_view.dart';
import '../../views/home/creator_layout.dart';
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
      pushAndRemoveUntil(
        vmContext,
        user.user?.role == 'user' ? const UserLayout() : const CreatorLayout(),
      );
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
        pushAndRemoveUntil(
          vmContext,
          res.user?.role == 'user' ? const UserLayout() : const CreatorLayout(),
        );
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
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> follow(int? a) async {
    setBusy(true);
    try {
      await _api.follow(a.toString());
      setBusy(false);
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> unfollow(int? a) async {
    setBusy(true);
    try {
      await _api.unfollow(a.toString());
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
          "image": googleSignInAccount.photoUrl,
        };
        socialSignup(data);
      } else {
        setBusy(false);
        showVMSnackbar('Choose an account', err: true);
      }
    } on PlatformException catch (e) {
      setBusy(false);
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
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (res.status) {
      case AuthorizationStatus.authorized:
        //Get Token
        final AppleIdCredential? appleIdCredential = res.credential;

        dynamic decoded = JwtDecoder.tryDecode(
            String.fromCharCodes(appleIdCredential?.identityToken ?? []));
        Logger().d(decoded);

        String? username = appleIdCredential?.fullName?.givenName;
        String? googleId = appleIdCredential?.fullName?.familyName;
        String? email = decoded['email'] ?? appleIdCredential?.email;
        if (email != null) {
          await AppCache.put('username', username ?? 'John');
          await AppCache.put('googleId', googleId ?? 'Doe');
          await AppCache.put('email', email);
        }

        Map<String, dynamic> data = {
          "username": username ?? AppCache.get('username'),
          "googleId": googleId ?? AppCache.get('googleId'),
          "email": email ?? AppCache.get('email'),
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
      pushAndRemoveUntil(
        vmContext,
        res.user?.role == 'user' ? const UserLayout() : const CreatorLayout(),
      );
      if (res.user!.categories!.isEmpty) {
        push(vmContext, const FollowTopicsScreen());
      }
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return;
    }
  }
}
