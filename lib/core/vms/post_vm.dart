import 'package:hexcelon/core/apis/post_api.dart';

import '../models/error_util.dart';
import '../models/post_model.dart';
import 'base_vm.dart';

class PostViewModel extends BaseModel {
  final PostApi _api = locator<PostApi>();
  String? error;

  Future<void> create(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      Post res = await _api.create(a);

      print(res);
      setBusy(false);
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }
}
