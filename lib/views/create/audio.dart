import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart';
import 'package:hexcelon/views/create/create.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/hex_text.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({super.key});

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String? _localPath;
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  bool _mRecorderIsInited = false;
  double _mSubscriptionDuration = 0;
  StreamSubscription? _recorderSubscription;
  int pos = 0;
  double dbLevel = 0;
  @override
  void initState() {
    _prepareSaveDir();

    super.initState();
    _initAudioRecorder();
    init().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    _mPlayer.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
  }

  void _initAudioRecorder() {
    _audioRecorder = FlutterSoundRecorder();
    _audioRecorder!.openRecorder().then((value) {});
  }

  void _startRecording() async {
    if (!_isRecording) {
      await _audioRecorder!.startRecorder(
        toFile: _localPath,
      );
      setState(() {
        _isRecording = true;
      });
    }
  }

  void _stopRecording() async {
    if (_isRecording) {
      await _audioRecorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    }
  }

  void play() async {
    await _mPlayer.startPlayer(
        fromURI: '$_localPath',
        // codec: Codec,
        whenFinished: () {
          setState(() {});
        });
    setState(() {});
  }

  Future<void> stopPlayer() async {
    await _mPlayer.stopPlayer();
  }

  Future<void> init() async {
    await openTheRecorder();
    _recorderSubscription = _mRecorder.onProgress!.listen((e) {
      setState(() {
        pos = e.duration.inMilliseconds;
        if (e.decibels != null) {
          dbLevel = e.decibels as double;
        }
      });
    });
  }

  Future<Uint8List> getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }

  // -------  Here is the code to playback  -----------------------

  void record(FlutterSoundRecorder? recorder) async {
    await recorder!.startRecorder(codec: _codec, toFile: _mPath);
    setState(() {});
  }

  Future<void> stopRecorder(FlutterSoundRecorder recorder) async {
    await recorder.stopRecorder();
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openRecorder();
    if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  Future<void> setSubscriptionDuration(
      double d) async // v is between 0.0 and 2000 (milliseconds)
  {
    _mSubscriptionDuration = d;
    setState(() {});
    await _mRecorder.setSubscriptionDuration(
      Duration(milliseconds: d.floor()),
    );
  }

  // --------------------- UI -------------------

  Function? getPlaybackFn(FlutterSoundRecorder? recorder) {
    if (!_mRecorderIsInited) {
      return null;
    }
    return recorder!.isStopped
        ? () {
            record(recorder);
          }
        : () {
            stopRecorder(recorder).then((value) => setState(() {}));
          };
  }

  @override
  Widget build(BuildContext context) {
    bool fileHeavy = File(_localPath!).lengthSync() > 100;
    print(File(_localPath!).lengthSync());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              onPressed: () {
                _checkPermission();
                if (_isRecording) {
                  _stopRecording();
                } else {
                  _startRecording();
                }
              },
              iconSize: 48.0,
              color: Colors.red, // Change the icon color here
            ),
            HexText(
              _isRecording ? 'Recording...' : 'Tap to Record',
              fontSize: 24.sp,
            ),
            SizedBox(height: 30.h),
            if (fileHeavy)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _mPlayer.isStopped
                          ? () {
                              play();
                            }
                          : () {
                              stopPlayer().then((value) => setState(() {}));
                            },
                      icon: const Icon(Icons.play_arrow_rounded),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Slider(
                        value: _mSubscriptionDuration,
                        min: 0.0,
                        max: 2000.0,
                        onChanged: setSubscriptionDuration,
                        //divisions: 100
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: Row(
                children: [
                  if (_isRecording)
                    Expanded(
                      child: HexButton(
                        '  STOP  ',
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.stop_rounded,
                              size: 30.h,
                              color: AppColors.red,
                            )
                          ],
                        ),
                        buttonColor: AppColors.white,
                        height: 60,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.red,
                        borderColor: AppColors.red,
                        borderRadius: 10.h,
                        onPressed: () async {
                          bool a = await _checkPermission();
                          if (!a) return;
                          _stopRecording();
                        },
                      ),
                    ),
                  if (!_isRecording && fileHeavy)
                    Expanded(
                      child: HexButton(
                        '  RETRY',
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              size: 30.h,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                        buttonColor: AppColors.white,
                        height: 60,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.primary,
                        borderColor: AppColors.primary,
                        borderRadius: 10.h,
                        onPressed: () async {
                          bool a = await _checkPermission();
                          if (!a) return;
                          _startRecording();
                        },
                      ),
                    ),
                  if (!_isRecording && fileHeavy)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.h),
                        child: HexButton(
                          '  PROCEED  ',
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
                          buttonColor: AppColors.black,
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
                                file: await File(_localPath!).readAsBytes(),
                                type: 'audio',
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  if (!fileHeavy)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.h),
                        child: HexButton(
                          '  RECORD  ',
                          rightIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mic_rounded,
                                size: 30.h,
                                color: AppColors.white,
                              )
                            ],
                          ),
                          buttonColor: AppColors.black,
                          height: 60,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.white,
                          borderColor: AppColors.black,
                          borderRadius: 10.h,
                          onPressed: () {
                            _checkPermission();
                            if (_isRecording) {
                              _stopRecording();
                            } else {
                              _startRecording();
                            }
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioRecorder?.closeRecorder();
    stopRecorder(_mRecorder);
    cancelRecorderSubscriptions();

    // Be careful : you must `close` the audio session when you have finished with it.
    _mRecorder.closeRecorder();
    super.dispose();
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final PermissionStatus status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final PermissionStatus result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    final String path = await _findLocalPath();
    _localPath = '$path${Platform.pathSeparator}song';

    final File savedDir = File(_localPath!);
    final bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    savedDir.writeAsBytesSync([]);
  }

  Future<String> _findLocalPath() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
