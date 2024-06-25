import '../../core/models/bible_model.dart';
import '../../core/storage/local_storage.dart';
import '../../core/vms/bible_vm.dart';
import '../../core/vms/settings_vm.dart';
import '../../main.dart';
import '../profile/all_versions.dart';
import '../widgets/hex_text.dart';

class AllVersionScreen extends StatefulWidget {
  const AllVersionScreen({super.key});

  @override
  State<AllVersionScreen> createState() => _AllVersionScreenState();
}

class _AllVersionScreenState extends State<AllVersionScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BibleViewModel>(
      onModelReady: (a) => a.watchBibles(),
      dispose: (a) => a.dispose(),
      builder: (_, BibleViewModel model, __) => Scaffold(
        backgroundColor: context.bgColor,
        appBar: AppBar(
          backgroundColor: context.bgColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: context.primary),
          title: HexText(
            'Bibles',
            fontSize: 20.sp,
            color: context.textColor,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
        body: ListView.separated(
          separatorBuilder: (_, __) => Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Divider(
              height: 0.h,
              thickness: 1.h,
              color: const Color(0xffE6E6E6),
            ),
          ),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 15.h),
          itemCount: Utils.allVersions().length,
          itemBuilder: (c, i) {
            Version v = Utils.allVersions()[i];
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HexText(
                        v.abbr!.toUpperCase(),
                        style: AppThemes.bibleTitle
                            .copyWith(color: context.textColor),
                      ),
                      SizedBox(height: 8.h),
                      HexText(
                        v.name!.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: AppThemes.bibleVersionText
                            .copyWith(color: context.textColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.h),
                DownloadButton(
                  v: v,
                  model: model,
                  onTap: () {
                    if (!model.downloaded.contains(v.abbr)) {
                      Map<String, int> present = settingsVM.currentDownloads;
                      present.update(v.abbr!, (a) => 0, ifAbsent: () => 0);
                      model.downloadBible(v);
                    } else {
                      AppCache.setDefaultBible(v.abbr);
                    }
                    navigatorKeys[1]
                        .currentState!
                        .popUntil((route) => route.isFirst);

                    setState(() {});
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
