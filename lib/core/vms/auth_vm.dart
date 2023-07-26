import '../../views/widgets/hex_text.dart';
import '../apis/auth_api.dart';
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
      //   push(vmContext, const VerifyPhoneScreen());
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
      LoginResponse res = await _api.verify(a);
      vmContext.read<AuthViewModel>().setLoginResponse(res);
      LoginResponse user = LoginResponse();
      user.tokens = res.tokens;
      AppCache.setUser(user);
      //  push(vmContext, const CreatePinScreen());
      showVMSnackbar('Account has been verified successfully, Create a PIN');
      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<LoginResponse?> resendOTP(String? id) async {
    setBusy(true);
    try {
      LoginResponse a = await _api.resendOTP(id);
      vmContext.read<AuthViewModel>().setLoginResponse(a);
      showVMSnackbar('OTP resent successfully, Check your phone');
      setBusy(false);
      return a;
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return null;
    }
  }

  Future<void> login(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      LoginResponse res = await _api.login(a);
      LoginResponse user = LoginResponse();
      user.tokens = res.tokens;
      AppCache.setUser(user);
      if (!res.user!.isPhoneVerified!) {
        await resendOTP(res.user!.id);
        //     push(vmContext, const VerifyPhoneScreen());
        showVMSnackbar('Verify your account');
      } else if (!res.user!.isTransactionPinSet!) {
        vmContext.read<AuthViewModel>().setLoginResponse(res);
        //   push(vmContext, const CreatePinScreen());
        showVMSnackbar('Create your PIN');
      } else {
        AppCache.setUser(res);

        //   pushAndRemoveUntil(vmContext, const MainLayout());
      }
      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<String?> generateResetPassword(String a,
      {bool refresh = false}) async {
    setBusy(true);
    try {
      String token = await _api.generateResetPassword(a);
      if (refresh) {
        showVMSnackbar('Reset OTP resent successfully');
      } else {
        //    push(vmContext, VerifyForgotPassView(token: token, phone: a));
      }
      setBusy(false);
      return token;
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return null;
    }
  }

  Future<void> resetPassword(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _api.resetPassword(a);
      //  pushAndRemoveUntil(vmContext, const LoginScreen());
      showVMSnackbar('Password reset successfully, Login now');
      setBusy(false);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  // KYC

  Future<String?> uploadMedia(File image) async {
    setBusy(true);
    try {
      String link = await _api.uploadMedia(image);
      return link;
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return null;
    }
  }

  Future<void> signInWithGoogle(BuildContext buildContext) async {
    setBusy(true);
    try {
/*      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: scopes);
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      print(3);
      if (googleSignInAccount != null) {
        List<String> list = googleSignInAccount.displayName!.split(' ');
        Map<String, dynamic> data = {
          "firstName": list.first,
          "lastName": list.length > 1 ? list[1] : '',
          "email": googleSignInAccount.email,
          "picture": googleSignInAccount.photoUrl,
        };
        print(data);
      } else {
        showVMSnackbar('Choose an account', err: true);
      }
      setBusy(false);*/
    } on PlatformException catch (e) {
      setBusy(false);
      showVMSnackbar(e.message!, err: true);
    } on ZoperException catch (e) {
      error = e.message;
      setBusy(false);
    } catch (e) {
      setBusy(false);
      showVMSnackbar(e.toString(), err: true);
    }
  }
}
