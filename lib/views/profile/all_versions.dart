import 'package:hexcelon/core/apis/base_api.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/models/bible_model.dart';
import '../../core/vms/bible_vm.dart';
import '../../core/vms/settings_vm.dart';
import '../../main.dart';
import '../widgets/hex_text.dart';

class AllVersionScreen extends StatefulWidget {
  const AllVersionScreen({super.key});

  @override
  State<AllVersionScreen> createState() => _AllVersionScreenState();
}

class _AllVersionScreenState extends State<AllVersionScreen> {
  StreamSubscription? bib;
  @override
  void initState() {
    bib = settingsVM.outMainBible.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    bib?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BibleViewModel>(
      onModelReady: (a) => a.watchBibles(),
      dispose: (a) => a.dispose(),
      builder: (_, BibleViewModel model, __) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
                  child: Row(
                    children: [
                      ModalRoute.of(context)?.settings.arguments == true
                          ? const CloseButton(color: Colors.black)
                          : const BackButton(color: Colors.black),
                      HexText(
                        'Bible',
                        fontSize: 28.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  )),
              Expanded(
                child: ListView.separated(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.h, vertical: 15.h),
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
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 8.h),
                              HexText(
                                v.name!.toUpperCase(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14.sp,
                                color: AppColors.black,
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
                              Map<String, int> present =
                                  settingsVM.currentDownloads;
                              present.update(v.abbr!, (a) => 0,
                                  ifAbsent: () => 0);
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
            ],
          ),
        ),
      ),
    );
  }
}

class DownloadButton extends StatefulWidget {
  const DownloadButton(
      {super.key, required this.v, required this.model, required this.onTap});

  final Version v;
  final BibleViewModel model;
  final Function() onTap;
  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  late Version v;
  @override
  void initState() {
    v = widget.v;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, int>>(
      stream: settingsVM.outMainDownloads,
      initialData: settingsVM.currentDownloads,
      builder: (context, snapshot) {
        bool isDownload = widget.model.downloaded.contains(v.abbr);
        bool isDownloading = snapshot.data?.keys.contains(v.abbr) ?? false;
        bool isChosen = AppCache.getDefaultBible() == v.abbr;
        return isDownloading
            ? Padding(
                padding: EdgeInsets.only(right: 8.h),
                child: CircularPercentIndicator(
                  radius: 15.h,
                  lineWidth: 2.h,
                  percent: snapshot.data![v.abbr]! / 100,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: HexText(
                    '${snapshot.data?[v.abbr]}%',
                    fontSize: 12.sp,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    align: TextAlign.center,
                  ),
                  progressColor: AppColors.secondary,
                ),
              )
            : TextButton(
                onPressed: isChosen && isDownload ? null : widget.onTap,
                child: Row(
                  children: [
                    if (isChosen && isDownload)
                      Icon(
                        Icons.check_rounded,
                        color: Colors.green,
                        size: 24.h,
                      ),
                    SizedBox(width: 8.h),
                    HexText(
                      !isDownload
                          ? 'Download'
                          : !isChosen
                              ? 'Choose'
                              : 'Chosen',
                      fontSize: 16.sp,
                      color: isChosen && isDownload
                          ? Colors.green
                          : AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      align: TextAlign.center,
                    ),
                  ],
                ),
              );
      },
    );
  }
}
