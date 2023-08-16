import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart';
import 'package:hexcelon/views/create/create.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/hex_text.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({super.key});

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  bool _isRecording = false;
  String _localPath = '';
  final FlutterSoundPlayer _mPlayer =
      FlutterSoundPlayer(logLevel: Level.nothing);
  final FlutterSoundRecorder _mRecorder =
      FlutterSoundRecorder(logLevel: Level.nothing);
  Codec _codec = Codec.aacMP4;
  bool _mRecorderIsInitiated = false;
  StreamSubscription? _recorderSubscription, playerStreamSub;
  int pos = 0;
  double dbLevel = 0;
  @override
  void initState() {
    _prepareSaveDir();

    super.initState();
    _initAudioRecorder();
    init().then((value) {
      setState(() {
        _mRecorderIsInitiated = true;
      });
    });
    _mPlayer.openPlayer().then((value) {
      setState(() {});
    });
  }

  void _initAudioRecorder() {
    _mRecorder.openRecorder().then((value) {});
  }

  void _startRecording() async {
    if (!_isRecording) {
      await _mRecorder.startRecorder(toFile: _localPath);
      setState(() {
        _isRecording = true;
      });
    }
  }

  void _stopRecording() async {
    if (_isRecording) {
      await _mRecorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    }
  }

  void play() async {
    await _mPlayer.startPlayer(
        fromURI: _localPath,
        // codec: Codec,
        whenFinished: () {
          setState(() {});
        });
    setState(() {});
  }

  Future<void> stopPlayer() async {
    await _mPlayer.stopPlayer();
  }

  int a = 0;
  Future<void> init() async {
    try {
      await openTheRecorder();
    } catch (e) {
      print(e);
    }

    _recorderSubscription = _mRecorder.onProgress!.listen((e) {
      print(e);
      setState(() {
        pos = e.duration.inMilliseconds;
        if (e.decibels != null) {
          dbLevel = e.decibels as double;
        }
      });
    });
  }

  // -------  Here is the code to playback  -----------------------

  Future<void> stopRecorder(FlutterSoundRecorder recorder) async {
    await recorder.stopRecorder();
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
      playerStreamSub!.cancel();
      playerStreamSub = null;
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
      if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInitiated = true;
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

    _mRecorderIsInitiated = true;
  }

  Future<void> setSubscriptionDuration(double d) async {
    setState(() {});
    await _mPlayer.setSubscriptionDuration(Duration(milliseconds: d.floor()));
  }

  // --------------------- UI -------------------

  Function? getPlaybackFn(FlutterSoundRecorder? recorder) {
    if (!_mRecorderIsInitiated) {
      return null;
    }
    return recorder!.isStopped
        ? () {
            _startRecording();
          }
        : () {
            stopRecorder(recorder).then((value) => setState(() {}));
          };
  }

  @override
  Widget build(BuildContext context) {
    bool fileHeavy = File(_localPath).lengthSync() > 100;
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
            if (fileHeavy && !_isRecording)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _mPlayer.isStopped
                          ? () async {
                              play();
                            }
                          : () {
                              stopPlayer().then((value) => setState(() {}));
                            },
                      icon: Icon(_mPlayer.isPlaying
                          ? Icons.stop_rounded
                          : Icons.play_arrow_rounded),
                    ),
                    SizedBox(width: 10.h),
                    Expanded(
                      child: StreamBuilder<PlaybackDisposition>(
                          stream: _mPlayer.onProgress,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) const SizedBox.shrink();
                            return Slider(
                              min: 0,
                              value: snapshot.data?.position.inMilliseconds
                                      .toDouble() ??
                                  0,
                              max: snapshot.data?.duration.inMilliseconds
                                      .toDouble() ??
                                  0,
                              onChanged: (a) {
                                setSubscriptionDuration(a);
                              },
                              //divisions: 100
                            );
                          }),
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
                              size: 24.h,
                              color: AppColors.black,
                            )
                          ],
                        ),
                        buttonColor: AppColors.white,
                        height: 60,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.black,
                        borderColor: AppColors.black,
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
                                file: await File(_localPath).readAsBytes(),
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
    _mRecorder.closeRecorder();
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

    final File savedDir = File(_localPath);
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
