import '../vms/settings_vm.dart';
import 'base_api.dart';

class BibleApi extends BaseAPI {
  Future<bool> downloadBible(String url, String path) async {
    try {
      final Response res = await Dio().download(
        url,
        path,
        options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
        onReceiveProgress: (a, b) {
          String abbr = url.split('/').last.split('.').first;
          Map<String, int> present = settingsVM.currentDownloads;
          int percent = ((a / b) * 100).floor();
          present.update(abbr, (a) => percent, ifAbsent: () => percent);
          settingsVM.currentDownloads = present;
          if (percent > 98) present.remove(abbr);
          if (percent % 10 == 0) print('$abbr is $percent%');
        },
      );

      switch (res.statusCode) {
        case 200:
          return true;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }
}
