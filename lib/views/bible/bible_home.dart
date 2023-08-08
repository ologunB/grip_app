import '../../core/vms/settings_vm.dart';
import '../widgets/hex_text.dart';
import 'all_versions.dart';
import 'one_version.dart';

class BibleHome extends StatelessWidget {
  const BibleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: settingsVM.outMainBible,
      initialData: settingsVM.currentBible,
      builder: (context, snapshot) {
        return snapshot.data != null
            ? const OneVersionScreen()
            : const AllVersionScreen();
      },
    );
  }
}
