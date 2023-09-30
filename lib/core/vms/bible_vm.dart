import 'package:device_info/device_info.dart';
import 'package:hexcelon/core/vms/settings_vm.dart';
import 'package:hexcelon/views/widgets/hex_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:watcher/watcher.dart';

import '../apis/bible_api.dart';
import '../models/bible_model.dart';
import '../models/error_util.dart';
import 'base_vm.dart';

class BibleViewModel extends BaseModel {
  final BibleApi _api = locator<BibleApi>();
  String? error;

  late String localPath;
  StreamSubscription? eventWatcher;

  Future<String> get devicePath async =>
      (await getApplicationDocumentsDirectory()).path;

  List<String> downloaded = [];
  @override
  void dispose() {
    eventWatcher?.cancel();
    super.dispose();
  }

  Future watchBibles() async {
    String path = await devicePath;
    final Directory savedDir = Directory('$path/Bibles');
    final bool dirExists = await savedDir.exists();
    if (false) {
      if (dirExists) savedDir.deleteSync(recursive: true);
      AppCache.setDefaultBible(null);
    }
    if (!dirExists) savedDir.create();
    eventWatcher = DirectoryWatcher(savedDir.path).events.listen((we) {
      if (we.type == ChangeType.ADD) {
        downloaded.add(we.path.split('/').last);
      } else if (we.type == ChangeType.REMOVE) {
        downloaded.remove(we.path.split('/').last);
      }
      downloaded = downloaded.toSet().toList();
      setBusy(false);
    });
    for (var e in savedDir.listSync()) {
      String abbr = e.path.split('/').last;
      if (e.statSync().size < (AppCache.getBibleWeights()[abbr] ?? 0) ||
          e.statSync().size == 0) {
        await e.delete();
      }
    }
    downloaded =
        savedDir.listSync().map((e) => e.path.split('/').last).toList();
    if (downloaded.isEmpty) {
      Version v = Utils.allVersions().firstWhere((e) => e.abbr == 'kjv');
      Map<String, int> present = settingsVM.currentDownloads;
      present.update(v.abbr!, (a) => 0, ifAbsent: () => 0);
      downloadBible(v);
    }

    setBusy(false);
  }

  Future<void> _prepareSaveDir(String? abbr) async {
    String path = await devicePath;
    localPath = '$path/Bibles/$abbr';
    final File savedFile = File(localPath);
    final bool fileExists = await savedFile.exists();
    if (!fileExists) savedFile.create();
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (int.parse(androidInfo.version.release) > 12) {
        return true;
      }
      final PermissionStatus status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final PermissionStatus result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    }
    return false;
  }

  Future<void> downloadBible(Version v) async {
    await _prepareSaveDir(v.abbr);
    bool val = await _checkPermission();
    if (!val) {
      showVMSnackbar('No permission to download on device', err: true);
      return;
    }
    setBusy(true);
    try {
      await _api.downloadBible(v.url!, localPath);
      setBusy(false);
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }
}
