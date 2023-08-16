import 'package:hexcelon/views/create/create.dart';
import 'package:image/image.dart' as img;
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/hex_text.dart';
import 'audio.dart';

class ChooseMediaScreen extends StatefulWidget {
  const ChooseMediaScreen({super.key});

  @override
  State<ChooseMediaScreen> createState() => _ChooseMediaScreenState();
}

List<CameraDescription> cameras = <CameraDescription>[];

class _ChooseMediaScreenState extends State<ChooseMediaScreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff191919),
      body: Column(
        children: [
          Container(
            color: const Color(0xff191919),
            padding: EdgeInsets.all(25.h),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'close'.png,
                          height: 24.h,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          _cameraController?.setFlashMode(FlashMode.always);
                        },
                        child: Image.asset(
                          'flash'.png,
                          height: 24.h,
                        ),
                      ),
                      SizedBox(width: 30.h),
                      InkWell(
                        onTap: () {
                          if (_cameraController?.description == cameras[0]) {
                            _cameraController?.setDescription(cameras[1]);
                          } else {
                            _cameraController?.setDescription(cameras[0]);
                          }
                        },
                        child: Image.asset(
                          'turn'.png,
                          height: 24.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
          Expanded(
              child: currentIndex == 0
                  ? const AudioRecorder()
                  : const PhotoCamera()),
          Container(
            color: const Color(0xff191919),
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          currentIndex = 0;
                          setState(() {});
                        },
                        child: HexText(
                          'Audio',
                          fontSize: 16.sp,
                          color: currentIndex == 0 ? Colors.white : Colors.grey,
                          align: TextAlign.center,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 35.h),
                      InkWell(
                        onTap: () {
                          currentIndex = 1;
                          setState(() {});
                        },
                        child: HexText(
                          'Photo',
                          fontSize: 16.sp,
                          color: currentIndex == 1 ? Colors.white : Colors.grey,
                          align: TextAlign.center,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 35.h),
                      InkWell(
                        onTap: () {
                          currentIndex = 2;
                          setState(() {});
                        },
                        child: HexText(
                          'Video',
                          fontSize: 16.sp,
                          color: currentIndex == 2 ? Colors.white : Colors.grey,
                          align: TextAlign.center,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTapUp: (a) {
                          _childColor = null;
                          setState(() {});
                          takePicture().then((File? file) async {
                            if (mounted) {
                              Uint8List? editedImage = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageEditor(
                                    image: flipAndConvertToBytes(file!),
                                    features: const ImageEditorFeatures(
                                      captureFromCamera: false,
                                      crop: true,
                                      pickFromGallery: true,
                                      blur: true,
                                      brush: true,
                                      emoji: true,
                                      filters: true,
                                      flip: true,
                                      rotate: true,
                                      text: true,
                                    ),
                                  ),
                                ),
                              );
                              if (editedImage != null) {
                                push(
                                  context,
                                  CreatePostScreen(
                                    file: editedImage,
                                  ),
                                );
                              }
                            }
                          });
                        },
                        onTapDown: (a) {
                          _childColor = Colors.grey;
                          setState(() {});
                        },
                        child: Image.asset(
                          'take'.png,
                          height: 65.h,
                          color: _childColor,
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 58.h),
                              child: InkWell(
                                onTap: () async {
                                  final XFile? file = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (file != null) {
                                    final editedImage = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageEditor(
                                          image:
                                              File(file.path).readAsBytesSync(),
                                        ),
                                      ),
                                    );
                                    if (editedImage != null) {
                                      push(
                                        context,
                                        CreatePostScreen(
                                          file: editedImage,
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Image.asset(
                                  'pick'.png,
                                  height: 33.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  HexText(
                    'Post\n●',
                    fontSize: 16.sp,
                    color: Colors.white,
                    align: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Color? _childColor;

  Future<File?> takePicture() async {
    final CameraController? cameraController = _cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      // showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final file = await cameraController.takePicture();
      return File(file.path);
    } on CameraException {
      // showInSnackBar('Error: ${e.code}\n${e.description}');
      return null;
    }
  }

  Uint8List flipAndConvertToBytes(File originalImageFile) {
    final originalBytes = originalImageFile.readAsBytesSync();
    final originalImage = img.decodeImage(Uint8List.fromList(originalBytes))!;

    final flippedImage = img.copyFlip(
      originalImage,
      direction: img.FlipDirection.horizontal,
    ); // Flip the image

    return Uint8List.fromList(img.encodePng(flippedImage)); // Convert to bytes
  }
}

CameraController? _cameraController;

class PhotoCamera extends StatefulWidget {
  const PhotoCamera({super.key});

  @override
  State<PhotoCamera> createState() => _PhotoCameraState();
}

class _PhotoCameraState extends State<PhotoCamera>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  File? imageFile;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

  @override
  void initState() {
    _initializeCameraController();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.setFlashMode(FlashMode.off);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController();
    }
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = _cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Center(child: HexProgress());
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.scale(
          scale: 1,
          alignment: Alignment.topCenter,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(0),
            child: CameraPreview(cameraController),
          ),
        ),
        Listener(
          onPointerDown: (_) => _pointers++,
          onPointerUp: (_) => _pointers--,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onScaleStart: _handleScaleStart,
                onScaleUpdate: _handleScaleUpdate,
                onTapDown: (TapDownDetails details) => onViewFinderTap(
                  details,
                  constraints,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (_cameraController == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await _cameraController!.setZoomLevel(_currentScale);
  }

  void showInSnackBar(String message) {}

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (_cameraController == null) {
      return;
    }

    final CameraController cameraController = _cameraController!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Future<void> _initializeCameraController() async {
    final CameraController cameraController = CameraController(
      cameras[1],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _cameraController = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);
      await cameraController.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;
        default:
          showInSnackBar('Error: ${e.code}\n${e.description}');
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _cameraPreviewWidget();
  }
}
