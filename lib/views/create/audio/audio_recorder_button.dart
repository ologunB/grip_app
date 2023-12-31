import 'package:permission_handler/permission_handler.dart';

import '../../create/create.dart';
import '../../widgets/hex_text.dart';
import 'audio_player.dart';
import 'utils.dart';

class AudioRecorderButton extends StatefulWidget {
  const AudioRecorderButton({super.key, this.onRecordComplete});
  final ValueChanged<String?>? onRecordComplete;

  @override
  State<AudioRecorderButton> createState() => _AudioRecorderButtonState();
}

class _AudioRecorderButtonState extends State<AudioRecorderButton> {
  final sampleTime = const Duration(milliseconds: 100);
  final animTime = const Duration(milliseconds: 200);
  Record record = Record();
  double waveHeight = 0;
  Timer? timer;
  bool get timerIsActive => timer?.isActive ?? false;
  Duration elapsedTime = const Duration();
  FancyRecorderState state = FancyRecorderState.start;
  Uri? audioUri;

  @override
  void initState() {
    if (audioUri != null) {
      state = FancyRecorderState.recorded;
    }
    record.onAmplitudeChanged(sampleTime).listen((amp) {
      if (mounted) setState(() => waveHeight = 40 * calculatedDB(amp.current));
    });

    record.onStateChanged().listen((state) {
      if (state == RecordState.stop && mounted) setState(() => waveHeight = 0);
    });
    _checkPermission();

    super.initState();
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    List<Permission> permissions = [
      Permission.microphone,
      Permission.storage,
    ];

    // Filter out the permissions that are already granted
    List<Permission> permissionsToRequest = [];

    for (Permission permission in permissions) {
      PermissionStatus status = await permission.status;
      if (!status.isGranted) {
        permissionsToRequest.add(permission);
      }
    }

    if (permissionsToRequest.isEmpty) {
      return true; // All permissions are already granted
    }

    // Request the remaining permissions
    Map<Permission, PermissionStatus> statuses =
        await permissionsToRequest.request();

    // Check if all newly requested permissions are granted
    bool allGranted = statuses.values.every((status) => status.isGranted);

    return allGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              alignment: state == FancyRecorderState.recorded ||
                      state == FancyRecorderState.start
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  child: state == FancyRecorderState.recorded
                      ? Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: AudioSlidePlayer(path: audioUri!.path),
                        )
                      : const SizedBox(),
                ),
                Card(
                  margin: const EdgeInsets.only(left: 20),
                  clipBehavior: Clip.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 200),
                    padding: state == FancyRecorderState.recording
                        ? const EdgeInsets.fromLTRB(60, 16, 16, 16)
                        : const EdgeInsets.symmetric(vertical: 16),
                    child: Text(timerIsActive
                        ? '${formatDuration(elapsedTime)} - ${formatDuration(const Duration(minutes: 3))}'
                        : ''),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  fit: StackFit.loose,
                  children: [
                    AnimatedContainer(
                      duration: sampleTime,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                          shape: BoxShape.circle),
                      height: 60 + waveHeight,
                      width: 60 + waveHeight,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          minimumSize: const Size(0, 60)),
                      onPressed: _toggleRecord,
                      child: Icon(
                        _switchIconState(),
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (state == FancyRecorderState.start)
              Padding(
                padding: EdgeInsets.only(top: 80.h),
                child: TextButton(
                  onPressed: () async {
                    FilePickerResult? picker = await FilePicker.platform
                        .pickFiles(type: FileType.audio);

                    if (picker != null) {
                      audioUri = Uri.tryParse(picker.files.first.path!);
                      state = FancyRecorderState.recorded;
                      setState(() {});
                    }
                  },
                  child: const HexText('Select Audio'),
                ),
              ),
            if (audioUri != null)
              Padding(
                padding: EdgeInsets.only(right: 8.h, left: 20.h, top: 40.h),
                child: HexButton(
                  'PROCEED',
                  rightIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_right_alt_rounded,
                        size: 30.h,
                        color: AppColors.white,
                      )
                    ],
                  ),
                  buttonColor: Colors.purple,
                  height: 60,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.white,
                  borderColor: AppColors.black,
                  borderRadius: 10.h,
                  onPressed: () async {
                    push(
                      context,
                      CreatePostScreen(
                        file: await File(audioUri!.path).readAsBytes(),
                        type: 'audio',
                      ),
                    );
                  },
                ),
              ),
          ],
        ));
  }

  void _toggleRecord() async {
    switch (state) {
      case FancyRecorderState.start:
        _startRecord();
        break;
      case FancyRecorderState.recording:
        _stopRecord();
        break;
      case FancyRecorderState.recorded:
        _deleteRecord();
        break;
    }
  }

  IconData _switchIconState() {
    switch (state) {
      case FancyRecorderState.start:
        return Icons.mic_rounded;
      case FancyRecorderState.recording:
        return Icons.stop_rounded;
      case FancyRecorderState.recorded:
        return Icons.refresh_rounded;
    }
  }

  void _startRecord() async {
    state = FancyRecorderState.recording;
    record.start();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime = Duration(seconds: timer.tick);
      if (elapsedTime.inSeconds >= const Duration(minutes: 3).inSeconds) {
        _stopRecord();
      }
    });
  }

  void _stopRecord() async {
    timer?.cancel();
    audioUri = Uri.tryParse(await record.stop() ?? '');
    elapsedTime = const Duration();
    if (audioUri != null) {
      state = FancyRecorderState.recorded;
      if (widget.onRecordComplete != null) {
        widget.onRecordComplete!(audioUri?.path);
      }
    } else {
      state = FancyRecorderState.start;
    }

    setState(() {});
  }

  void _deleteRecord() async {
    try {
      File(audioUri!.path).deleteSync();
    } catch (_) {}
    audioUri = null;
    state = FancyRecorderState.start;
    if (widget.onRecordComplete != null) widget.onRecordComplete!(null);
    setState(() {});
  }
}

enum FancyRecorderState { start, recording, recorded }
