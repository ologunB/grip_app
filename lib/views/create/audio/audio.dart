import '../../widgets/hex_text.dart';
import 'audio_recorder_button.dart';

class GripAudioRecorder extends StatelessWidget {
  const GripAudioRecorder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          AudioRecorderButton(),
        ],
      ),
    );
  }
}
